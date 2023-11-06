#!/bin/bash
set -e
export IMAGE_NAME=${2}
STARTDIR=`pwd`
SELFDIR=`dirname \`realpath ${0}\``
CFW_RELEASE="2.0.0"
BR2_HASH=`git rev-parse --short HEAD`
LIBC=${3}

cp -r board/miyoo/boot "${BINARIES_DIR}"
cp -r board/miyoo/main "${BINARIES_DIR}"
mkdir -p "${BINARIES_DIR}/gmenu2x"
cp -r "${BINARIES_DIR}/gmenu2x" "${BINARIES_DIR}/main/"
if test "$CFW_HASH" == "$BR2_HASH"; then
	CFW_VERSION="BR2=${BR2_HASH}"
else
	CFW_VERSION="CFW=${CFW_HASH}"
fi
convert board/miyoo/miyoo-boot.png -pointsize 12 -fill white -annotate +10+230 "v${CFW_RELEASE} ${CFW_VERSION} (${LIBC})" -alpha off -type truecolor -strip -define bmp:format=bmp4 -define bmp:subtype=RGB565 "${BINARIES_DIR}"/boot/miyoo-boot.bmp
support/scripts/genimage.sh ${1} -c board/miyoo/genimage-sdcard.cfg
