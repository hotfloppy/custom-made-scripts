#!/usr/bin/env bash

if [ $(which ethtool > /dev/null) ]; then
    sudo apt-get install ethtool -qq
fi

interface=$(ifconfig | grep -B 1 '168.132' | head -1 | awk '{ print $1 }')

ethtool $interface

exit 0
