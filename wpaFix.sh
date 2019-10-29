#!/bin/sh
# Temporary fix for WPA Enterprise on Raspbian Buster, 
# connect Ethernet before running
sudo apt-get remove wpasupplicant -y
sudo mv -f /etc/apt/sources.list /etc/apt/sources.list.bak
sudo bash -c "echo 'deb http://raspbian.raspberrypi.org/raspbian/ stretch main contrib non-free rpi' > /etc/apt/sources.list"
sudo apt-get update
sudo apt-get install wpasupplicant -y
sudo apt-mark hold wpasupplicant
sudo cp -f /etc/apt/sources.list.bak /etc/apt/sources.list
sudo apt-get update
#sudo mv -f /etc/wpa_supplicant/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf.bak
#sudo cp -f ./wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf
