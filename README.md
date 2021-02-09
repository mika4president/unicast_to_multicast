# unicast_to_multicast
Bash script that uses FFMPEG to convert RTSP stream to UDP



Voorbeeld inline gebruik: 
```./encoder-inline.sh 'rtsp://admin:Camera123$@192.168.100.101:554/1/stream1/Profile1' 'udp://288.0.0.0:1234?pkt_size=1316' 'AUTORELAUNCH'```

1e parameter is de bron, 2e is de output


*Cronjob log opschonen elke dag om 0900u:*
0 9 * * * echo " date -u Log opgeschoond! " > /home/pi/log.txt

*start encoding on boot*
@reboot sudo bash /home/pi/encoder.sh

*1 minuut na boot starten we controle op inkomende RTSP. Indien geen afbeelding kon worden gemaakt, reboot device!

@reboot sleep 60 && sudo bash /home/pi/snapshotv2.sh

We kunnen zelfs vanaf de PI de gegenereerde UDP weer oproepen met omxplayer!
```omxplayer udp://288.0.0.0:1234?pkt_size=1316```
