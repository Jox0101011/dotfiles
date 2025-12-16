#!/usr/bin/env bash
wifi=$(nmcli -t -f active,ssid dev wifi 2>/dev/null | egrep '^yes' | cut -d: -f2)
ip=$(ip route get 1.1.1.1 2>/dev/null | awk '/src/ {print $7; exit}')
if [ -n "$wifi" ]; then
  echo "$wifi ($ip)"
elif ip -o addr show scope global | grep -q . ; then
  iface=$(ip -o -4 addr show scope global | awk '{print $2; exit}')
  ip=$(ip -o -4 addr show scope global | awk '{print $4; exit}' | cut -d/ -f1)
  echo "$iface $ip"
else
  echo "Offline"
fi

case $BLOCK_BUTTON  in
    1) kitty -e nmtui  ;;
    3) notify-send -u normal "SSID: $(iwgetid)" "BSSID: $(iw dev wlan0 link | awk '/Connected to/ {bssid=$3} END{print "BSSID:", bssid}')" ;;
esac
