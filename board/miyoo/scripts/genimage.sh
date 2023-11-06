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

cp -r board/miyoo/boot "${BINARIES_DIR}"
cp -r board/miyoo/main "${BINARIES_DIR}"
mkdir -p "${BINARIES_DIR}/gmenu2x"
cp -r "${BINARIES_DIR}/gmenu2x" "${BINARIES_DIR}/main/"

#BR2 Version is tracked by git
BR2_HASH=$(echo $BR2_VERSION_FULL | sed 's/^[-]g//')
if (test "$CFW_HASH" == "$BR2_HASH" || test -z "$CFW_HASH"); then
	CFW_VERSION="BR2=${BR2_HASH}"
else
	CFW_VERSION="CFW=${CFW_HASH}"
fi

convert board/miyoo/miyoo-boot.png -pointsize 12 -fill white -annotate +10+230 "v${CFW_RELEASE} ${CFW_VERSION} (${LIBC}) ${STATUS}" -alpha off -type truecolor -strip -define bmp:format=bmp4 -define bmp:subtype=RGB565 "${BINARIES_DIR}"/boot/miyoo-boot.bmp
support/scripts/genimage.sh ${1} -c board/miyoo/genimage-sdcard.cfg
