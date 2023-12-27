#!/bin/bash
set -e
CFW_RELEASE="2.0.0"
STATUS="BETA"
BR2_VENDOR=${2}
BR2_VERSION_FULL=${3}
LIBC=${4}
export IMAGE_NAME="${BR2_VENDOR}-cfw-${CFW_RELEASE}${BR2_VERSION_FULL}_${LIBC}-${STATUS}.img"
STARTDIR=`pwd`
SELFDIR=`dirname \`realpath ${0}\``

# Relocate board files for genimage-sdcard config to read (see last cmd)
cp -r board/miyoo/boot "${BINARIES_DIR}"
cp -r board/miyoo/main "${BINARIES_DIR}"

# Workaround for build apss and configs being placed in /usr/ after img generation (as we use MAIN)
test -d "${BINARIES_DIR}/gmenu2x" && cp -r "${BINARIES_DIR}/gmenu2x/" "${BINARIES_DIR}/main/"
test -d "${BINARIES_DIR}/emus" && cp -r "${BINARIES_DIR}/emus/" "${BINARIES_DIR}/main/"
if test -d "${BINARIES_DIR}/retroarch";then
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

# BR2 Version is tracked by git
BR2_HASH=$(echo $BR2_VERSION_FULL | sed 's/^[-]g//')
if (test "$CFW_HASH" == "$BR2_HASH" || test -z "$CFW_HASH"); then
	CFW_VERSION="BR2=${BR2_HASH}"
else
	CFW_VERSION="CFW=${CFW_HASH}"
fi

# Write CFW version to splash image
convert board/miyoo/miyoo-boot.png -pointsize 12 -fill white -annotate +10+230 "v${CFW_RELEASE} ${CFW_VERSION} (${LIBC}) ${STATUS}" -alpha off -type truecolor -strip -define bmp:format=bmp4 -define bmp:subtype=RGB565 "${BINARIES_DIR}"/boot/miyoo-boot.bmp
convert board/miyoo/miyoo-boot.png -pointsize 12 -fill white -annotate +10+230 "v${CFW_RELEASE} ${CFW_VERSION} (${LIBC}) ${STATUS}" -type Palette -colors 224 -depth 8 -compress none -verbose BMP3:"${BINARIES_DIR}"/boot/miyoo-splash.bmp

# Generate MAIN BTRFS partition
image="${BINARIES_DIR}/main.img"
label="MAIN"
sudo mkfs.btrfs -r "${BINARIES_DIR}/main/" --shrink -v -f -L ${label} ${image}

support/scripts/genimage.sh ${1} -c board/miyoo/genimage-sdcard.cfg
