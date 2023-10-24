#!/bin/sh
mkdir -p /mnt/output

if pgrep "ffmpeg" > /dev/null; then
    killall -2 ffmpeg
else
    ffmpeg -f fbdev -framerate 15 -i /dev/fb0 -vf "format=yuv420p" -c:v mpeg4 "/mnt/output/$(date +%Y%m%d%H%M%S).mp4" -nostdin &
fi
