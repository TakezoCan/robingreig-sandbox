#!/bin/bash

# Temporary fix for WPA Enterprise on Raspbian Buster
echo ''
bash -c "echo '************************* STARTING update of wpa_supplicant file'"
sudo apt remove wpasupplicant -y
sudo mv -f /etc/apt/sources.list /etc/apt/sources.list.bak
sudo bash -c "echo 'deb http://raspbian.raspberrypi.org/raspbian/ stretch main contrib non-free rpi' > /etc/apt/sources.list"
sudo apt update
sudo apt install wpasupplicant -y
sudo apt-mark hold wpasupplicant
sudo cp -f /etc/apt/sources.list.bak /etc/apt/sources.list
sudo apt update
bash -c "echo '************************* wpa_supplicant downgraded to v2.4'"

# Update wpa_supplicant file
echo ''
bash -c "echo '************************* STARTING update of wpa_supplicant file'"
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
sudo bash -c "echo '#     identity=\"serv16makerspace01\"' >> /etc/wpa_supplicant/wpa_supplicant.conf"
sudo bash -c "echo '#     password=\"MkSP@1601\"' >> /etc/wpa_supplicant/wpa_supplicant.conf"
read -p 'SAIT Username: ' uservar
sudo bash -c "echo '     identity=\"$uservar\"' >> /etc/wpa_supplicant/wpa_supplicant.conf"
read -p 'SAIT Password: ' passvar
#bash -c "echo 'passvar= '$passvar"
encryptpass=`echo -n $passvar | iconv -t utf16le | openssl md4`
#bash -c "echo 'encryptpass= '$encryptpass"
IFS=' '
read -ra hash <<< "$encryptpass"
#bash -c "echo 'hash= '$hash"
hashonly=${hash[1]}
#bash -c "echo 'hashonly= '$hashonly"
sudo bash -c "echo '     password=hash:$hashonly' >> /etc/wpa_supplicant/wpa_supplicant.conf"
sudo bash -c "echo '     phase1=\"peaplabel=0\"' >> /etc/wpa_supplicant/wpa_supplicant.conf"
sudo bash -c "echo '     phase2=\"auth=MSCHAPV2\"' >> /etc/wpa_supplicant/wpa_supplicant.conf"
sudo bash -c "echo '}' >> /etc/wpa_supplicant/wpa_supplicant.conf"
bash -c "echo '************************* Updating wpa_supplicant file DONE'"

# Reboot system for changes to take place
bash -c echo ''
bash -c "echo '************************* REBOOTING in 6 seconds to initialize all changes'"
sleep 6
sudo reboot

