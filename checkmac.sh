#!/usr/bin/env bash

PATHNAME=$(dirname $(readlink -f $0))
source ${PATHNAME}/config

mac_address="$1"

vendor=$(curl -s -X GET "http://api.macvendors.com/$mac_address")
echo -e "${bold}MAC Address:${nc} $mac_address"
echo -e "${bold}Vendor:${nc} $vendor"

exit 0
