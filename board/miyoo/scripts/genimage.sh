#!/bin/bash
set -e
STARTDIR=`pwd`
SELFDIR=`dirname \`realpath ${0}\``

#MKIMAGE="${HOST_DIR}/bin/mkimage"
#BOOT_CMD="boot.cmd"
#OUTPUT_NAME="boot.scr"

cp -r board/miyoo/boot/ "${BINARIES_DIR}"
cp -r board/miyoo/main/ "${BINARIES_DIR}"
#cd "${BINARIES_DIR}"
#"${MKIMAGE}" -f boot/${BOOT_CMD} ${OUTPUT_NAME}
#rm boot/${BOOT_CMD}


#cp board/allwinner/generic/kernel.its "${BINARIES_DIR}"
#cd "${BINARIES_DIR}"
#"${MKIMAGE}" -f ${IMAGE_ITS} ${OUTPUT_NAME}
#rm ${IMAGE_ITS}

cd "${SELFDIR}/../"
#cp splash.bmp "${BINARIES_DIR}/"

cd "${STARTDIR}/"


support/scripts/genimage.sh ${1} -c board/miyoo/genimage-sdcard.cfg
