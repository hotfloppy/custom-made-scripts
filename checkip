#!/bin/bash

#echo "Checking Public IP address..."
#GET checkip.dyndns.org|sed -e 's/.*Current IP Address: //' -e 's/<.*$//'

CHECK_CURL=`command -v curl | wc -l`
if [ $CHECK_CURL -eq 0 ]; then
  printf "Package cURL is not installed. Install it now? (Y/n): "
  read ANSWER
  if [ "$ANSWER" == "" ] || [ "$ANSWER" == "Y" ] || [ "$ANSWER" == "y" ]; then
    APTITUDE_INSTALL=`dpkg -l aptitude`
    if [ $? -ne 0 ]; then
      sudo apt-get install curl -y
    else
      sudo aptitude install curl -y
    fi
  else
    echo "This script requires cURL to be installed."
    echo ""
    echo "Script terminated."
    exit 1
  fi
fi

ip=`curl -s -4 icanhazip.com`
#clear
echo "Public IP: $ip"
