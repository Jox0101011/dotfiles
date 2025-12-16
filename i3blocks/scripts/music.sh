#!/usr/bin/env bash
if command -v playerctl >/dev/null 2>&1; then
  status=$(playerctl status 2>/dev/null)
  if [ -z "$status" ]; then
    echo "no player"
    exit
  fi
  meta=$(playerctl metadata --format '{{artist}} - {{title}}' 2>/dev/null)
  if [ -z "$meta" ]; then
    meta=$(playerctl metadata --format '{{title}}' 2>/dev/null)
  fi
  echo "${meta:0:40}"
else
  echo "playerctl n/a"
fi
