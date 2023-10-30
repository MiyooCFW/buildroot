#!/bin/sh

if pgrep "arecord" > /dev/null; then
	killall arecord
	while (pgrep "arecord"); do
		sleep 1
	done
	rmmod snd-aloop.ko
	rm /mnt/.asoundrc
	alsactl init
else
#WARNING: This disables audio output to speakers by redirecting it to alsaloop capturing device's card
	echo 'pcm.!default { type plug slave.pcm "hw:Loopback,0,0" }' > /mnt/.asoundrc
	modprobe snd-aloop.ko
	alsactl init
	mkdir -p /mnt/output
	arecord -q -c2 -D hw:Loopback,1,0 -f S16_LE "/mnt/output/audio_$(date +%Y%m%d%H%M%S).wav"
fi
