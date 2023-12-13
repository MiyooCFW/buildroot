#!/bin/busybox sh
FILE=/mnt/tvout
if [ -f "$FILE" ]; then
    rm "$FILE"
else
    touch "$FILE"
fi
sync
reboot
