#!/bin/busybox sh
echo host  > /sys/devices/platform/soc/1c13000.usb/musb-hdrc.1.auto/mode
sleep 2

modprobe evdev
modprobe joydev
modprobe analog
modprobe xpad
modprobe atkbd
modprobe uinput
modprobe psmouse
modprobe synaptics_usb
modprobe mousedev
modprobe usbhid
modprobe hid-generic
modprobe hid