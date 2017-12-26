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
fi

exit 0
