#!/usr/bin/bash

sudo apt update
sudo systemctl mask networking.service dhcpcd.service
sudo mv /etc/network/interfaces /etc/network/interfaces.bak
sudo mv /etc/resolvconf.conf /etc/resolvconf.conf.bak
sudo sed -i '1i resolvconf=NO'  /etc/resolvconf.conf
sudo systemctl enable systemd-networkd.service systemd-resolved.service
sudo ln -sf /usr/lib/systemd/resolv.conf  /etc/resolv.conf

cd /tmp
git clone https://github.com/prasanthc41m/wifite-repeater.git
cd wifite-repeater

sudo cp wpa_supplicant-wlan0.conf /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
sudo chmod 600 /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
sudo systemctl disable wpa_supplicant.service
sudo systemctl enable wpa_supplicant@wlan0.service

sudo cp wpa_supplicant-wlan1.conf /etc/wpa_supplicant/wpa_supplicant-wlan1.conf
sudo chmod 600 /etc/wpa_supplicant/wpa_supplicant-wlan1.conf
sudo systemctl disable wpa_supplicant.service
sudo systemctl enable wpa_supplicant@wlan1.service

sudo cp 08-wlan0.network /etc/systemd/network/08-wlan0.network
sudo cp 12-wlan1.network /etc/systemd/network/12-wlan1.network

sudo -H pip install wifi
sudo apt install python-flask python3-flask -y

cp -r webui/ ~/
sudo cp webserver.service /lib/systemd/system/webserver.service
systemctl daemon-reload
sudo systemctl enable server
sudo systemctl start server
sudo systemctl status server

sudo apt install wifite bully reaver hashcat hcxtools hcxdumptool macchanger -y

#sudo airodump-ng --wps -i wlan1
#sudo reaver -i wlan1 -vv -b xx:xx:xx:xx:xx:xx
