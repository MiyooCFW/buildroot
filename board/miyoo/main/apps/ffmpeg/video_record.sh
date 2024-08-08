#!/bin/sh
st_exec_func(){
	st -k -e "/bin/sh" "-c" "${1}"
}

OUTPUTDIR="/mnt/output"

if pgrep "ffmpeg" > /dev/null; then
	st_exec_func "pkill ffmpeg >/dev/null;\
	 echo -e \"\n\n\n\n\n\n\t\t\tExiting VIDEO recording!\nWait a minute to end writing MP4 file to ${OUTPUTDIR}/\";\
	 while pgrep ffmpeg >/dev/null; do sleep 1; done"
else
	mkdir -p ${OUTPUTDIR}
	ffmpeg -f fbdev -r 10 -i /dev/fb0 -vf "format=yuv420p"\
	 -c:v libx264 -preset ultrafast -framerate 10 "${OUTPUTDIR}/video_$(date +%Y%m%d%H%M%S).mp4" -nostdin -loglevel warning &
	# Wait a few seconds before actual screen record, the X264 encoder needs resources before it will stabilize video ouput
	st_exec_func "echo -e \"\n\n\n\n\n\n\t\t\tStarting VIDEO record...\n\t\t\tWait a few seconds to start.\"; read -t 10;\
	 if pgrep ffmpeg >/dev/null; then\
	 	echo -e \"\n\n\t\t\tRecording VIDEO in background...\";\
	 else\
	 	echo -e \"\n\n\t\t\tFailed to launch ffmpeg for record...\";\
	 fi; read -t 2"
fi
