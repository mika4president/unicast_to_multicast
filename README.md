# unicast_to_multicast
Bash script that uses FFMPEG to convert RTSP stream to UDP




### Installatie
SD-kaart inrichten:

![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) Hier dient SD-card disk2 te zijn! En deze gedeactiveerd hebt in Disk Utilty. 

```sudo dd bs=1m if=2021-01-11-raspios-buster-armhf-full.img of=/dev/rdisk2```

Indien /home/es/killswitch.txt de waarde 1 bevat, wordt encoder.sh gestart, maar doet niks.


### FFMPEG
```
sudo apt update
sudo apt install snapd
sudo reboot
sudo snap install ffmpeg --classic
```

### Netwerk /etc/network/interfaces
```
# The loopback network interface
auto lo
iface lo inet loopback
#iface eth0 inet dhcp
iface eth0 inet static
address 192.168.100.145
netmask 255.255.255.0
gateway 192.168.100.1
```
ifconfig eth0 192.168.100.145/24  #tijdelijke, enige werkende voor nu
----

Voorbeeld inline gebruik: 
```./encoder-inline.sh 'rtsp://admin:Camera123$@192.168.100.101:554/1/stream1/Profile1' 'udp://288.0.0.0:1234?pkt_size=1316' 'AUTORELAUNCH'```

1e parameter is de bron, 2e is de output

----

### Apache (makkelijk ophalen gemaakte snapshots indien nodig)
```sudo apt install apache2 -y```


### Cron 

*Cronjob log opschonen elke dag om 0900u:*
```0 9 * * * echo " date -u Log opgeschoond! " > /home/pi/log.txt```

*start encoding on boot*
```@reboot sudo bash /home/pi/encoder.sh```

*1 minuut na boot starten we controle op inkomende RTSP. Indien geen afbeelding kon worden gemaakt, reboot device!
```@reboot sleep 60 && sudo bash /home/pi/snapshotv2.sh```

We kunnen zelfs vanaf de PI de gegenereerde UDP weer oproepen met omxplayer!
```@reboot sleep 10 && omxplayer udp://224.0.0.0:1234```


### Splash boot image:
https://www.raspberrypi.org/forums/viewtopic.php?t=162629


### Create VOD HLS
```
ffmpeg -i christmasmarkets.ts -c copy -f hls -hls_time 0 -hls_playlist_type vod /var/www/html/vod/index.m3u8
```

### CREATE HLS FROM UDP 
```
ffmpeg -i udp://@239.192.0.190:5000 -map 0:0 -map 0:2  -f hls -hls_time 2 -hls_list_size 5 -vcodec copy -acodec copy browser.m3u8
```

MP4 KAN NIET ME BOVENSTAANDE, DAN MOET WE DAAR EERST EEN TS VAN MAKEN OF  DIRECT:
mkdir /var/www/html/vod/wearegoingtonbullrun/ && 
ffmpeg -i /home/es/WeAreGoingOnBullrun.mp4  -f hls -hls_time 0 -hls_playlist_type vod /var/www/html/vod/wearegoingtonbullrun/index.m3u8


### UDP TO HLS:
https://github.com/arut/nginx-rtmp-module/issues/1600 states:
        exec_static /usr/local/bin/./ffmpeg -i udp://@233.1.15.7:1234 -preset ultrafast -profile:v main -level 4.0 -c:v libx264 -vf yadif=0:-1:0 -c:a aac -f flv rtmp://127.0.0.1/cam1/stream;
        
        
## Record/Capture HLS for fake liveTV 
##HLS → mkv (600s = 10 min)
ffmpeg -i {{HLS-NPO1-URL}} -t 600 -c copy {{npo1.mkv}}

##Recreate HLS from that recording
ffmpeg -i npo1.mkv -c copy -f hls -hls_time 0 -hls_playlist_type vod /var/www/html/live/recordings/npo1/index.m3u8
