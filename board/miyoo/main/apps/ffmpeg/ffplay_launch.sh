#!/bin/sh

if ffprobe -v error -select_streams v:0 -show_entries stream=codec_type "$1" | grep -q "video"; then
	ffplay -autoexit -i "$1"
elif ffprobe -v error -select_streams a:0 -show_entries stream=codec_type "$1" | grep -q "audio"; then
	ffplay -nodisp -autoexit -i "$1"
else
	echo -en "Invalid video/audio format!"
	# We're using SDL terminal to display above echo msg 
	## because all stdout is parsed to /dev/null from gmenu2x and it's child ps
	/mnt/apps/st/st -e "/bin/sh" "-c" "echo -e \"\n\n\n\n\n\n          Invalid video or audio format!\"; sleep 2"
fi
