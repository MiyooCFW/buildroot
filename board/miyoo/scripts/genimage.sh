#!/bin/bash
set -e

BR2_VENDOR=${2}
BR2_VERSION_FULL=${3}
LIBC=${4}
MINIMAL="${9}"
STARTDIR=$(pwd)
SELFDIR=$(dirname $(realpath ${0}))

MAIN_SIZE=1500M
ROMS_SIZE=1G
#SWAP_SIZE=256M # swap size is called from genimage-sdcard.cfg in BOARD
#ROOTFS_SIZE=256M # rootfs ext2 size is called from defconfig in BOARD
if test "$MINIMAL" == "yes"; then
	MAIN_SIZE=128M
	ROMS_SIZE=256M
	SWAP_SIZE=16M
	#ROOTFS_SIZE=160M # rootfs ext2 size is called from either fragment.defconfig or env variable (invoked in make)
	BUILD_TYPE="MINIMAL-"
fi

# Generate CFW release tag, status and append iteration count
if test $(git tag | wc -l) -ne 0; then
	BR2_TAG="$(git describe --tags --always --abbrev=0)"
	BR2_ITERATION="$(git rev-list --count ${BR2_TAG}..HEAD)"
fi

if git diff-index --quiet HEAD; then
	BR2_HASH="$(git rev-parse --short HEAD)" # not using print-version from BR2_VERSION_FULL
else
	BR2_HASH="dirty"
fi
if (test "$CFW_HASH" == "$BR2_HASH" || test -z "$CFW_HASH"); then
	CFW_TYPE="br2_dist"
	CFW_HASH="$BR2_HASH"
	CFW_VERSION="BR2=${BR2_HASH}"
	GIT_TAG="$BR2_TAG"
	ITERATION_VERSION="$BR2_ITERATION"
else
	CFW_TYPE="cfw"
	CFW_VERSION="CFW=${CFW_HASH}"
	GIT_TAG="$CFW_TAG"
	ITERATION_VERSION="$CFW_ITERATION"
fi

if test -n "$GIT_TAG"; then
	CFW_RELEASE="$(echo ${GIT_TAG} | sed 's/-.*//')"
	STATUS="$(echo ${GIT_TAG} | sed 's/^[^-]*-//' | tr '[:lower:]' '[:upper:]' | tr '-' 'v')"
	if test $ITERATION_VERSION -eq 0; then
		APPEND_VERSION=""
		if test "$STATUS" == "$CFW_RELEASE"; then STATUS="STABLE"; fi
	else
		if [[ "$(echo ${STATUS} | sed 's/^[^-]*v//')" =~ ^-?[0-9]+$ ]]; then
			APPEND_VERSION="v$(echo ${STATUS} | sed 's/^[^-]*v//' | expr $(cat -) + 1)${APPEND_VERSION}"
			STATUS="$(echo ${STATUS} | sed 's/v.*//')"
		elif test -n "$STATUS" ; then
			STATUS="${STATUS}v2"
		fi
		if test "$STATUS" == "$CFW_RELEASE"; then
			STATUS="BETA"
			CFW_RELEASE="$(echo ${CFW_RELEASE} | sed 's/[0-9]$//')$(echo ${CFW_RELEASE} | grep -oE '[0-9]+$' | expr $(cat -) + 1)"
		fi
		APPEND_VERSION="${APPEND_VERSION}-n${ITERATION_VERSION}"
	fi
else
	CFW_RELEASE="0.0.0"
	STATUS="UNKNOWN"
fi

export IMAGE_NAME="${BR2_VENDOR}-${CFW_TYPE}-${CFW_RELEASE}-${CFW_HASH}_${LIBC}-${BUILD_TYPE}${STATUS}${APPEND_VERSION}.img"

# Relocate board files for genimage-sdcard config to read (see last cmd)
cp -r board/miyoo/boot "${BINARIES_DIR}"
cp -r board/miyoo/main "${BINARIES_DIR}"
cp -r board/miyoo/roms "${BINARIES_DIR}"

