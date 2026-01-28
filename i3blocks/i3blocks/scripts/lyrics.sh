#!/bin/bash
artist=$(playerctl -p spotify metadata artist)
title=$(playerctl -p spotify metadata title)

output=$(curl -s "https://api.lyrics.ovh/v1/$(echo $artist | sed 's/ /%20/g')/$(echo $title | sed 's/ /%20/g')" | jq -r .lyrics)
notify-send -u normal "$output"
