# Raspberry-Pi Repeater 
WiFi Repeater with Wifi cracker for Raspberry pi 

<img src="https://raw.githubusercontent.com/prasanthc41m/wifite-repeater/main/pifi.png">

## Installation
Direct access pi using a monitor, keyboard and internet. 

First create a user called ```pi``` and run below command to install all needed automatically.

```
sudo su
cd /tmp && wget https://raw.githubusercontent.com/prasanthc41m/wifite-repeater/main/install.sh && bash install.sh
```
## Default Accesspoint ssid and password

Default wifi creds of Repeater is SSID: ```Pifi``` and Password: ```Acc3sspo!nt```
<br>To change Default Repeater SSID and Password ssh to pi and edit
```
sudo nano /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
```

### Pi-hole installation for DNS and adfree network

Choose interface ```wlan0``` and in next step choose ```setup static ip later or already configured``` option. 
Follow rest as recommended setting. ```Don't forget to note down the password for WebUI.```

## Uninstall
To uninstall accesspoint run below command in terminal
```
sudo su
cd /tmp && wget https://raw.githubusercontent.com/prasanthc41m/wifite-repeater/main/uninstall.sh && bash uninstall.sh
```

## Usage

Use auto pwn scripts below to pwn wifi and add cracked network to Accesspoint. Also there is an option to make pi in auto-pwn mode by running auto-pwn scripts as a service at startup by enable it and run continously until service disabled.

## Auto pwn script for wps using reaver and for wpa using wifite
```
./wps-pwn.sh
```
```
./wifite_pwn.sh
```

## Auto pwn run as a service 
To start auto pwn mode
```
sudo systemctl start pwnmode
```

To run auto pwn when pi boot 
```
sudo systemctl enable pwnmode
```

## WebUI for Wps cracked keys and handshake file captured 

Browse http://192.168.7.1:8000 or http://pi.hole:8000

## WebUI for add/change ssid and password of wifi

Browse http://192.168.7.1:81 or http://pi.hole:81 to add ssid and password of wifi which need to be extended.

## Connection status
To check wifi connection status 
```
./wifistat.sh
```
And you can use ```./wifistat.sh -r``` to disable monitor-mode and restart wlan1 interface 

## Pi-hole
To access Pi-hole management WebUI 
http://pi.hole/admin/
To reset password 
```
pihole -a -p
```

