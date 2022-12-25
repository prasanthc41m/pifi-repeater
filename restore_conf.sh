#!/bin/bash

b=wpa_supplicant-wlan1.conf
c=/etc/wpa_supplicant
d=~/conf_bak
a=tmpfile

# Part 1
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

# Part 2
grep -r -A 2 psk conf_bak > tmp2
cut -c 64- tmp2 >> tmp

echo "country=IN
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1" > header

cat tmp >> header
#cat header

mkdir -p $d
sudo cp $c/$b $d/wpa_supplicant-wlan1.conf.backup_`date +"%H:%M:%S:%d-%b-%Y"` 
sudo find $b -size 0 -print -delete
sudo cp header $c/$b
cp header $c/$b

cat $c/$b

echo -e ${col} "Back up configurations restored" ${nc}
