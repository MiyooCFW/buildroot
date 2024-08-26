#!/bin/bash
set -e

BR2_VENDOR=${2}
BR2_VERSION_FULL=${3}
LIBC=${4}
STARTDIR=$(pwd)
SELFDIR=$(dirname $(realpath ${0}))

# Generate CFW release tag, status and append iteration count
if test $(git tag | wc -l) -ne 0; then
	BR2_TAG="$(git describe --tags --always --abbrev=0)"
	BR2_ITERATION="$(git rev-list --count ${BR2_TAG}..HEAD)"
fi

BR2_HASH="$(git rev-parse --short HEAD)" # not using print-version from BR2_VERSION_FULL
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

export IMAGE_NAME="${BR2_VENDOR}-${CFW_TYPE}-${CFW_RELEASE}-${CFW_HASH}_${LIBC}-${STATUS}${APPEND_VERSION}.img"

# Relocate board files for genimage-sdcard config to read (see last cmd)
cp -r board/miyoo/boot "${BINARIES_DIR}"
cp -r board/miyoo/main "${BINARIES_DIR}"

# Write CFW version to splash image
convert board/miyoo/miyoo-splash.png -pointsize 12 -fill white -annotate +10+230 "v${CFW_RELEASE} ${CFW_VERSION} (${LIBC}) ${STATUS}${APPEND_VERSION}" -type Palette -colors 224 -depth 8 -compress none -verbose BMP3:"${BINARIES_DIR}"/boot/miyoo-splash.bmp

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
			CORE_FILE="$(echo "$file" | sed 's/.*\///')"
			CORE_NAME="$(echo "${CORE_FILE}" | sed 's/_libretro.so//g')"
			CORE_SCRIPT="${CORE_NAME}.sh"
			touch $RA_WDIR/"${CORE_SCRIPT}"
			echo -e "#!/bin/sh\n/mnt/emus/retroarch/retroarch -L ${CORE_FILE} \"\$1\"" > $RA_WDIR/"${CORE_SCRIPT}"
			chmod +x $RA_WDIR/"${CORE_SCRIPT}"
			# RA_LDIR="${BINARIES_DIR}/main/gmenu2x/sections/cores"
			# CORE_LINK="zblank.${CORE_NAME}.ra"
			# touch $RA_LDIR/"${CORE_LINK}"
			# echo -e "title=${CORE_NAME}\ndescription=${CORE_NAME} libretro core\nexec=/mnt/emus/retroarch/${CORE_SCRIPT}\nselectordir=/mnt" > $RA_LDIR/"${CORE_LINK}"
		fi
	done
fi

# Generate MAIN BTRFS partition
image="${BINARIES_DIR}/main.img"
label="MAIN"
mkfs.btrfs -r "${BINARIES_DIR}/main/" --shrink -v -f -L ${label} ${image}

support/scripts/genimage.sh ${1} -c board/miyoo/genimage-sdcard.cfg
