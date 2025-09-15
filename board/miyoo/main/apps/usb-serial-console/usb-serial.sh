#!/bin/busybox sh

echo peripheral > /sys/devices/platform/soc/1c13000.usb/musb-hdrc.1.auto/mode

killall umtprd umtprd-debug
/mnt/apps/usb-mtd/remove.sh g2
mount none /sys/kernel/config -t configfs

mkdir -p /sys/kernel/config/usb_gadget/g2
cd /sys/kernel/config/usb_gadget/g2

mkdir -p configs/c.1
mkdir -p functions/acm.usb0
mkdir -p strings/0x409
mkdir -p configs/c.1/strings/0x409

echo 0x0104 > idProduct                # Produkt: CDC ACM (Serial)
echo 0x1D6B > idVendor                 # Producent: Linux Foundation

echo "Miyoo Handheld" > strings/0x409/manufacturer
echo "Miyoo CFW 2.0" > strings/0x409/product
echo "deadbeef12345678" > strings/0x409/serialnumber

echo "Conf 1" > configs/c.1/strings/0x409/configuration
echo 120 > configs/c.1/MaxPower

ln -s functions/acm.usb0 configs/c.1

sleep 1
ls /sys/class/udc/ > /sys/kernel/config/usb_gadget/g2/UDC

