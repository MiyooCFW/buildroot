#!/bin/busybox sh
if [ `cat /sys/devices/platform/soc/1c13000.usb/musb-hdrc.1.auto/mode` != "b_peripheral" ]; then
	echo -e "\e[31mFirst connect handheld to device!\e[0m"&>$(tty)
	sleep 2
	exit
fi
gadget-vid-pid-remove 0x1d6b:0x0104
gadget-hid
echo -e "\e[32mStarting USB HID mode...\e[0m"&>$(tty)
python /mnt/apps/usb-hid/usb-hid.py&>$(tty)
gadget-vid-pid-remove 0x1d6b:0x0104
gadget-ms /dev/mmcblk0p1 /dev/mmcblk0p4
