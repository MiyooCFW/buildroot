#!/bin/busybox sh
st -k -e "/bin/sh" "-c" "echo -e \"Starting USB network, please wait...\"; sleep 2"

MAC_HOST="12:34:56:78:9a:bd"
MAC_DEV="12:34:56:78:9a:bc"

echo peripheral > /sys/devices/platform/soc/1c13000.usb/musb-hdrc.1.auto/mode
modprobe -r g_serial
killall umtprd umtprd-debug
/mnt/apps/usb-mtd/remove.sh g2
sleep 1

mount none /sys/kernel/config -t configfs
mkdir /sys/kernel/config/usb_gadget/g2
cd /sys/kernel/config/usb_gadget/g2
mkdir configs/c.1
mkdir strings/0x409

mkdir functions/rndis.usb0
mkdir configs/c.1/strings/0x409

echo 0x0104 > idProduct
echo 0x1D6B > idVendor
echo "0x0200" > bcdUSB
echo "0x02" > bDeviceClass
echo "0x00" > bDeviceSubClass
echo "0x3066" > bcdDevice
echo "1" > os_desc/use
echo "0xcd" > os_desc/b_vendor_code
echo "MSFT100" > os_desc/qw_sign
echo "RNDIS" > functions/rndis.usb0/os_desc/interface.rndis/compatible_id
echo "5162001" > functions/rndis.usb0/os_desc/interface.rndis/sub_compatible_id

echo $MAC_HOST > functions/rndis.usb0/host_addr
echo $MAC_DEV > functions/rndis.usb0/dev_addr

echo "Miyoo Handheld" > strings/0x409/manufacturer
echo "Miyoo CFW 2.0" > strings/0x409/product

echo "Conf 1" > configs/c.1/strings/0x409/configuration
echo 120 > configs/c.1/MaxPower
ln -s functions/rndis.usb0 configs/c.1
ln -s configs/c.1 os_desc
sleep 1

#ls /sys/class/udc/ > /sys/kernel/config/usb_gadget/g2/UDC
#sleep 5
#echo "" > UDC

echo "0x00" > bDeviceClass
ls /sys/class/udc/ > /sys/kernel/config/usb_gadget/g2/UDC

ifconfig usb0 up 192.168.137.1
sleep 10
/etc/init.d/S80dhcp-server restart
