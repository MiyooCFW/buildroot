#!/bin/bash

ROOTFS_PATH="${TARGET_DIR}"

mkdir -p ${ROOTFS_PATH}/var/lib/opkg/info
VAR_OPKG="${ROOTFS_PATH}/var/lib/opkg"

# make -s printvars VARS=PACKAGES_TARGET
PKGS_ARRAY=(${5})
PKGS="${PKGS_ARRAY[*]}"
PKGS_VERSION_ARRAY=(${6})
PKGS_PKGDIR_ARRAY=(${7})
PKGS_LICENSE_ARRAY=(${8})

echo "Current configuration suggest to install following pkgs to TARGET:" && echo "${PKGS}"

for i in "${!PKGS_ARRAY[@]}"; do
	echo -e \
"Package: "${PKGS_ARRAY[i]}"\n\
Version: "${PKGS_VERSION_ARRAY[i]}"\n\
Source: https://github.com/MiyooCFW/buildroot/"${PKGS_PKGDIR_ARRAY[i]}"\n\
License: "$(echo ${PKGS_LICENSE_ARRAY[i]} | tr '_' ' ')"\n\
Status: install ok installed\n\
Architecture: arm\n" >> ${VAR_OPKG}/status
	touch ${VAR_OPKG}/info/${PKGS_ARRAY[i]}.list
done

sleep 2
