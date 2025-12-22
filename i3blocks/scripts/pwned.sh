#!/usr/bin/env bash

text=("[ LookIt ]")

case $BLOCK_BUTTON in
    1) notify-send -u normal "$(curl ipinfo.io/ | jq .ip)" ;;
    3) echo "${text[@]}" | shuf -n1;;
esac


