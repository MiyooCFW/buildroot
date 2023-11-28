#!/bin/busybox sh
st_error_func(){
	st -k -e "/bin/sh" "-c" "echo -e \"\e[31m${1}\e[0m\"; sleep 2"
}
st_exec_func(){
	st -k -e "/bin/sh" "-c" "${1}"
}

MUSB_MODE=$(cat /sys/devices/platform/soc/1c13000.usb/musb-hdrc.1.auto/mode)
if ! (test "${MUSB_MODE}" = "b_peripheral"); then
	st_error_func "\n\n\n\n\n\n\n\n         First connect handheld to device!"
	exit
else
	gadget-vid-pid-remove 0x1d6b:0x0104
	gadget-hid

	st_exec_func "\
	echo -e \"\e[32m\n\n\n\n\n\n               Starting USB-HID mode\e[0m\n\n\n\"; \
	sleep 1; \
	python /mnt/apps/usb-hid/usb-hid.py"

	gadget-vid-pid-remove 0x1d6b:0x0104
	gadget-ms /dev/mmcblk0p1 /dev/mmcblk0p4
fi
