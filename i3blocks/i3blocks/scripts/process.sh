top -b | head -n2 | awk '/Tarefas/ {print "| Active:" $2 " | Running:" $4 " | Sleeping:" $6 " | "}'

case $BLOCK_BUTTON in
    1) notify-send -u low $(free -h | awk '/Mem.:/ {printf("%s/%s (%.0f%%)", $3, $2, $3*100/$2)}');;
esac
