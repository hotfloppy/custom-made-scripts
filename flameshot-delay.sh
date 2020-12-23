#!/usr/bin/env bash

function get_delay() {
  delaysec=$(zenity --entry --text "Delay how many seconds? [Q or q to quit] ")
  if [[ $? -ne 0 ]] || [[ ${delaysec:0:1} =~ [qQ] ]] 2>/dev/null ; then
    zenity --info --text "User cancelled the script. Exiting.." --no-wrap
    exit $?
  fi

  if [ -z $delaysec ]; then
    zenity --error --text "ERROR: Please specify delay in seconds." --no-wrap
    get_delay
  fi

  if ! [ $delaysec -eq $delaysec ] 2>/dev/null; then
    zenity --error --text "ERROR: Please specify the delay in numbers only." --no-wrap
    get_delay
  fi
}

function get_delay_cli() {
  read -p "Delay for how many seconds? [Q or q to quit]: " delaysec
  if [[ $? -ne 0 ]] || [[ ${delaysec:0:1} =~ [qQ] ]] 2>/dev/null ; then
    echo
    echo "User cancelled the script. Exiting.."
    exit 99
  fi

  if [ -z "$delaysec" ]; then
    echo
    echo "ERROR: Please specify delay in seconds."
    echo
    get_delay_cli
  fi

  if ! [ $delaysec -eq $delaysec ] 2>/dev/null; then
    echo
    echo "ERROR: Please specify the delay in numbers only."
    echo
    get_delay_cli
  fi
}

if [[ $(which flameshot) ]] 2>/dev/null ; then
  if [[ $(which zenity 2>/dev/null) ]]; then
    if [[ $1 == "--cli" ]]; then
      get_delay_cli
    else
      get_delay
    fi
  else
    get_delay_cli
  fi
else
  echo -e "Flameshot was not installed.\nCheck out https://github.com/flameshot-org/flameshot for installation instructions."
  exit 99
fi
  
flameshot gui -d $(echo "$delaysec * 1000" | bc)
