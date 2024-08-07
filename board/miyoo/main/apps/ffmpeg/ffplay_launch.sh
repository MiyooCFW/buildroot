#!/bin/sh
ffplay_video_func() {
	ffplay -fs -autoexit -hide_banner -loglevel warning -i "$1"
}

ffplay_audio_func() {
	ffplay -fs -autoexit -hide_banner -loglevel warning -showmode 1 -i "$1"
}

if ffprobe -v error -select_streams v:0 -show_entries stream=codec_type "$1" | grep -q "video"; then
	echo "Found video format, launching FFPLAY..."
	ffplay_video_func "$1"
elif ffprobe -v error -select_streams a:0 -show_entries stream=codec_type "$1" | grep -q "audio"; then
	echo "Found audio format, launching FFPLAY..."
	ffplay_audio_func "$1"
else
	echo -en "Invalid video/audio format!"
	# We're using SDL terminal to display above echo msg 
	## because all stdout is parsed to /dev/null from gmenu2x and it's child ps
	st -k -e "/bin/sh" "-c" "echo -e \"\n\n\n\n\n\n\t\t\tInvalid video or audio format!\nExiting...\"; read -t 5"
fi
