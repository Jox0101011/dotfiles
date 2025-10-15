#!/usr/bin/env bash
# tenta nvidia-smi, fallback a amdgpu (radeontop não assumido)
if command -v nvidia-smi >/dev/null 2>&1; then
  nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null | awk '{printf("%s%%", $1)}'
else
  # fallback: se não tiver nvidia, tenta vgainfo via sensors? simplifica:
  echo "n/a"
fi

