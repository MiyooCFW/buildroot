#!/bin/sh
if pgrep "ffmpeg" > /dev/null; then
    killall -2 ffmpeg
    while (pgrep "ffmpeg"); do
        sleep 1
    done
else
    mkdir -p /mnt/output
    ffmpeg -f fbdev -r 13 -i /dev/fb0 -c:v mpeg4 "/mnt/output/video_$(date +%Y%m%d%H%M%S).mp4" -nostdin
fi
