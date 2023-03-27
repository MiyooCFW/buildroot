#!/bin/bash
set -e
export IMAGE_NAME=${2}
STARTDIR=`pwd`
SELFDIR=`dirname \`realpath ${0}\``

cp -r board/miyoo/boot "${BINARIES_DIR}"
cp -r board/miyoo/main "${BINARIES_DIR}"
support/scripts/genimage.sh ${1} -c board/miyoo/genimage-sdcard.cfg
