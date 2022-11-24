# Raspberry-Pi Wifite Repeater
WiFi Repeater with Wifite for Raspberry pi 

## Installation
```
sudo su
cd /tmp && wget https://raw.githubusercontent.com/prasanthc41m/wifite-repeater/main/install.sh && bash install.sh
```
## Usage
Browse http://192.168.7.1 to add ssid and password of wifi which need to be extended.
<br>Default wifi creds of Repeater is SSID: ```Pifi``` and Password: ```Acc3sspo!nt```

To change Default Repeater SSID and Password edit ssh to pi and edit
```
sudo nano /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
```

## Uninstall
```
sudo su
cd /tmp && wget https://raw.githubusercontent.com/prasanthc41m/wifite-repeater/main/uninstall.sh && bash uninstall.sh
```
