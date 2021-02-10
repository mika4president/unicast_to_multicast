#!/bin/bash
while true;do
 if  ffmpeg -ss 01:23:45 -i 'rtsp://admin:Camera123$@192.168.100.101:554/1/stream1/Profile1' -loglevel warning  -timeout 1 -y -vframes 1 -q:v 2 /var/www/html/test.jpg ; then # TRY
    echo 'OK';
 else # CATCH
    echo 'RTSP ERROR!!!';
    echo " `date -u` RTSP STREAM LOST " >> /var/log/log.txt
    sleep 20;
    sudo reboot now;
 fi
 sleep 60
done
