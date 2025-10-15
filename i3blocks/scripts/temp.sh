#!/usr/bin/env bash
# Exibe max/avg e abreviação por núcleo. Se sensors não existir, tenta /sys/class/thermal
if command -v sensors >/dev/null 2>&1; then
  # pega linhas Core X:
  cores=$(sensors 2>/dev/null | awk '/Core [0-9]+:/ {gsub("\\+",""); gsub("°C",""); print $2}' )
  if [ -z "$cores" ]; then
    # fallback: procurar temp1
    max="n/a"
    echo "$max"
    exit
  fi
  arr=()
  sum=0
  count=0
  maxv=0
  for t in $cores; do
    v=$(echo "$t" | tr -d '+°C')
    arr+=("$v")
    sum=$((sum + v))
    count=$((count + 1))
    if [ "$v" -gt "$maxv" ]; then
      maxv=$v
    fi
  done
  avg=$((sum / count))
  # compacta: mostra max e um ou dois núcleos (até 2) e avg
  # pega primeiro 2 núcleos não necessariamente os mais quentes
  preview=""
  i=0
  for v in "${arr[@]}"; do
    if [ $i -lt 2 ]; then
      preview="${preview}${v}° "
    fi
    i=$((i+1))
  done
  echo "max ${maxv}° avg ${avg}° | ${preview}"
else
  # fallback reading thermal zones
  if [ -d /sys/class/thermal ]; then
    vals=$(awk '/temp/ {print}' /sys/class/thermal/thermal_zone*/temp 2>/dev/null)
  fi
  echo "n/a"
fi

