#!/usr/bin/env bash
free -h | awk '/Mem:/ {printf("%s/%s (%.0f%%)", $3, $2, $3*100/$2)}'

