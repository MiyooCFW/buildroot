#!/bin/busybox sh

if pgrep "loadmap" 2> /dev/null; then
    killall -2 loadmap
else
    loadmap /mnt/joymap.map -d -b
fi
