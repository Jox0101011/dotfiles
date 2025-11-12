text=$HOME/.config/i3blocks/assets/pwn.txt

case $BLOCK_BUTTON in
    1) notify-send -u normal "$(curl ipinfo.io/ | jq .ip)" ;;
    3) echo -e "$(cat "$text" | shuf -n1)" ;;
esac

echo " no text"
