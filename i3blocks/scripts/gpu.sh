#!/usr/bin/env bash
if command -v nvidia-smi >/dev/null 2>&1; then
  nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null | awk '{printf("%s%%", $1)}'
else
  echo "n/a"
fi

