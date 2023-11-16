#!/bin/busybox sh

if pgrep "loadmap" 2> /dev/null; then
    pkill loadmap
else
    loadmap /mnt/joymap.map -d
fi
