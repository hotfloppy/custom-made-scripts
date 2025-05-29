#!/usr/bin/env bash

# Base directory
basedir="$(dirname $(readlink -f $0))"
source "$basedir/pkger.sh"
source "$basedir/checkmirrors.sh"
source /etc/os-release

mirrors_flag="/tmp/mirrors_flag"

os="$ID_LIKE"
case $os in
arch)
	checkmirrors "$@"
	for arg in "$@"; do
		shift
		if [[ "$arg" == "-f" || "$arg" == "--force" ]]; then
			continue
		fi
		set -- "$@" "$arg"
	done
	pkger -S "$@"
	;;
debian)
	sudo apt install "$@"
	;;
*)
	# do nothing
	;;
esac
