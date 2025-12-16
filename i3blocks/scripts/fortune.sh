#!/usr/bin/env bash
echo ":)"

frase=$(fortune | trans -brief :pt | sed 's/<[^>]*>/./g' | awk '{gsub(/\\\/, ""); print}' | xargs -I{} notify-send -u normal "{}")
case $BLOCK_BUTTON in
    1)
        $frase
    ;;
esac
