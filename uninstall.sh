#!/usr/bin/bash

##### CONFIGURATIONS TO BE CHANGED ####
WLAN0="wlan0"
WLAN1="wlan1"

# Config files, don't change
ws_wlan0="/etc/wpa_supplicant/wpa_supplicant-wlan0.conf"
ws_wlan1="/etc/wpa_supplicant/wpa_supplicant-wlan1.conf"
wlan0_network="/etc/systemd/network/08-wlan0.network"
wlan1_network="/etc/systemd/network/12-wlan1.network"

   rm -rf $ws_wlan0 $ws_wlan1 $wlan0_network $wlan1_network
   systemctl unmask networking.service dhcpcd.service
   mv /etc/network/{interfaces.bak,interfaces} # restore file
   systemctl disable systemd-networkd.service systemd-resolved.service wpa_supplicant@wlan0.service wpa_supplicant@wlan1.service
   systemctl enable wpa_supplicant.service
   rm -rf /etc/resolv.conf
   cp /etc/{resolv.conf.bak,resolv.conf}
   echo "done. rebooting..."
   sleep 2
   /sbin/reboot
