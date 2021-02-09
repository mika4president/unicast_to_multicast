#!/bin/sh

while true;do
	{ # try
	    	ffmpeg -ss 01:23:45 -i 'rtsp://admin:Camera123$@192.168.100.101:554/1/stream1/Profile1'  -timeout 1 -y -vframes 1 -q:v 2 /var/www/html/test.jpg
	} || { # catch
        	echo 'RTSP ERROR, REBOOTING ' >> /home/pi/log.txt && sudo reboot now;
	}
	sleep 60
done
