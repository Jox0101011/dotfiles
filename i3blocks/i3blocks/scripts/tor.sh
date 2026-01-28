#!/usr/bin/env bash

if systemctl is-active --quiet tor.service 2>/dev/null; then
  echo "tor on"
  exit
fi
if pgrep -x tor >/dev/null 2>&1; then
  echo "tor on"
  exit
fi

if ss -ltnp 2>/dev/null | grep -q ':9050'; then
  echo "tor on"
  exit
fi

echo ""
