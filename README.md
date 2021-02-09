# unicast_to_multicast
Bash script that uses FFMPEG to convert RTSP stream to UDP




### Installatie
SD-kaart inrichten:

![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) Hier dient SD-card disk2 te zijn! En deze gedeactiveerd hebt in Disk Utilty. 

```sudo dd bs=1m if=2021-01-11-raspios-buster-armhf-full.img of=/dev/rdisk2```

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

### Cron 

*Cronjob log opschonen elke dag om 0900u:*
```0 9 * * * echo " date -u Log opgeschoond! " > /home/pi/log.txt```

*start encoding on boot*
```@reboot sudo bash /home/pi/encoder.sh```

*1 minuut na boot starten we controle op inkomende RTSP. Indien geen afbeelding kon worden gemaakt, reboot device!
```@reboot sleep 60 && sudo bash /home/pi/snapshotv2.sh```

We kunnen zelfs vanaf de PI de gegenereerde UDP weer oproepen met omxplayer!
```@reboot sleep 60 && omxplayer udp://288.0.0.0:1234?pkt_size=1316```


### Splash boot image:
https://www.raspberrypi.org/forums/viewtopic.php?t=162629
