#!/bin/busybox sh

st -k -e "/bin/sh" "-c" "echo -e \"Acquiring ip address from DHCP, please wait...\"; sleep 2"
ln -s /run /var/lib/dhcp
dhclient

