#!/bin/sh

# Connect to Ethernet before running so that it can access updates

# Add SAIT IP addresses for NTP servers
sudo cp -f /etc/systemd/timesyncd.conf /etc/systemd/timesyncd.conf.bak
sudo bash -c "echo 'NTP= 10.197.2.9 10.197.3.9' >> /etc/systemd/timesyncd.conf"
sudo timedatectl set-ntp true

# Set current time
read -p 'Current Date YYYY/MM/DD: ' datevar
sudo date -s $datevar
read -p 'Current Time HH:MM: ' timevar
sudo date -s $timevar

# Update && Upgrade
sudo apt update && sudo apt upgrade -y

# Temporary fix for WPA Enterprise on Raspbian Buster
sudo apt remove wpasupplicant -y
sudo mv -f /etc/apt/sources.list /etc/apt/sources.list.bak
sudo bash -c "echo 'deb http://raspbian.raspberrypi.org/raspbian/ stretch main contrib non-free rpi' > /etc/apt/sources.list"
sudo apt update
sudo apt install wpasupplicant -y
sudo apt-mark hold wpasupplicant
sudo cp -f /etc/apt/sources.list.bak /etc/apt/sources.list
sudo apt update

# Update wpa_supplicant file
sudo cp -f /etc/wpa_supplicant/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf.bak
sudo bash -c "echo 'country=CA' > /etc/wpa_supplicant/wpa_supplicant.conf"
sudo bash -c "echo 'ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev' >> /etc/wpa_supplicant/wpa_supplicant.conf"
sudo bash -c "echo 'update_config=1' >> /etc/wpa_supplicant/wpa_supplicant.conf"
sudo bash -c "echo '' >> /etc/wpa_supplicant/wpa_supplicant.conf"
sudo bash -c "echo 'network={' >> /etc/wpa_supplicant/wpa_supplicant.conf"
sudo bash -c "echo '     ssid=\"sait-secure\"' >> /etc/wpa_supplicant/wpa_supplicant.conf"
sudo bash -c "echo '     priority=1' >> /etc/wpa_supplicant/wpa_supplicant.conf"
sudo bash -c "echo '     proto=RSN' >> /etc/wpa_supplicant/wpa_supplicant.conf"
sudo bash -c "echo '     key_mgmt=WPA-EAP' >> /etc/wpa_supplicant/wpa_supplicant.conf"
sudo bash -c "echo '     pairwise=CCMP' >> /etc/wpa_supplicant/wpa_supplicant.conf"
sudo bash -c "echo '     auth_alg=OPEN' >> /etc/wpa_supplicant/wpa_supplicant.conf"
sudo bash -c "echo '     eap=PEAP' >> /etc/wpa_supplicant/wpa_supplicant.conf"
read -p 'SAIT Username: ' uservar
sudo bash -c "echo '     identity=\"$uservar\"' >> /etc/wpa_supplicant/wpa_supplicant.conf"
#sudo bash -c "echo '     identity=\"serv16makerspace01\"' >> /etc/wpa_supplicant/wpa_supplicant.conf"
read -p 'SAIT Password: ' passvar
sudo bash -c "echo '     password=\"$passvar\"' >> /etc/wpa_supplicant/wpa_supplicant.conf"
#sudo bash -c "echo '     password=\"MkSP@1601\"' >> /etc/wpa_supplicant/wpa_supplicant.conf"
sudo bash -c "echo '     phase1=\"peaplabel=0\"' >> /etc/wpa_supplicant/wpa_supplicant.conf"
sudo bash -c "echo '     phase2=\"auth=MSCHAPV2\"' >> /etc/wpa_supplicant/wpa_supplicant.conf"
sudo bash -c "echo '}' >> /etc/wpa_supplicant/wpa_supplicant.conf"

# Reboot system for changes to take place
sudo reboot

