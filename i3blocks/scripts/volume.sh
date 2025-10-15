#!/bin/bash
vol=$(pamixer --get-volume-human)
mute=$(pamixer --get-mute)

if [[ "$mute" == "true" ]]; then
    echo "󰝟  Mute"
else
    echo "  $vol"
fi

