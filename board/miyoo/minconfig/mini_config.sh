#!/bin/bash

# NOTES: 
# - run this script from $TOPDIR
# - `merge_config.sh` allows up to 2 extra fragment configs.

DEFCONFIGS_RPATH="configs"
FRAGMENTS_RPATH="board/miyoo/minconfig"
FRAGMENT_CONFIG1=${FRAGMENTS_RPATH}/min-pkgs-fragment.config
FRAGMENT_CONFIG2=${FRAGMENTS_RPATH}/rootfs-size-fragment.config

support/kconfig/merge_config.sh ${DEFCONFIGS_RPATH="configs"}/"${1}" "${FRAGMENT_CONFIG1}" "${FRAGMENT_CONFIG2}"

# RUN: make MINIMAL="yes"
