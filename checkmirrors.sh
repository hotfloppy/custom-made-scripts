#!/usr/bin/env bash

mirrors_flag="/tmp/mirrors_flag"
force_flag=0 # 0 = do nothing, 1 = force update mirror

# check if mirrors has been updated more than 24 hours
function checkmirrors() {
	#if [[ ! -f "$mirrors_flag" ]] || [[ "$mirrors_last_updated" -lt "$threshold_time" ]]; then
	if [[ ! -f "$mirrors_flag" ]]; then
		touch "$mirrors_flag"
	fi

	#  if [[ "$1" == "-f" || "$1" == "--force" ]]; then
	#    touch "$mirrors_flag"
	#    sudo pacman-mirrors --country Singapore,Japan,Australia,Thailand
	#    return
	#  fi

	# check if wants to force update the mirrors
	for arg in "$@"; do
		shift
		if [[ "$arg" == "--paru" || "$arg" == "--yay" ]]; then
			continue
		elif [[ "$arg" == "-f" || "$arg" == "--force" ]]; then
			force_flag=1
			continue
		fi
		set -- "$@" "$arg"
	done

	if [[ -f "$mirrors_flag" ]]; then
		current_time=$(date +%s)
		mirrors_last_updated=$(stat -c %Y "$mirrors_flag")
		threshold_time=$((current_time - mirrors_last_updated))

		# 86400 seconds is 24 hours
		if [[ "$threshold_time" -ge 86400 || $force_flag == 1 ]]; then
			touch "$mirrors_flag"
			sudo pacman-mirrors --country Singapore,Japan,Australia,Thailand
		fi
	fi
}
