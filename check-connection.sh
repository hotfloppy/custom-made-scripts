#!/usr/bin/env bash

which ethtool > /dev/null
if [ $? -ne 0 ]; then
    echo "Ethtool not installed. Installing.."
    sudo apt-get install ethtool -qq
fi

interface=$(ifconfig | grep -B 1 '168.132' | head -1 | awk '{ print $1 }')

ethtool $interface

exit 0
