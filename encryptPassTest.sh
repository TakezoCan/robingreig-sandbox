#!/bin/bash


#read -p 'SAIT Username: ' uservar
#bash -c "echo 'identity=\"$uservar\"'"
read -p 'SAIT Password: ' passvar
bash -c "echo 'password=\"$passvar\"'"
read -ra newpass <<< "echo -n $passvar | iconv -t utf16le | openssl md4"
#bash -c "echo -n $passvar | iconv -t utf16le | openssl md4"
bash -c "echo 'newpass=\"$newpass\"'"

