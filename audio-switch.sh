#!/usr/bin/env bash

# reference: https://unix.stackexchange.com/questions/462670/set-default-profile-for-pulseaudio

confdir="$HOME/.config/hfbox"
conffile="audio-switch-toggle"

cards_count=$(pactl list cards | grep Card | wc -l)

#
# Configure the "FANTECH OCTANE 7.1" or "HDA Intel PCH" to your headpone name and speaker name.
# Retrieve the name using this command:
#   $ pactl list cards | grep -i alsa.card_name
#
headphone=$(pactl list cards | grep -B 6 -i 'alsa.card_name = "FANTECH OCTANE 7.1"' | grep Card | awk -F'#' '{ print $2 }')
speaker=$(pactl list cards | grep -B 6 -i 'alsa.card_name = "HDA Intel PCH"' | grep Card | awk -F'#' '{ print $2 }')

for ((card=0; card<${cards_count}; card++)); do
  pactl set-card-profile $card off
done

enable_headphone() {
  echo "Switched to Headphone"
  notify-send -t 2000 "Switched to Headphone"
  pactl set-card-profile $headphone output:analog-stereo+input:multichannel-input
  echo "headphone" > $confdir/$conffile
}

enable_speaker() {
  echo "Switched to Speaker"
  notify-send -t 2000 "Switched to Speaker"
  pactl set-card-profile $speaker output:analog-stereo
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
