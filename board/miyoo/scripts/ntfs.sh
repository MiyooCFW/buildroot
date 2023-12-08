#!/bin/bash

image="${BINARIES_DIR}/main.img"
label="MAIN"
mntdir=`mktemp -d`

dd status=progress if=/dev/zero of=$image bs=5M count=128 && sync

LOOPMOUNT=`sudo losetup --show --find ${image}`
sudo mkfs.ntfs -Q -v -F -L ${label} ${image}
sudo mount ${LOOPMOUNT} ${mntdir}
sudo rsync -avzh "${BINARIES_DIR}/main/" ${mntdir}
sudo umount ${mntdir}
sudo losetup -d ${LOOPMOUNT}