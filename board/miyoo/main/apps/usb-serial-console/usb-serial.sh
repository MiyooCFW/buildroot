#!/bin/busybox sh
echo peripheral > /sys/devices/platform/soc/1c13000.usb/musb-hdrc.1.auto/mode
killall umtprd umtprd-debug
modprobe g_serial
