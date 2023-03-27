#!/bin/bash
set -e
export IMAGE_NAME=${2}
STARTDIR=`pwd`
SELFDIR=`dirname \`realpath ${0}\``

cp -r board/miyoo/boot "${BINARIES_DIR}"
cp -r board/miyoo/main "${BINARIES_DIR}"
mkdir -p "${BINARIES_DIR}/gmenu2x"
cp -r "${BINARIES_DIR}/gmenu2x" "${BINARIES_DIR}/main/"
support/scripts/genimage.sh ${1} -c board/miyoo/genimage-sdcard.cfg
