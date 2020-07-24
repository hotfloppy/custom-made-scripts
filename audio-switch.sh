#!/usr/bin/env bash

# reference: https://forum.manjaro.org/t/switch-audio-output-between-headphone-and-speaker-while-both-plugged-in/148637/23

if amixer --card=0 get 'Auto-Mute Mode' | grep -q "Item0: 'Enabled'"
then
  echo "Switched to Speaker"
  notify-send -t 2000 "Switched to Speaker"
  pactl set-sink-port alsa_output.pci-0000_00_1b.0.analog-stereo analog-output-lineout
  amixer --card=0 set 'Auto-Mute Mode' Disabled >/dev/null
else
  echo "Switched to Headphone"
  notify-send -t 2000 "Switched to Headphone"
  pactl set-sink-port alsa_output.pci-0000_00_1b.0.analog-stereo analog-output-headphones
  amixer --card=0 set 'Auto-Mute Mode' Enabled >/dev/null
fi
