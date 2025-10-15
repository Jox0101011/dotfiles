#!/usr/bin/env bash

stats_riseup=$(pgrep "riseup-vpn" || echo "no vpn")

if [ -n "$stats_riseup" ]; then
    echo "riseup on"
else
    echo "no vpn"
fi
