#!/usr/bin/env bash

if [[ $# -eq 0 ]]; then
	nmap -p- -v localhost | grep Discovered | sort -h -k4,4
else
	if [[ $# -gt 1 ]]; then
		for host in "${@}"; do
			nmap -p- -v "$host" | grep Discovered | sort -h -k4,4
		done
	else
		nmap -p- -v "$1" | grep Discovered | sort -h -k4,4
	fi
fi
