#!/usr/bin/env bash
# Detecta wifi SSID, interface up e IP local
wifi=$(nmcli -t -f active,ssid dev wifi 2>/dev/null | egrep '^yes' | cut -d: -f2)
# IP local de wlan0/eth0 ou default route
ip=$(ip route get 1.1.1.1 2>/dev/null | awk '/src/ {print $7; exit}')
if [ -n "$wifi" ]; then
  echo "$wifi ($ip)"
elif ip -o addr show scope global | grep -q . ; then
  # pega interface com IP
  iface=$(ip -o -4 addr show scope global | awk '{print $2; exit}')
  ip=$(ip -o -4 addr show scope global | awk '{print $4; exit}' | cut -d/ -f1)
  echo "$iface $ip"
else
  echo "Offline"
fi

