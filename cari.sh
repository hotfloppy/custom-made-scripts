#!/bin/bash

# check either aptitude has been installed or not
if [ $(which aptitude > /dev/null) ]; then
    sudo apt install aptitude -qq
fi

# make sure that first parameter is not --show
if [ $# -eq 1 ]; then
    if [ "$1" != "--show" ] || [ "$1" != "-s" ]; then
        aptitude search $@
        exit 0
    fi
fi

#for (( i=1; i<=$#; i=i+1 )) {
#    echo ${!i}
#    if [ "${!i}" == "-s" ] || [ "${!i}" == "--show" ]; then
#	    aptitude show $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11}
#	    exit 0
#    fi
#}

if [ "$1" == "-s" ] || [ "1" == "--show" ]; then
    shift
    aptitude show $@
    exit 0
fi
