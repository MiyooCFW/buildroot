#!/bin/bash

ROOTFS_PATH="${TARGET_DIR}"

mkdir -p ${ROOTFS_PATH}/var/lib/opkg/info
VAR_OPKG="${ROOTFS_PATH}/var/lib/opkg"

# make -s printvars VARS=PACKAGES_TARGET
PKGS_ARRAY=("${@:5}")
PKGS="${PKGS_ARRAY[*]}"
echo "Current configuration suggest to install following pkgs to TARGET:" && echo "${PKGS}"

for i in "${!PKGS_ARRAY[@]}"; do
	echo -e \
"Package: "${PKGS_ARRAY[i]}"\n\
Version: Unknown\n\
Status: install ok installed\n\
Architecture: arm\n" >> ${VAR_OPKG}/status
	touch ${VAR_OPKG}/info/${PKGS_ARRAY[i]}.list
done

sleep 2
