#!/usr/bin/env bash

pacman_updates=0
aur_updates=0

if command -v checkupdates >/dev/null 2>&1; then
  pacman_updates=$(checkupdates 2>/dev/null | wc -l)
fi

if command -v paru >/dev/null 2>&1; then
  aur_updates=$(paru -Qua 2>/dev/null | wc -l)
elif command -v yay >/dev/null 2>&1; then
  aur_updates=$(yay -Qua 2>/dev/null | wc -l)
fi

total=$((pacman_updates + aur_updates))

if [ "$total" -gt 0 ]; then
  parts=()
  if [ "$pacman_updates" -gt 0 ]; then parts+=("${pacman_updates}●"); fi
  if [ "$aur_updates" -gt 0 ]; then parts+=("${aur_updates}▲"); fi
  printf "%s\n" "$(IFS=' '; echo "${parts[*]}")"
else
  echo "✔"
fi

