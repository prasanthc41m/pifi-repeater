#!/usr/bin/bash

sudo apt update

sudo apt install wifite bully reaver hashcat hcxtools hcxdumptool macchanger john cowpatty jq -y

sudo apt-get install -y python3-scapy libssl-dev zlib1g-dev libpcap0.8-dev python2-dev python-is-python2
cd /tmp
wget -c https://github.com/JPaulMora/Pyrit/archive/v0.5.0.tar.gz
tar -xf v0.5.0.tar.gz
cd Pyrit-0.5.0
sed -i "s/COMPILE_AESNI/NO_COMPILE_AESNI/" cpyrit/_cpyrit_cpu.c
python2 setup.py build
sudo python2 setup.py install

sudo systemctl mask networking.service dhmvcd.service
sudo mv /etc/network/interfaces /etc/network/interfaces.bak
sudo mv /etc/resolvconf.conf /etc/resolvconf.conf.bak
sudo sed -i '1i resolvconf=NO'  /etc/resolvconf.conf
sudo systemctl enable systemd-networkd.service systemd-resolved.service
sudo ln -sf /usr/lib/systemd/resolv.conf  /etc/resolv.conf

mkdir ~/hs
cd /tmp
git clone https://github.com/prasanthc41m/pifi-repeater.git
cd pifi-repeater

sudo mv wpa_supplicant-wlan0.conf /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
sudo chmod 600 /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
sudo systemctl disable wpa_supplicant.service
sudo systemctl enable wpa_supplicant@wlan0.service

sudo mv wpa_supplicant-wlan1.conf /etc/wpa_supplicant/wpa_supplicant-wlan1.conf
sudo chmod 600 /etc/wpa_supplicant/wpa_supplicant-wlan1.conf
sudo systemctl disable wpa_supplicant.service
sudo systemctl enable wpa_supplicant@wlan1.service

sudo mv 08-wlan0.network /etc/systemd/network/08-wlan0.network
sudo mv 08-eth0.network /etc/systemd/network/08-eth0.network
sudo mv 12-wlan1.network /etc/systemd/network/12-wlan1.network

sudo -H pip install wifi
sudo apt install python-flask python3-flask -y

mv -r webui/ ~/
sudo mv webserver.service /lib/systemd/system/webserver.service
sudo mv pwnmode.service /lib/systemd/system/pwnmode.service
systemctl daemon-reload
sudo systemctl enable webserver
sudo systemctl start webserver
sudo systemctl status webserver

mv *.sh ~/
sudo chmod 755 *.sh
sudo chmod 777 ~/hs/

sudo rm -rf /tmp/pifi-repeater

Line="cd ~/hs && python3 -m http.server"
(crontab -u $(whoami) -l; echo "$line" ) | crontab -u $(whoami) -

sudo cp /etc/hosts /etc/hosts.bak
sudo bash -c 'echo "192.168.7.1               pifi.ap" >> /etc/hosts'

#Network-wide ad blocking
curl -s -S -L https://raw.githubusercontent.com/AdguardTeam/AdGuardHome/master/scripts/install.sh | sh -s -- -v

echo "rebooting..."
sleep 2 && sudo reboot

