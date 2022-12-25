#!/bin/bash

a=tmp
b=wpa_supplicant-wlan1.conf
c=/etc/wpa_supplicant
d=~/conf_bak

#sudo wifite -i wlan1 -p 15 --daemon --wpa --new-hs

grep -A 2 essid cracked.json > $a
grep -v "bssid" $a > tmp2
mv tmp2 $a

sed -i 's/--//' $a 
sed -i 's/essid/ssid/'  $a 
sed -i 's/key/psk/' $a 

sed -i 's/:/=/' $a 
sed -i 's/,//' tmp 

sed -i 's/"ssid/network={ \n   "ssid/' $a
sed -i 's/.*psk.*/& \n   }\n/' $a

# Restore wpa-conf from backup
#grep -r -A 2 psk conf_bak > tmp2
#cut -c 64- tmp2 >> tmp

echo "country=IN
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1" > header

cat $a >> header

#cat header

mkdir -p $d
sudo cp $c/$b $d/wpa_supplicant-wlan1.conf.backup_`date +"%H:%M:%S:%d-%b-%Y"` 
sudo find $b -size 0 -print -delete
sudo cp header $c/$b
cp header $c/$b

cat $c/$b

echo -e ${col} "Cracked wifi added to configuration" ${nc}


