#!/bin/bash

#Color
 col='\033[0;33m'       # Yellow
 nc='\033[0m'       # No Color
 
echo -e ${col} "Disable monitor-mode" ${nc}
sudo ip link set wlan1 down
sudo iw wlan1 set type managed
sudo ip link set wlan1 up
echo "Done"
echo "====================================================="

#echo -e ${col} "Scanning wifi" ${nc}
#sudo timeout 30s  wpa_cli -i wlan1 scan
#sudo timeout 30s  wpa_cli -i wlan1 scan_results > wifiresults
#cat wifiresults

echo -e ${col} "Restart wpa_supplicant@wlan1.service" ${nc}
sudo systemctl restart wpa_supplicant@wlan1.service
echo "Done"
echo "====================================================="

echo -e ${col} "Status of wifi connection" ${nc}
sleep 5s
sudo wpa_cli -i wlan1 status
echo "====================================================="

echo -e ${col} "Wifi configuration file" ${nc}
sudo cat /etc/wpa_supplicant/wpa_supplicant-wlan1.conf
echo "====================================================="
