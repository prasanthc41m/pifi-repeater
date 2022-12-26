#!/bin/bash

while true; do

    bash /home/pi/wps-pwn.sh && wait
    bash /home/pi/wifite_pwn.sh && wait
done
