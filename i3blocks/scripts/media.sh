#!/usr/bin/env bash

ICON_PLAY=" "
ICON_PAUSE=" "
ICON_MUSIC=" "
MAXLEN=25
SCROLL_SPEED=0.1

get_status() {
    playerctl status 2>/dev/null || echo "Stopped"
}

get_info_raw() {
    artist=$(playerctl metadata artist 2>/dev/null)
    title=$(playerctl metadata title 2>/dev/null)
    [[ -z "$artist" && -z "$title" ]] && echo "" && return
    echo "$artist - $title"
}

scroll_text() {
    local text="$1"
    local len=${#text}
    [[ $len -le $MAXLEN ]] && echo "$text" && return

    local pos_file="/tmp/i3blocks_media_scroll_pos"
    [[ -f $pos_file ]] && pos=$(<"$pos_file") || pos=0
    ((pos++))
    ((pos >= len)) && pos=0
    echo "$pos" > "$pos_file"

    echo "${text:pos:MAXLEN}"
}

menu_control() {
    CHOICE=$(echo -e "Play/Pause\nNext\nPrevious\nCopy Song\nOpen Spotify\nClose Spotify" | dmenu_run -i -b -p "Media Control")
    case "$CHOICE" in
        "Play/Pause") playerctl play-pause ;;
        "Next") playerctl next ;;
        "Previous") playerctl previous ;;
        "Copy Song")
            info="$(playerctl metadata artist) - $(playerctl metadata title)"
            echo "$info" | xclip -selection clipboard
            notify-send "Copied to clipboard" "$info"
            ;;
        "Open Spotify") spotify & disown ;;
        "Close Spotify") pkill spotify ;;
    esac
}

get_display() {
    local status info scrolltext
    status=$(get_status)

    if [[ "$status" == "Stopped" ]]; then
        echo ""
        return
    fi

    info=$(get_info_raw)
    scrolltext=$(scroll_text "$info")

    if [[ "$status" == "Playing" ]]; then
        echo "$ICON_PLAY  $scrolltext"
    else
        echo "$ICON_PAUSE  $scrolltext"
    fi
}

case $BLOCK_BUTTON in
    1) playerctl play-pause ;;
    3) menu_control ;; 
esac

get_display
