#!/bin/sh
if test "$1" == "mp4"
	ffplay -autoexit -i "$1"
else if
	ffplay -nodisp -autoexit -i "$1"
else
	sleep 1
	clear
	echo -en "     Invalid video/audio format!\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
fi
