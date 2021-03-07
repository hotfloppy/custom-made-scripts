#!/usr/bin/env bash

# reference: https://unix.stackexchange.com/questions/462670/set-default-profile-for-pulseaudio

confdir="$HOME/.config/hfbox"
conffile="audio-switch-toggle"

enable_headphone() {
  echo "Switched to Headphone"
  notify-send -t 2000 "Switched to Headphone"
  pactl set-card-profile 0 off # hdmi
  pactl set-card-profile 2 output:analog-stereo+input:multichannel-input # headphone
  pactl set-card-profile 3 off # speaker
  pactl set-card-profile 1 off # loopback
  pactl set-card-profile 4 off # loopback
  echo "headphone" > $confdir/$conffile
}

enable_speaker() {
  echo "Switched to Speaker"
  notify-send -t 2000 "Switched to Speaker"
  pactl set-card-profile 0 off # hdmi
  pactl set-card-profile 2 off # headphone
  pactl set-card-profile 4 output:analog-stereo # speaker
  pactl set-card-profile 1 off # loopback
  pactl set-card-profile 3 off # loopback
  echo "speaker" > $confdir/$conffile
}

if [[ ! -f $confdir/$conffile ]]; then
  mkdir -p $confdir
  echo "headphone" > $confdir/$conffile
#  pactl set-card-profile 1 output:analog-stereo+input:multichannel-input
#  pactrl set-card-profile 2 off
  enable_headphone
  exit 0
fi

if grep -q headphone $confdir/$conffile ; then
  enable_speaker
else
  enable_headphone
fi
