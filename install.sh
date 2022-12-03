#!/usr/bin/bash

sudo apt update
sudo systemctl mask networking.service dhmvcd.service
sudo mv /etc/network/interfaces /etc/network/interfaces.bak
sudo mv /etc/resolvconf.conf /etc/resolvconf.conf.bak
sudo sed -i '1i resolvconf=NO'  /etc/resolvconf.conf
sudo systemctl enable systemd-networkd.service systemd-resolved.service
sudo ln -sf /usr/lib/systemd/resolv.conf  /etc/resolv.conf

cd /tmp
git clone https://github.com/prasanthc41m/wifite-repeater.git
cd wifite-repeater

sudo mv wpa_supplicant-wlan0.conf /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
sudo chmod 600 /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
sudo systemctl disable wpa_supplicant.service
sudo systemctl enable wpa_supplicant@wlan0.service

sudo mv wpa_supplicant-wlan1.conf /etc/wpa_supplicant/wpa_supplicant-wlan1.conf
sudo chmod 600 /etc/wpa_supplicant/wpa_supplicant-wlan1.conf
sudo systemctl disable wpa_supplicant.service
sudo systemctl enable wpa_supplicant@wlan1.service

sudo mv 08-wlan0.network /etc/systemd/network/08-wlan0.network
sudo mv 12-wlan1.network /etc/systemd/network/12-wlan1.network

sudo -H pip install wifi
sudo apt install python-flask python3-flask -y

mv -r webui/ ~/
sudo mv webserver.service /lib/systemd/system/webserver.service
systemctl daemon-reload
sudo systemctl enable server
sudo systemctl start server
sudo systemctl status server

sudo apt install wifite bully reaver hashcat hcxtools hcxdumptool macchanger john cowpatty jq -y

sudo apt-get install python3-scapy libssl-dev zlib1g-dev libpcap0.8-dev python2-dev python-is-python2
cd /tmp
wget -c https://github.com/JPaulMora/Pyrit/archive/v0.5.0.tar.gz
tar -xf v0.5.0.tar.gz
cd Pyrit-0.5.0
sed -i "s/COMPILE_AESNI/NO_COMPILE_AESNI/" cpyrit/_cpyrit_cpu.c
python2 setup.py build
sudo python2 setup.py install

mv wps-pwn.sh ~/
mv pwn-mode.sh ~/
sudo chmod 755 *.sh
sudo chmod 777 ~/hs/

sudo rm -rf /tmp/wifite-repeater

Line="cd ~/hs && python3 -m http.server"
(crontab -u $(whoami) -l; echo "$line" ) | crontab -u $(whoami) -

echo "rebooting..."
sleep 2 && sudo reboot
