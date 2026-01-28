read prev_idle prev_total < <(
    awk '/^cpu /{
        idle=$5
        total=0
        for(i=2;i<=NF;i++) total+=$i
        print idle, total
    }' /proc/stat
)

sleep 0.2

read idle total < <(
    awk '/^cpu /{
        idle=$5
        total=0
        for(i=2;i<=NF;i++) total+=$i
        print idle, total
    }' /proc/stat
)

diff_total=$((total - prev_total))
diff_idle=$((idle - prev_idle))

(( diff_total > 0 )) && echo $((100 * (diff_total - diff_idle) / diff_total))"%"

