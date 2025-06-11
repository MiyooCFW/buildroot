#!/bin/busybox sh

echo 0 > /sys/class/graphics/fbcon/cursor_blink
python /mnt/apps/gstreamer/gst.py $1
