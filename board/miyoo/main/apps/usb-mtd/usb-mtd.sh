#!/bin/busybox sh

echo peripheral > /sys/devices/platform/soc/1c13000.usb/musb-hdrc.1.auto/mode
modprobe -r g_serial
killall umtprd umtprd-debug
/mnt/apps/usb-mtd/remove.sh g2
mount none /sys/kernel/config -t configfs
mkdir /sys/kernel/config/usb_gadget/g2
cd /sys/kernel/config/usb_gadget/g2
mkdir configs/c.1
mkdir functions/ffs.mtp
mkdir strings/0x409
mkdir configs/c.1/strings/0x409

echo 0x0100 > idProduct
echo 0x1D6B > idVendor

echo "Miyoo Handheld" > strings/0x409/manufacturer
echo "Miyoo CFW 2.0" > strings/0x409/product

echo "Conf 1" > configs/c.1/strings/0x409/configuration
echo 120 > configs/c.1/MaxPower
ln -s functions/ffs.mtp configs/c.1
mkdir /dev/ffs-mtp
mount -t functionfs mtp /dev/ffs-mtp
if (grep -q DEBUG_UMTPR\=\1 "${HOME}/options.cfg"); then
umtprd-debug &
else
umtprd &
fi
sleep 1
ls /sys/class/udc/ > /sys/kernel/config/usb_gadget/g2/UDC

