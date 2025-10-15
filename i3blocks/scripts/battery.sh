#!/bin/bash
bat=$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null)
status=$(cat /sys/class/power_supply/BAT*/status 2>/dev/null)

if [[ -z "$bat" ]]; then
    echo "󰚥  AC"
    exit 0
fi

if [[ "$status" == "Charging" ]]; then
    echo "󰂄  ${bat}%"
elif [[ "$bat" -le 20 ]]; then
    echo "󰂎  ${bat}%"
elif [[ "$bat" -le 50 ]]; then
    echo "󰁼  ${bat}%"
else
    echo "󰁹  ${bat}%"
fi

