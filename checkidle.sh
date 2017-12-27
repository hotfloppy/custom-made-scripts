#!/usr/bin/env bash

PATHNAME=$(dirname $(readlink -f $0))
source ${PATHNAME}/config

if [[ $(which xprintidle > /dev/null) ]]; then
    apt install xprintidle -qq
fi

users=($(who | awk '{ print $1 }' | grep -v root | sort | uniq ))

#echo ${users[@]}

pts="pts"

for user in ${users[@]}; do
    disp=$(w | grep ${user:0:8} | grep init | awk '{ print $2 }')
    if test ${disp#*$pts} != $disp; then continue; fi # ignore pts display
    export DISPLAY=$disp
    idlems=$(sudo -u $user xprintidle)
    idlemin=$((($idlems/1000)/60))
    echo -e "${bold}$user:${nc} ${idlemin} mins"
done

exit 0
