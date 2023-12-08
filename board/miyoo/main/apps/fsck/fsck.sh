#!/bin/sh

sync

echo " "
echo "Checking FAT filesystem..."
echo " "
sleep 2

if dmesg | grep "mmcblk0p1"; then
echo -e "\e[31mUnclean shutdown detected.\e[0m"
echo -e "\e[32mChecking FAT32 (BOOT) partition...\e[0m" 
fsck.vfat -a /dev/mmcblk0p1
fi

echo "Finished!"
echo " "
echo " "
sync
read -t 2
sleep 1
