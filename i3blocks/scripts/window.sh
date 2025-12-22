#!/bin/bash
TITLE=$(i3-msg -t get_tree | jq -r '.. | objects | select(.focused==true).name' | head -n1)


MAX=16
TEXT=$(echo "$TITLE" | tr '[:lower:]' '[:upper:]')
LEN=${#TEXT}
i=0

for i in $i; do
    OUT="${TEXT:i}${TEXT:0:i}"
    echo "[$OUT]"
    i=$(( (i+1) % LEN ))
    sleep 0.15
done
