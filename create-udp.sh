ffmpeg -i 'rtsp://wowzaec2demo.streamlock.net/vod/mp4:BigBuckBunny_115k.mov' -timeout 1  -vcodec copy -vb 150000 -g 60 -vprofile baseline -level 2.1 -acodec aac -ab 64000 -ar 48000 -ac 2 -vbsf h264_mp4toannexb -strict experimental -f mpegts udp://229.0.0.0:1234 &
echo 'udp://239.192.1.52:5000'
