#!/bin/bash

#Yor
 Y='\033[0;33m'       # Yellow
 G='\033[0;32m'       # Greeen
 nc='\033[0m'       # No Yor
 
echo -e ${G}"Use -r for disable monitor-mode and restart wlan1 interface" ${nc}

# Set the default value for the flag
flag=0

# Parse the command line arguments
while getopts ":r" opt; do
  case $opt in
    r)
      flag=1
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

# Check the value of the flag
if [ $flag -eq 1 ]; then
  # Do something if the flag is set
echo -e ${Y} "Disable monitor-mode" ${nc}
sudo ip link set wlan1 down
sudo iw wlan1 set type managed
sudo ip link set wlan1 up
echo -e ${G} "Done" ${nc}
echo "====================================================="

#echo -e ${Y} "Scanning wifi" ${nc}
#sudo timeout 30s  wpa_cli -i wlan1 scan
#sudo timeout 30s  wpa_cli -i wlan1 scan_results > wifiresults
#cat wifiresults

echo -e ${Y} "Restart wpa_supplicant@wlan1.service" ${nc}
sudo systemctl restart wpa_supplicant@wlan1.service
echo -e ${G} "Done" ${nc}
echo "====================================================="

echo -e ${Y} "Status of wifi connection" ${nc}
sleep 5s
sudo wpa_cli -i wlan1 status
echo -e ${G} "Done" ${nc}
echo "====================================================="

echo -e ${Y} "Wifi configuration file" ${nc}
sudo cat /etc/wpa_supplicant/wpa_supplicant-wlan1.conf
echo -e ${G} "Done" ${nc}
echo "====================================================="
#  echo "Flag is set"

else

  # Do something else if the flag is not set
  echo -e ${Y} "Status of wifi connection" ${nc}
sleep 5s
sudo wpa_cli -i wlan1 status
echo -e ${G} "Done" ${nc}
echo "====================================================="
  echo -e ${Y} "Ping Status" ${nc}
ping 1.1 -O -c 4  
echo -e ${G} "Done" ${nc}
#  echo "Flag is not set"

fi
