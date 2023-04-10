touch /mnt/tvout
#killall -9 main 
sync
#we need to reboot because we're dependant of /dev/fb0 in all cases
reboot
