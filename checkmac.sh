#!/usr/bin/env bash

PATHNAME=$(dirname $(readlink -f $0))
source ${PATHNAME}/config

if [[ $# -ne 0 ]]; then
    for mac_address in $@; do
        vendor=$(curl -s -X GET "http://api.macvendors.com/$mac_address")
        echo -e "${bold}MAC Address:${nc} $mac_address"
        echo -e "${bold}Vendor:${nc} $vendor"
    done
else
    echo "usage: $0 fe:1d:13:34:4e:ac fe:1d:13:34:4e:ab fe:1d:13:34:4e:ae"
    exit 99
fi

exit 0
