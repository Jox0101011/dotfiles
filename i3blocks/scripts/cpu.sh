#!/usr/bin/env bash
# mostra uso CPU (load em % aproximado)
# fallback simples se /proc/stat não existir

if [ -r /proc/stat ]; then
  # calcula uso (similar ao anterior, mais robusto)
  read -r cpu a b c d e f g h < /proc/stat
  prev_total=$((a+b+c+d+e+f+g+h))
  prev_idle=$d
  sleep 0.2
  read -r cpu a b c d e f g h < /proc/stat
  total=$((a+b+c+d+e+f+g+h))
  idle=$d
  usage=$((100*( (total-prev_total) - (idle-prev_idle) ) / (total-prev_total) ))
  echo "${usage}%"
else
  echo "n/a"
fi

