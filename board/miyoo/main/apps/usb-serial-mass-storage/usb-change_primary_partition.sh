#!/bin/busybox sh

LUN_DIR=/sys/devices/platform/soc/1c13000.usb/musb-hdrc.1.auto/gadget

if (grep -q mmcblk0p1 "${LUN_DIR}/lun0/file"); then
echo /dev/mmcblk0p4 >  "${LUN_DIR}/lun0/file"
echo /dev/mmcblk0p1 >  "${LUN_DIR}/lun1/file"
elif (grep -q mmcblk0p4 "${LUN_DIR}/lun0/file"); then
echo /dev/mmcblk0p1 >  "${LUN_DIR}/lun0/file"
echo /dev/mmcblk0p4 >  "${LUN_DIR}/lun1/file"
else
sleep 2
echo " "
echo "No FAT partition assigned to LUN!"
echo " "
fi
