#!/usr/bin/env bash

# Base directory
basedir="$(dirname $(readlink -f $0))"
source "$basedir/pkger.sh"
source "$basedir/checkmirrors.sh"
source /etc/os-release

# check if paru or yay installed, if not, install them
#function pkger() {
#	if [[ $(command -v paru) ]]; then
#		paru "$@"
#	elif [[ $(command -v yay) ]]; then
#		yay "$@"
#	else
#		sudo pacman -S --noconfirm yay
#		yay -S --noconfirm paru-bin
#		pkger "$@"
#	fi
#}

# check if mirrors has been updated more than 24 hours
#function check_mirrors_updated_time() {
#	#if [[ ! -f "$mirrors_flag" ]] || [[ "$mirrors_last_updated" -lt "$threshold_time" ]]; then
#	if [[ ! -f "$mirrors_flag" ]]; then
#		touch "$mirrors_flag"
#	fi
#
#	if [[ -f "$mirrors_flag" ]]; then
#		current_time=$(date +%s)
#		mirrors_last_updated=$(stat -c %Y "$mirrors_flag")
#		threshold_time=$((current_time - mirrors_last_updated))
#
#		# 86400 seconds is 24 hours
#		if [[ "$threshold_time" -ge 86400 ]]; then
#			touch "$mirrors_flag"
#			sudo pacman-mirrors --country Singapore,Japan,Australia,Thailand
#		fi
#	fi
#}

#check_mirrors_updated_time
checkmirrors "$@"

#for arg in "$@"; do
#	shift
#	if [[ "$arg" == "-f" || "$arg" == "--force" ]]; then
#		continue
#	fi
#	set -- "$@" "$arg"
#done
pkger -Syu "$@"
