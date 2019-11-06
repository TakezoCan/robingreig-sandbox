#!/bin/bash


#read -p 'SAIT Username: ' uservar
#bash -c "echo 'identity=\"$uservar\"'"
read -p 'SAIT Password: ' passvar
#bash -c "echo 'password= $passvar'"
encryptpass=`echo -n $passvar | iconv -t utf16le | openssl md4`
#read -ra newpass <<< "echo -n $passvar | iconv -t utf16le | openssl md4"
#bash -c "echo -n $passvar | iconv -t utf16le | openssl md4"
#bash -c "echo 'encryptpass=\"$encryptpass\"'"
#bash -c "echo 'encryptpass= $encryptpass'"
IFS=' '
read -ra hash <<< "$encryptpass"
#bash -c "echo 'stripped hash= ${hash[1]}'"
hashonly=${hash[1]}
bash -c "echo 'hash variable= $hashonly'"
