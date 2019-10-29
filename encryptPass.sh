#!/bin/sh


## Update wpa_supplicant file
#sudo cp -f /etc/wpa_supplicant/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf.bak
sudo bash -c "echo 'country=CA' > /etc/wpa_supplicant/wpa_supplicant.conf.test"
sudo bash -c "echo 'ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev' >> /etc/wpa_supplicant/wpa_supplicant.conf.test"
sudo bash -c "echo 'update_config=1' >> /etc/wpa_supplicant/wpa_supplicant.conf.test"
sudo bash -c "echo '' >> /etc/wpa_supplicant/wpa_supplicant.conf.test"
sudo bash -c "echo 'network={' >> /etc/wpa_supplicant/wpa_supplicant.conf.test"
sudo bash -c "echo '     ssid=\"sait-secure\"' >> /etc/wpa_supplicant/wpa_supplicant.conf.test"
sudo bash -c "echo '     priority=1' >> /etc/wpa_supplicant/wpa_supplicant.conf.test"
sudo bash -c "echo '     proto=RSN' >> /etc/wpa_supplicant/wpa_supplicant.conf.test"
sudo bash -c "echo '     key_mgmt=WPA-EAP' >> /etc/wpa_supplicant/wpa_supplicant.conf.test"
sudo bash -c "echo '     pairwise=CCMP' >> /etc/wpa_supplicant/wpa_supplicant.conf.test"
sudo bash -c "echo '     auth_alg=OPEN' >> /etc/wpa_supplicant/wpa_supplicant.conf.test"
sudo bash -c "echo '     eap=PEAP' >> /etc/wpa_supplicant/wpa_supplicant.conf.test"
read -p 'SAIT Username: ' uservar
sudo bash -c "echo '     identity=\"$uservar\"' >> /etc/wpa_supplicant/wpa_supplicant.conf.test"
#sudo bash -c "echo '     identity=\"serv16makerspace01\"' >> /etc/wpa_supplicant/wpa_supplicant.conf.test"
read -p 'SAIT Password: ' passvar
bash -c "echo $passvar"
bash  newpass = $passvar | iconv -t utf16le | openssl md4
bash -c "echo 'newpass= '$newpass"
sudo bash -c "echo '     password=hash:$newpass' >> /etc/wpa_supplicant/wpa_supplicant.conf.test"
#sudo bash -c "echo '     password=\"MkSP@1601\"' >> /etc/wpa_supplicant/wpa_supplicant.conf.test"
sudo bash -c "echo '     phase1=\"peaplabel=0\"' >> /etc/wpa_supplicant/wpa_supplicant.conf.test"
sudo bash -c "echo '     phase2=\"auth=MSCHAPV2\"' >> /etc/wpa_supplicant/wpa_supplicant.conf.test"
sudo bash -c "echo '}' >> /etc/wpa_supplicant/wpa_supplicant.conf.test"

