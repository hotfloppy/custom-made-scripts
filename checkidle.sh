#!/usr/bin/env bash

PATHNAME=$(dirname $(readlink -f $0))
source ${PATHNAME}/config

users=($(who | awk '{ print $1 }' | grep -v root | sort | uniq ))

for user in ${users[@]}; do
  ls -lt /dev/pts | fgrep $user | head -1 | awk '{ print $3" was last active on "$7" "$8" "$9 }'
done

exit 0
