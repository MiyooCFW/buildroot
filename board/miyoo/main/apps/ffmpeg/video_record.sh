#!/bin/sh
if pgrep "ffmpeg" > /dev/null; then
	pkill ffmpeg
else
	mkdir -p /mnt/output
	ffmpeg -f fbdev -r 8 -i /dev/fb0 -c:v mpeg4 -framerate 15 "/mnt/output/video_$(date +%Y%m%d%H%M%S).mp4" -nostdin
fi
