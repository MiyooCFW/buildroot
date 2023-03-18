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

if dmesg | grep "mmcblk0p4"; then
echo -e "\e[31mUnclean shutdown detected.\e[0m"
echo -e "\e[32mChecking FAT32 (MAIN) partition...\e[0m" 
fsck.vfat -a /dev/mmcblk0p4
echo " "
echo "Rebooting device, please wait..."
echo " "
sleep 2
sync
reboot
fi

echo "Finished!"
echo " "
echo " "
sync
read -t 2
sleep 1
