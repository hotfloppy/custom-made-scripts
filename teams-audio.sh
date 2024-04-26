#!/usr/bin/env bash

teams_config="$HOME/.config/Microsoft/Microsoft Teams/storage.json"

#killall teams

if [[ $(command -v jq) ]]; then
	jq '(.calling_selected_speaker_device.speaker="Default_Device" | .calling_selected_microphone_device.microphone="Default_Device")' "${teams_config}" >"${teams_config}.fixed"
	mv -f "${teams_config}.fixed" "${teams_config}"
fi
