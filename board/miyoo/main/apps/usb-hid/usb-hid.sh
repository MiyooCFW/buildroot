#!/bin/busybox sh
/usr/bin/st -k -e /mnt/apps/usb-hid/_usb-hid.sh
gadget-vid-pid-remove 0x1d6b:0x0104
gadget-ms /dev/mmcblk0p1 /dev/mmcblk0p4
