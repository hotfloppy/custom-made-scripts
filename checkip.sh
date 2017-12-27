#!/usr/bin/env bash

if [ $(which curl > /dev/null) ]; then
    apt install curl -qq
fi

ip=$(curl -s -4 icanhazip.com)
echo "Public IP: $ip"
