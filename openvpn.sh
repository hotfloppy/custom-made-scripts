#!/usr/bin/env bash

ovpndir="$HOME/openvpn"

if [[ ! -d $ovpndir ]]; then
  mkdir -p $ovpndir
  echo "Pleae download your .ovpn config file into $ovpndir , and re-run this script."
  exit 99
fi

# check if openvpn installed. if not, install it
which openvpn >/dev/null || apt-get -y install openvpn

if [[ ! -f $ovpndir/credentials ]]; then
  echo "Setting up your VPN config file." ; echo
  read -p "Username: " username ; read -p "Password: " password
  echo -e "$username\n$password" > $ovpndir/credentials
  sed -i '' "s|auth-user-pass|auth-user-pass ${ovpndir}/credentials|g" $ovpndir/*.ovpn
fi

listconfig() {
  #clear
  ovpnList=(`ls -1 $ovpndir/*.ovpn`)
  for ((i=0; i<${#ovpnList[@]}; i++)); do
    echo "[ $i ] ${ovpnList[${i}]}"
  done
  echo "[ q ] Quit"
  echo
  printf "Which config would you like to use? (q) : "
  read config

  if [ "$config" == "q" ] || [ -z "$config" ]; then
    exit 0
  fi

  if [[ ! "$config" =~ ^-?[0-9]+$ ]]; then
    clear ; echo ; echo
    echo -e "Please enter relevant number only.\ne.g: 1" ; echo ; echo ; sleep 2.5
    listconfig
  fi

  if [[ -z ${ovpnList[$config]} ]]; then
    clear ; echo ; echo
    echo "Config you chose doesn't exist."
    echo -e "Please enter relevant number only.\ne.g: 1" ; echo ; echo ; sleep 2.5
    listconfig
  fi
}

listconfig
sudo openvpn --config ${ovpnList[${config}]}

exit 0
