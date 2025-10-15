text=$HOME/.config/i3blocks/assets/pwn.txt

case $BLOCK_BUTTON in
    1) notify-send -u normal "$(date)
$(uptime)" ;;
    3) echo -e "$(cat "$text" | shuf -n1)" ;;
esac

echo " no text"
