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

### AdGuard installation for DNS and adfree network

Choose interface ```wlan0``` and all interface to be filtered. 
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

Browse http://192.168.7.1:8000 or http://pifi.ap:8000

## WebUI for add/change ssid and password of wifi

Browse http://192.168.7.1:81 or http://pifi.ap:81 to add ssid and password of wifi which need to be extended.

## Connection status
To check wifi connection status 
```
./wifistat.sh
```
And you can use ```./wifistat.sh -r``` to disable monitor-mode and restart wlan1 interface 

## AdGuard
To access AdGuard management WebUI <br>
http://192.168.7.1 or http://pifi.ap

To reset password <br>
https://www.reddit.com/r/Adguard/comments/xy11qv/i_need_to_change_my_password_in_adguard_home/
https://www.truenas.com/community/threads/how-to-change-adguard-plugin-admin-password.98609/

## Web shell installation instructions

https://www.tecmint.com/shellinabox-web-based-ssh-linux-terminal/

```Access``` https://pifi.ap:4200/
