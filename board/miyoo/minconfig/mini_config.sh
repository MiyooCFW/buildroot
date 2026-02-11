#!/bin/bash

# NOTES: 
# - run this script from $TOPDIR
# - `merge_config.sh` allows up to 2 extra fragment configs.

usage() {
	echo "Usage: $0 [DEFCONFIG]"
	echo "  	-h    display this help text"
	echo
	echo "	NOTES: Run this script from BR2's \$TOPDIR. After successfull run,
    	execute \"make MINIMAL=yes\" for down-sized image."
	echo
}

while true; do
	case $1 in
	"-h")
		usage
		exit
		;;
	*)
		break
		;;
	esac
done

if [ "$#" -lt 1 ] ; then
	usage
	exit
fi

DEFCONFIGS_RPATH="configs"
FRAGMENTS_RPATH="board/miyoo/minconfig"
FRAGMENT_CONFIG1=${FRAGMENTS_RPATH}/rootfs-size-fragment.config
FRAGMENT_CONFIG2=${FRAGMENTS_RPATH}/min-pkgs-fragment.config

support/kconfig/merge_config.sh ${DEFCONFIGS_RPATH="configs"}/"${1}" "${FRAGMENT_CONFIG1}" "${FRAGMENT_CONFIG2}"

# RUN: make MINIMAL="yes"
