#!/usr/bin/env bash

# check if paru or yay installed, if not, install them
function pkger() {

	# set default package manager to use
  if [[ $(command -v apt) ]]; then
    pkger_flag="apt"
    exit 0
  else
    pkger_flag="yay"
  fi

	# check if user wants to specific package manager
	for arg in "$@"; do
		shift
		if [[ "$arg" == "--paru" ]]; then
			pkger_flag="paru"
			continue
		elif [[ "$arg" == "--yay" ]]; then
			pkger_flag="yay"
			continue
		elif [[ "$arg" == "-f" || "$arg" == "--force" ]]; then
			continue
		fi
		set -- "$@" "$arg"
	done

	if [[ $(command -v paru) && $pkger_flag == "paru" ]]; then
		paru "$@"
	elif [[ $(command -v yay) && $pkger_flag == "yay" ]]; then
		yay "$@"
	else
		sudo pacman -S --noconfirm yay
		yay -S --noconfirm paru-bin
		pkger "$@"
	fi
}
