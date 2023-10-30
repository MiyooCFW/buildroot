#!/bin/sh

if ffprobe -v error -select_streams v:0 -show_entries stream=codec_type "$1" | grep -q "video"; then
	ffplay -autoexit -i "$1"
elif ffprobe -v error -select_streams a:0 -show_entries stream=codec_type "$1" | grep -q "audio"; then
	ffplay -nodisp -autoexit -i "$1"
else
	clear
	echo -en "     Invalid video/audio format!\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
	sleep 2
fi
