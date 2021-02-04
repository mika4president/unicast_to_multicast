#!/bin/bash
# Colors
ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_YELLOW=$ESC_SEQ"33;01m"
COL_BLUE=$ESC_SEQ"34;01m"
COL_MAGENTA=$ESC_SEQ"35;01m"
COL_CYAN=$ESC_SEQ"36;01m"


if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  else
    echo " `date -u` script gestart! " > log.txt

    input1=$1
    output1=$2

    echo -e $COL_GREEN  "Launching $input1 on $output1" $COL_RESET
    echo "Launching $input1 on $output1" >> log.txt;
    ffmpeg -i $input1  -vcodec copy -vb 150000 -g 60 -vprofile baseline -level 2.1 -acodec aac -ab 64000 -ar 48000 -ac 2 -vbsf h264_mp4toannexb -strict experimental -f mpegts $output1 >>stream1.txt 2>&1  &
    echo "PID:"  $!
    echo " PID: $!  " >> log.txt
    
    if [ $3 == 'AUTORELAUNCH' ] ; then 
      ./controle.sh $! &
    fi

  exit
fi


