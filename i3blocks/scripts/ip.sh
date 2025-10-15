#!/usr/bin/env bash
# tenta pegar IP local (não público); public IP pode ser pesado, então opciona usar curl
ip=$(ip route get 1.1.1.1 2>/dev/null | awk '/src/ {print $7; exit}')
if [ -n "$ip" ]; then
  echo "$ip"
else
  echo "n/a"
fi
