#!/usr/bin/env bash

get_info_raw() {
    artist=$(playerctl metadata artist 2>/dev/null)
    title=$(playerctl metadata title 2>/dev/null)
    [[ -z "$artist" && -z "$title" ]] && echo "" && return
    echo "$artist - $title"
}

get_info_raw
