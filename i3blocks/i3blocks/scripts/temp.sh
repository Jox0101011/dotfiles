#!/usr/bin/env bash
if command -v sensors >/dev/null 2>&1; then
  cores=$(sensors 2>/dev/null | awk '/Core [0-9]+:/ {gsub("\\+",""); gsub("°C",""); print $2}' )
  if [ -z "$cores" ]; then
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
  if [ -d /sys/class/thermal ]; then
    vals=$(awk '/temp/ {print}' /sys/class/thermal/thermal_zone*/temp 2>/dev/null)
  fi
  echo "n/a"
fi