# Write CFW version to splash image
convert board/miyoo/miyoo-splash.png -pointsize 12 -fill white -annotate +10+230 "v${CFW_RELEASE} ${CFW_VERSION} (${LIBC}) ${BUILD_TYPE}${STATUS}${APPEND_VERSION}" -type Palette -colors 224 -depth 8 -compress none -verbose BMP3:"${BINARIES_DIR}"/boot/miyoo-splash.bmp

# Workaround for build apss and configs being placed in /usr/ after img generation (as we use MAIN)
test -d "${BINARIES_DIR}/gmenu2x" && cp -r "${BINARIES_DIR}/gmenu2x/" "${BINARIES_DIR}/main/"
test -d "${BINARIES_DIR}/emus" && cp -r "${BINARIES_DIR}/emus/" "${BINARIES_DIR}/main/"
test -d "${BINARIES_DIR}/apps" && cp -r "${BINARIES_DIR}/apps/" "${BINARIES_DIR}/main/"
test -d "${BINARIES_DIR}/games" && cp -r "${BINARIES_DIR}/games/" "${BINARIES_DIR}/main/"
if test -d "${BINARIES_DIR}/retroarch"; then
	rsync -avzh "${BINARIES_DIR}/retroarch/" "${BINARIES_DIR}/main/.retroarch/"
	## Generate list of cores to be used
	CORES_DIR="${BINARIES_DIR}/retroarch/cores"
	for file in $CORES_DIR/*; do
		if test -f "$file"; then
			RA_WDIR="${BINARIES_DIR}/main/emus/retroarch"
			RA_TDIR="/mnt/emus/retroarch"
			CORE_FILE="$(echo "$file" | sed 's/.*\///')"
			CORE_NAME="$(echo "${CORE_FILE}" | sed 's/_libretro.so//g')"
			CORE_SCRIPT="${CORE_NAME}.sh"
			touch $RA_WDIR/"${CORE_SCRIPT}"
			echo -e "#!/bin/sh\n${RA_TDIR}/retroarch -L ${CORE_FILE} \"\$1\" \"\$2\"" > $RA_WDIR/"${CORE_SCRIPT}"
			chmod +x $RA_WDIR/"${CORE_SCRIPT}"
			# sanity check if there's an existing link in gmenu2x
			RA_LDIR="${BINARIES_DIR}/main/gmenu2x/sections/cores"
			if ! test -f "${RA_LDIR}"/*".${CORE_NAME}.ra"; then
				CORE_LINK="zblank.${CORE_NAME}.ra"
				touch "${RA_LDIR}"/"${CORE_LINK}"
				echo -e "title=${CORE_NAME}\ndescription=${CORE_NAME} libretro core\nexec=${RA_TDIR}/${CORE_SCRIPT}\nselectordir=/mnt\nparams=--appendconfig=${RA_TDIR}/retroarch_menu.cfg" > "${RA_LDIR}"/"${CORE_LINK}"
			fi
		fi
	done
fi

# Generate MAIN BTRFS partition
image="${BINARIES_DIR}/main.img"
label="MAIN"
mkfs.btrfs -r "${BINARIES_DIR}/main/" -b ${MAIN_SIZE} -v -f -L ${label} ${image} # hardcoded value and should be enough for extra exec/libs 1G def + 500MB extra in MAIN

# Generate ROMS EXT4 partition (dir at mount point is created at prebuild script)
image_roms="${BINARIES_DIR}/roms.img"
label_roms="ROMS"
dd if=/dev/zero of=${image_roms} bs=${ROMS_SIZE} count=1 # for fatresize we need part. size bigger than 256M, but for backup space at least 1G is need in ROMS (copy of main)
mkfs.ext4 -d "${BINARIES_DIR}/roms/" -v -L ${label_roms} ${image_roms}

if test "$MINIMAL" == "yes"; then
	tmpcfg=$(mktemp)
	sed "s|size = 256M|size = ${SWAP_SIZE}|g" board/miyoo/genimage-sdcard.cfg >> ${tmpcfg}
	support/scripts/genimage.sh ${1} -c ${tmpcfg}
else
	support/scripts/genimage.sh ${1} -c board/miyoo/genimage-sdcard.cfg
fi
