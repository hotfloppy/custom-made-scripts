#!/bin/bash

msg="You should run this script as a superuser for better result.\nScript will continue to run after 5 seconds. Hit ctrl+c to abort."

if [[ $(id -u) -ne 0 ]]; then
  echo -e "$msg"
  for i in {5..1}; do
    clear ; echo -e "$msg" ; echo $i ; sleep 1
  done
fi

clear
pushd /
du -sh bin boot data dev etc home lib* local media mnt opt usr var | tee /tmp/checkusage.log
popd

exit 0
