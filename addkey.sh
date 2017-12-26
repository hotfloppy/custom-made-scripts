#!/usr/bin/env bash

#length=${#1}
#if [ $length -eq 16 ]; then
#	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ${1:8:8}
#else
#	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $1
#fi

if [[ "$#" -ne 0 ]]; then
    for key in "$@"; do
        sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys "$key"
    done
else
    echo "usage: $0 9BDB3D89CE49EC21 CE49EC22"
    exit 99
fi

exit 0
