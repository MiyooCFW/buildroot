#!/bin/bash

# NOTES: 
# - run this script from $TOPDIR
# - `merge_config.sh` allows up to 2 extra fragment configs.

usage() {
	echo "Usage: $0 [DEFCONFIG]"
	echo "  	-h    display this help text"
	echo
	echo "	NOTES: Run this script from BR2's \$TOPDIR. After successfull run,
    	execute \"make\" for external SDK usage placed at /opt/miyoo ."
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
FRAGMENTS_RPATH="board/miyoo/extconfig"
if grep -iq "musl" "${DEFCONFIGS_RPATH}"/${1}; then
	LIBC=musl
elif grep -iq "glibc" "${DEFCONFIGS_RPATH}"/${1}; then
	#LIBC=glibc
	echo "WARNING: Sorry glibc is not supported ATM..."
	exit 1
else #default
	LIBC=uclibc
fi
FRAGMENT_CONFIG1=${FRAGMENTS_RPATH}/external-sdk-fragment.config
FRAGMENT_CONFIG2=${FRAGMENTS_RPATH}/external-${LIBC}-fragment.config

support/kconfig/merge_config.sh ${DEFCONFIGS_RPATH="configs"}/"${1}" "${FRAGMENT_CONFIG1}" "${FRAGMENT_CONFIG2}"

# RUN: make
