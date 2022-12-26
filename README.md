# Raspberry-Pi Repeater 
WiFi Repeater with Wifite for Raspberry pi 

<img src="https://raw.githubusercontent.com/prasanthc41m/wifite-repeater/main/pifi.png">

## Installation
Direct access pi using a monitor and keyboard 

First create a user called ```pi``` and run below command

```
sudo su
cd /tmp && wget https://raw.githubusercontent.com/prasanthc41m/wifite-repeater/main/install.sh && bash install.sh
```
### Pi-hole installation
choose interface ```wlan0``` and static ip as setup later. Follow rest as recommended setting. ```Don't forget to note down the password for WebUI.```

## Usage
Browse http://192.168.7.1:81 or http://pi.fi:81 to add ssid and password of wifi which need to be extended.

Default wifi creds of Repeater is SSID: ```Pifi``` and Password: ```Acc3sspo!nt```
<br>To change Default Repeater SSID and Password ssh to pi and edit
```
sudo nano /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
```

## Uninstall
```
sudo su
cd /tmp && wget https://raw.githubusercontent.com/prasanthc41m/wifite-repeater/main/uninstall.sh && bash uninstall.sh
```

## Auto pwn script for wps using reaver and for wpa using wifite
```
./wps-pwn.sh
```
```
./wifite_pwn.sh
```

## Auto pwn run as a service when boots
```
sudo systemctl enable pwnmode
```

## Wps cracked keys and handshake file captured 

Browse http://192.168.7.1:8000 or http://pi.fi:8000

## Pi-hole
```
http://pi.hole/admin/
```
