#!/usr/bin/env bash

stats_riseup=$(pgrep "riseup-vpn")

if [ -n "$stats_riseup" ]; then
    echo "vpn on"
else
    echo ""
    notify-send -u normal "VPN" "Desativada"
fi
