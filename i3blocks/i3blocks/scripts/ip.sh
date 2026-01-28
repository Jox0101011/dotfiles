#!/usr/bin/env bash

ip=$(ip route get 1.1.1.1 2>/dev/null | awk '/src/ {print $7; exit}')

if [ -n "$ip" ]; then
  echo "$ip"
else
  echo "n/a"
fi

case $BLOCK_BUTTON  in
    1) kitty -e nmtui  ;;
    3) notify-send -u normal "SSID: $(iwgetid)" "BSSID: $(iw dev wlan0 link | awk '/Connected to/ {bssid=$3} END{print "BSSID:", bssid}')" ;;
esac
