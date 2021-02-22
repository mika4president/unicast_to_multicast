#!/bin/bash
#set -x

# Colors
ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_YELLOW=$ESC_SEQ"33;01m"
COL_BLUE=$ESC_SEQ"34;01m"
COL_MAGENTA=$ESC_SEQ"35;01m"
COL_CYAN=$ESC_SEQ"36;01m"

while true; do
    read -rsn1 input
    if [ "$input" = "a" ];
    then
        #echo "launching A en pid is nu $pid"
        #ps -ef | grep omxplayer | grep -v grep | awk '{print $2}' | xargs kill -9 1&2>/dev/null ;
	echo 'a gedrukt';
        killall "omxplayer.bin";
        sleep 1;
        omxplayer -no-keys 5.mp4 > /dev/null 2>&1 &
        #echo "PID:"  $!
        pid=$!
    elif [ "$input" = "b" ];
    then
        echo "b gedrukt";
        #ps -ef | grep omxplayer | grep -v grep | awk '{print $2}' | xargs kill -9 | 1&2>/dev/null ;
        killall "omxplayer.bin";
        sleep 1;
        omxplayer -no-keys udp://229.0.0.0:1234 > /dev/null 2>&1 &
    elif [ "$input" = "c" ];
    then
        echo 'c gedrukt';
        killall omxplayer;
        sleep 1;
        omxplayer -no-keys --live https://d3isaxd2t6q8zm.cloudfront.net/live/omroepzeeland/tv/index.m3u8 > /dev/null 2>&1 &
    fi
done
