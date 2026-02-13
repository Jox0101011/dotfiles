#! /bin/bash
# tui-mines, a terminal minesweeper implementation written by Christos Angelopoulos, March 2024, underGPLv2
function load_colors()
{
 if [[ $COLOR_TOGGLE == 'yes' ]]
 then
  C0="\e[38;5;242m" #Grid Color
  C1="\e[33m" #Given Numbers Color-Yellow
  C2="\e[36m" #Found Numbers Color-Cyan
  C3="\e[31m" #Red
  C4="\e[35m" #TextColor1 Magenta
  C5="\e[34m" #blue
  C6="\e[32m" # green
 else
  C0="";C1="";C2="";C3="";C4="";C5="";C6=""
 fi
}

function load_config()
{
 config_fail=0
 [[ -z "$CONFIG_FILE" ]]&&config_fail=1||source "$CONFIG_FILE"
 #DEFAULT VALUES in case config doesn't load
 [[ -z $WIDTH ]]&&WIDTH=10&&config_fail=1
 [[ -z $HEIGHT ]]&&HEIGHT=10&&config_fail=1
 [[ -z $MINES_QUANTITY ]]&&MINES_QUANTITY=10&&config_fail=1
 [[ -z $PREFERRED_EDITOR ]]&&PREFERRED_EDITOR=${EDITOR-nano}&&config_fail=1
 [[ -z $NOTIFICATION_TOGGLE ]]&&NOTIFICATION_TOGGLE='yes'&&config_fail=1
 [[ -z $CHEATSHEET_TOGGLE ]]&&CHEATSHEET_TOGGLE='yes'&&config_fail=1
 [[ -z $COLOR_TOGGLE ]]&&COLOR_TOGGLE="yes"&&config_fail=1
 [[ -z $BLINK_TOGGLE ]]&&BLINK_TOGGLE="yes"&&config_fail=1
 [[ -z $FLAG_BIND ]]&&FLAG_BIND="f"&&config_fail=1
 [[ -z $REVEAL_BIND ]]&&REVEAL_BIND="r"&&config_fail=1
 [[ -z $QUICK_SOLVE_BIND ]]&&QUICK_SOLVE_BIND="e"&&config_fail=1
 [[ -z $MINE_CHAR ]]&&MINE_CHAR="󰷚"&&config_fail=1
 [[ -z $FLAG_CHAR ]]&&FLAG_CHAR="󰈻"&&config_fail=1
 [[ -z $NAVIGATION_KEYS ]]&&NAVIGATION_KEYS="vim"&&config_fail=1
 if [[ $MINES_QUANTITY -gt $((WIDTH*HEIGHT/4)) ]];then MINES_QUANTITY=$((WIDTH*HEIGHT/4));fi # protect
 if [[ $WIDTH -lt 5 ]];then WIDTH=5;fi # protect
 if [[ $HEIGHT -lt 5 ]];then HEIGHT=5;fi # protect
 if [[ $WIDTH -gt 50 ]];then WIDTH=50;fi # protect
 if [[ $HEIGHT -gt 50 ]];then HEIGHT=50;fi # protect
 if [[ $NAVIGATION_KEYS == 'vim' ]];then NAV_LEFT='h';NAV_DOWN='j';NAV_UP='k';NAV_RIGHT='l';CHEAT_NAV='hjkl';fi
 if [[ $NAVIGATION_KEYS == 'aswd' ]];then NAV_LEFT='a';NAV_DOWN='s';NAV_UP='w';NAV_RIGHT='d';CHEAT_NAV='aswd';fi
 load_colors
[[ $config_fail == 1 ]]&&notify-send -t 9000 -i  "$SHARE_DIR/tui-mines.png" "Configurations not loaded correctly.
Running with hardcoded default values."
}

function show_hiscores ()
{
 echo -e "${C0}       ╔═══╤═══╤═══╤═══╤═══╤═══╤═══╗ \n       ║ ${C1}T${C0} │ ${C1}O${C0} │ ${C1}P${C0} │ ${J}${C3}$FLAG_CHAR${n}${C0} │ ${C1}T${C0} │ ${C1}E${C0} │ ${C1}N${C0} ║\n       ╚═══╧═══╧═══╧═══╧═══╧═══╧═══╝"
 if [[ -n $(grep "$WIDTH x $HEIGHT" "$SHARE_DIR/hiscores.txt")    ]]
 then
  TOP_10_LENGTH=$(grep "$WIDTH x $HEIGHT" "$SHARE_DIR/hiscores.txt"|wc -l)
  if [[ $TOP_10_LENGTH -gt 10 ]];then TOP_10_LENGTH=10;fi
  ii=31;i=1;
  while [[ $i -le $TOP_10_LENGTH ]]
  do
   if [[ $COLOR_TOGGLE == 'yes' ]]
   then
    echo -e '\e['${ii}m  $(grep "$WIDTH x $HEIGHT" "$SHARE_DIR/hiscores.txt" |sort -h|cat -n|awk '{print $1, $3, $4, $5, $6, $7,$8, $9 $10 $11'}|head -$i|tail +$i)
   else
    echo -e  $(grep "$WIDTH x $HEIGHT" "$SHARE_DIR/hiscores.txt" |sort -h|cat -n|awk '{print $1, $3, $4, $5, $6, $7,$8, $9 $10 $11'}|head -$i|tail +$i)
   fi
   sleep 0.3
   ((i++));((ii++))
   if [[ $ii -gt 36 ]];then ii=31;fi;
  done
 else echo -e "No statistics available just yet."
 fi

 tput civis; #make cursor disappear
}

function win_game()
{
for i in ${MINES[@]}
do
 F[i]=" "${G[i]}" "
 X[i]="${J}""${C1}"
done
clear
print_matrix
 TIMER_STOP="$(date +%s)"
 SECONDS=$(($TIMER_STOP-$TIMER_START))
 MINUTES="$(( $SECONDS / 60 ))"
 SECMLEFT="$(( $SECONDS - $((MINUTES * 60 )) ))"
 TIME="$MINUTES mins $SECMLEFT secs"
 if [[ $(grep "$WIDTH x $HEIGHT" "$SHARE_DIR/hiscores.txt"|wc -l) -lt 1 ]]
 then
  TENTH=$(($SECONDS+100)); #avoid first time error
 else
  TENTH="$(sort -h "$SHARE_DIR/hiscores.txt"|grep "$WIDTH x $HEIGHT"|head -10|tail -1|awk '{print $1}')"
 fi
 SCORELINE="$SECONDS $TIME $(date +%Y-%m-%d\ %T) $WIDTH x $HEIGHT"
 echo -e " ${J}${C3}MISSION ACCOMPLISHED!!!${n}\n ${C1}You solved the puzzle in $MINUTES mins $SECMLEFT secs${n}"
 [[ $NOTIFICATION_TOGGLE == "yes" ]]&&notify-send -t 5000 -i  "$SHARE_DIR/tui-mines.png" "MISSION ACCOMPLISHED!!!"
 if [ "$SECONDS" -lt "$TENTH" ]||[[ "$(grep "$WIDTH x $HEIGHT" "$SHARE_DIR/hiscores.txt"|wc -l)" -lt 10 ]]
 then
  echo $SCORELINE>>"$SHARE_DIR/hiscores.txt"
  echo -e " ${C1}That's right, you made it to the${n}"
  show_hiscores
 fi
 echo -e "${C0}Press any key to return to the main menu${n}";read -sn 1 vw;db="M";clear;
}

function lose_game()
{
for i in ${MINES[@]}
do
 F[i]=" "${G[i]}" "
 X[i]="${J}""${C1}"
done
X[CURSOR]="${I}""${C3}"
clear
print_matrix
echo -e "     ${J}${C3}\e[1mKABOOM!!!${n}\n${C0}Press any key to return to the main menu${n}"
[[ $NOTIFICATION_TOGGLE == "yes" ]]&&notify-send -t 5000 -i  "$SHARE_DIR/tui-mines.png" "KABOOM!!!"
read -sn 1 vw;db="M";clear;
}
function load_closed_grid()
{
 i=0;ii=0
 TOTAL=$((WIDTH*HEIGHT))
 while [[ $i -lt $TOTAL ]]
 do
  X[i]=${C2} #sq color
  F[i]="░░░" #sq appearence
  G[i]=0  #sq content
  P[i]=$ii #sq position:== 0:left border, == $((WIDTH - 1)): right border, -lt $WIDTH:top border,  -ge $((TOTAL-WIDTH)) bottom border
  ((i++));((ii++))
 if [[ $ii == $WIDTH ]];then ii=0;fi
 done
}

function load_mines (){
 i=0
 while [[ $i -lt $MINES_QUANTITY ]]
 do
  mine=$((RANDOM % $TOTAL))
  if [[ ${G[mine]} != "$MINE_CHAR"  ]]&&[[ $mine != $CURSOR ]]&&[[ $mine != $((CURSOR+1)) ]]&&[[ $mine != $((CURSOR-1)) ]]&&[[ $mine != $((CURSOR+WIDTH)) ]]&&[[ $mine != $((CURSOR-$WIDTH)) ]]&&[[ $mine != $((CURSOR+WIDTH+1)) ]]&&[[ $mine != $((CURSOR-WIDTH+1)) ]]&&[[ $mine != $((CURSOR+WIDTH-1)) ]]&&[[ $mine != $((CURSOR-WIDTH-1)) ]];then G[mine]="$MINE_CHAR";MINES[i]=$mine;((i++));fi
 done
#Calculation of G(how many mines is the square touching?)
i=0
 while [[ $i -lt $TOTAL ]]
 do
  if [[ ${G[i]} != "$MINE_CHAR" ]]
  then
   if [[ $i -ge $WIDTH ]]&&[[ ${G[i-WIDTH]} == "$MINE_CHAR" ]];then ((G[i]++));fi #North
   if [[ $i -lt $((TOTAL-WIDTH)) ]]&&[[ ${G[i+WIDTH]} == "$MINE_CHAR" ]]; then ((G[i]++));fi #South
   if [[ ${P[i]} != 0 ]]
   then
    if [[ ${G[i-1]} == "$MINE_CHAR" ]];then ((G[i]++));fi #West
    if [[ $i -ge $WIDTH ]]&&[[ ${G[i-WIDTH-1]} == "$MINE_CHAR" ]];then ((G[i]++));fi #NortWest
    if [[ $i -lt $((TOTAL-WIDTH)) ]]&&[[ ${G[i+WIDTH-1]} == "$MINE_CHAR" ]]; then ((G[i]++));fi #SouthWest
   fi
   if [[ ${P[i]} != $((WIDTH-1)) ]]
   then
    if [[ ${G[i+1]} == "$MINE_CHAR" ]];then ((G[i]++));fi #East
    if [[ $i -ge $WIDTH ]]&&[[ ${G[i-WIDTH+1]} == "$MINE_CHAR" ]];then ((G[i]++));fi #NorthEast
    if [[ $i -lt $((TOTAL-WIDTH)) ]]&&[[ ${G[i+WIDTH+1]} == "$MINE_CHAR" ]]; then ((G[i]++));fi #SouthEast
   fi
  fi
  ((i++))
 done
first_reveal=1
}

function pause ()
{
 clear
echo -e "${C0} ╔═══╤═══╤═══╤═══╤═══╤═══╤═══╤═══╗ \n ║ ${J}${C3}$MINE_CHAR${n}${C0} │ ${C1}P${C0} │ ${C1}A${C0} │ ${C1}U${C0} │ ${C1}S${C0} │ ${C1}E${C0} │ ${C1}D${C0} │ ${J}${C3}$MINE_CHAR${n}${C0} ║\n ╚═══╧═══╧═══╧═══╧═══╧═══╧═══╧═══╝"
 PAUSED_SECONDS_START="$(date +%s)"
 echo -e "\n${C0}Press any key to return to the game${n}"
 read -sN 1 v
 PAUSED_SECONDS_STOP="$(date +%s)"
 PAUSED_SECONDS="$((PAUSED_SECONDS_STOP-PAUSED_SECONDS_START))"
 TIMER_START=$((TIMER_START+PAUSED_SECONDS))
}


function draw_line (){
d=1
echo -ne "${C0}""$1"
while [[ $d -le $5 ]]
do
echo -ne "$2$2$2"
[[ $d -lt $5 ]]&&echo -ne "$3"||echo -ne "$4\n"
((d++))
done
}



function print_matrix()
{
 x=0
 height=1
 draw_line "╔" "═" "╤" "╗" $WIDTH
 while [[ $height -le $HEIGHT ]]
 do
 width=1
  echo -ne "${C0}║"
  while [[ $width -le $WIDTH ]]
  do
   echo -ne "${X[x]}${F[x]}${n}${C0}"
   ((x++))
   [[ $width -lt $WIDTH ]]&&echo -ne "│"||echo -ne "║\n"
   ((width++))
  done
  [[ $height -lt $HEIGHT ]]&&draw_line "╟" "─" "┼" "╢" $WIDTH||draw_line "╚" "═" "╧" "╝" $WIDTH
  ((height++))
 done
 }
function load_cheat()
{
if [[ $CHEATSHEET_TOGGLE == yes ]];then echo -e "╭────────────────────┬──────────────────╮\n│ ${C4}$CHEAT_NAV 󰁍 󰁅 󰁝 󰁔   ${C2}Move${C0}│${C2}Pause         ${C4}P,p ${C0}│\n├────────────────────┼──────────────────┤\n│ ${C4}$FLAG_BIND         ${C2}     Flag${C0}│${C2}Solve         ${C4}Q,q ${C0}│\n├────────────────────┼──────────────────┤\n│ ${C4}$REVEAL_BIND,space     ${C2} Reveal${C0}│${C2}Hide Info     ${C4}I,i ${C0}│\n├────────────────────┼──────────────────┤\n│ ${C4}$QUICK_SOLVE_BIND      ${C2}Quick Reveal${C0}│ ${C3}${MESSAGE:0:17}${C0}│\n╰────────────────────┴──────────────────╯${n}";else echo -e "${C3} $FLAG_QUANTITY/$MINES_QUANTITY ${C0}Enter ${C4}I${C0} to Show Cheatsheet${n}";fi
}

function reveal()
{

 F[$1]=" "${G[$1]/0/ }" "
 case ${G[$1]} in
   "0")X[$1]=${C1}
   ;;
   "1")X[$1]=${C6}
   ;;
   "2")X[$1]=${C1}
   ;;
   "3")X[$1]=${C4}
   ;;
   "4")X[$1]=${C3}
   ;;
   "5")X[$1]=${C1}
   ;;
   "6")X[$1]=${C6}
   ;;
   "7")X[$1]=${C4}
   ;;
   "8")X[$1]=${C5}
   ;;
   "$MINE_CHAR")X[$1]=${C1}
   ;;
  esac

}
function chain_reveal(){
  if [[ $1 -ge $WIDTH ]]&&[[ ${F[$1-WIDTH]} == "░░░" ]];then reveal $(($1-WIDTH));if [[ ${G[$1-WIDTH]} == 0 ]];then chain_reveal $(($1-WIDTH));fi;fi #North
  if [[ $1 -lt $((TOTAL-WIDTH)) ]]&&[[ ${F[$1+WIDTH]} == "░░░" ]]; then reveal $(($1+WIDTH));if [[ ${G[$1+WIDTH]} == 0 ]];then chain_reveal $(($1+WIDTH));fi;fi #South
  if [[ ${P[$1]} != 0 ]]
  then
   if [[ ${F[$1-1]} == "░░░" ]];then reveal $(($1-1));if [[ ${G[$1-1]} == 0 ]];then chain_reveal $(($1-1));fi;fi #West
   if [[ $1 -ge $WIDTH ]]&&[[ ${F[$1-WIDTH-1]} == "░░░" ]];then reveal $(($1-WIDTH-1));if [[ ${G[$1-WIDTH-1]} == 0 ]];then chain_reveal $(($1-WIDTH-1));fi;fi #NortWest
   if [[ $1 -lt $(($TOTAL-$WIDTH)) ]]&&[[ ${F[$1+WIDTH-1]} == "░░░" ]]; then reveal $(($1+WIDTH-1));if [[ ${G[$1+WIDTH-1]} == 0 ]];then chain_reveal $(($1+WIDTH-1));fi;fi #SouthWest
  fi
  if [[ ${P[$1]} != $((WIDTH-1)) ]]
  then
   if [[ ${F[$1+1]} == "░░░" ]];then reveal $(($1+1));if [[ ${G[$1+1]} == 0 ]];then chain_reveal $(($1+1));fi;fi #East
   if [[ $1 -ge $WIDTH ]]&&[[ ${F[$1-WIDTH+1]} == "░░░" ]];then reveal $(($1-WIDTH+1));if [[ ${G[$1-WIDTH+1]} == 0 ]];then chain_reveal $(($1-WIDTH+1));fi;fi #NorthEast
   if [[ $1 -lt $((TOTAL-WIDTH)) ]]&&[[ ${F[$1+WIDTH+1]} == "░░░" ]]; then reveal $(($1+WIDTH+1));if [[ ${G[$1+WIDTH+1]} == 0 ]];then chain_reveal $(($1+WIDTH+1));fi;fi #SouthEast
   fi
}
function check_win()
{
 UNCOVERED=0
 i=0
 while [[ $i -lt $TOTAL ]]
 do
  if [[ ${F[i]} == "░░░" ]];then ((UNCOVERED++));fi
  ((i++))
 done
  if [[ $((UNCOVERED+FLAG_QUANTITY)) == $MINES_QUANTITY ]]
  then
   if [[ -z $(echo ${F[@]}|grep "░░░") ]];then db="M";win_game;fi
  fi
}


function mv_cursor ()
{
 X[CURSOR]=${X[CURSOR]:5}
 X[NEW_CURSOR]="${I}${X[NEW_CURSOR]}"
 CURSOR="$NEW_CURSOR"
}


function check_reveal(){
 reveal $1
 if [[ ${G[$1]}  == 0 ]];then chain_reveal $1;fi
 [[ $quick_switch == '0' ]]&&X[$1]=${I}${X[$1]} #inverted only to reveal, not quick reveal
 if [[ ${G[$1]}  == "$MINE_CHAR" ]];then lose_game;fi
}

function quick_reveal()
{
 if [[ $CURSOR -ge $WIDTH ]]&&[[ ${F[CURSOR-WIDTH]} == "░░░" ]];then check_reveal $((CURSOR-WIDTH)) ;fi #North
 if [[ $CURSOR -lt $((TOTAL-WIDTH)) ]]&&[[ ${F[CURSOR+WIDTH]} == "░░░" ]]; then check_reveal $((CURSOR+WIDTH));fi #South
 if [[ ${P[CURSOR]} != 0 ]]
 then
  if [[ ${F[CURSOR-1]} == "░░░" ]]; then check_reveal $((CURSOR-1));fi #West
  if [[ $CURSOR -ge $WIDTH ]]&&[[ ${F[CURSOR-WIDTH-1]} == "░░░" ]]; then check_reveal $((CURSOR-WIDTH-1));fi #NortWest
  if [[ $CURSOR -lt $((TOTAL-WIDTH)) ]]&&[[ ${F[CURSOR+WIDTH-1]} == "░░░" ]]; then check_reveal $((CURSOR+WIDTH-1));fi #SouthWest
 fi
 if [[ ${P[CURSOR]} != $((WIDTH-1)) ]]
 then
  if [[ ${F[CURSOR+1]} == "░░░" ]]; then check_reveal $((CURSOR+1));fi #East
  if [[ $CURSOR -ge $WIDTH ]]&&[[ ${F[CURSOR-WIDTH+1]} == "░░░" ]]; then check_reveal $((CURSOR-WIDTH+1));fi #NorthEast
  if [[ $CURSOR -lt $((TOTAL-WIDTH)) ]]&&[[ ${F[CURSOR+WIDTH+1]} == "░░░" ]]; then check_reveal $((CURSOR+WIDTH+1));fi #SouthEast
  fi
}

function count_flags()
{
 FLAG_COUNT=0
 if [[ $CURSOR -ge $WIDTH ]]&&[[ ${F[CURSOR-WIDTH]} == *"$FLAG_CHAR"* ]];then ((FLAG_COUNT++));fi #North
 if [[ $CURSOR -lt $((TOTAL-WIDTH)) ]]&&[[ ${F[CURSOR+WIDTH]} == *"$FLAG_CHAR"* ]]; then ((FLAG_COUNT++));fi #South
 if [[ ${P[CURSOR]} != 0 ]]
 then
  if [[ ${F[CURSOR-1]} == *"$FLAG_CHAR"* ]]; then ((FLAG_COUNT++));fi #West
  if [[ $CURSOR -ge $WIDTH ]]&&[[ ${F[CURSOR-WIDTH-1]} == *"$FLAG_CHAR"* ]]; then ((FLAG_COUNT++));fi #NortWest
  if [[ $CURSOR -lt $((TOTAL-WIDTH)) ]]&&[[ ${F[CURSOR+WIDTH-1]} == *"$FLAG_CHAR"* ]]; then ((FLAG_COUNT++));fi #SouthWest
 fi
 if [[ ${P[CURSOR]} != $((WIDTH-1)) ]]
 then
  if [[ ${F[CURSOR+1]} == *"$FLAG_CHAR"* ]]; then ((FLAG_COUNT++));fi #East
  if [[ $CURSOR -ge $WIDTH ]]&&[[ ${F[CURSOR-WIDTH+1]} == *"$FLAG_CHAR"* ]]; then ((FLAG_COUNT++));fi #NorthEast
  if [[ $CURSOR -lt $((TOTAL-WIDTH)) ]]&&[[ ${F[CURSOR+WIDTH+1]} == *"$FLAG_CHAR"* ]]; then ((FLAG_COUNT++));fi #SouthEast
  fi
}

function flag_toggle()
{
if [[ ${F[CURSOR]} == "░░░" ]]
then
 F[CURSOR]=" "$FLAG_CHAR" "
 X[CURSOR]=${I}${C3}
 ((FLAG_QUANTITY++))

 elif [[ ${F[CURSOR]} == " "$FLAG_CHAR" " ]]
 then F[CURSOR]="░░░"
  X[CURSOR]=${I}${C2}
  ((FLAG_QUANTITY--))
 fi
 MESSAGE="  $FLAG_QUANTITY/$MINES_QUANTITY                   "
}

function new_game()
{
 first_reveal=0
 FLAG_QUANTITY=0
 MESSAGE="    Good luck!                        "
 load_closed_grid
 TIMER_START="$(date +%s)"
 clear
}

function play_menu ()
{
 db="";
 CURSOR="0"
 X[0]="${I}"${X[0]}
 while [[ "$db" != "M" ]]
 do
  clear
  print_matrix
  load_cheat
  read -sn 1 db

  [[ $(echo "$db" | od) = "$spacebar" ]]&&db=$REVEAL_BIND
  case $db in
   $NAV_UP|A) if  [[ $CURSOR -ge $WIDTH ]]; then NEW_CURSOR=$((CURSOR-WIDTH));mv_cursor;fi;
   ;;
   $NAV_DOWN|B) if  [[ $CURSOR -lt $((TOTAL-WIDTH)) ]]; then NEW_CURSOR=$((CURSOR+$WIDTH));mv_cursor;fi;
   ;;
   $NAV_RIGHT|C) if  [[ ${P[CURSOR]} !=  $((WIDTH-1)) ]]; then NEW_CURSOR=$((CURSOR+1));mv_cursor;fi;
   ;;
   $NAV_LEFT|D) if  [[ ${P[CURSOR]} != 0 ]]; then NEW_CURSOR=$((CURSOR-1));mv_cursor;fi;
   ;;
   p|P) pause;
   ;;
   q|Q)clear;if [[ -z $(echo "${G[@]/0/}"|grep "$MINE_CHAR") ]];then  echo -e "\e[3m${C2}In order to quit, first you have to begin\n                    Panos Koutroumpousis\n${C0}Press any key to return to the game${n}";read -sn 1 v;else i=0;while [[ $i -lt $TOTAL ]];do F[i]=" ""${G[i]/0/ }"" ";reveal $i;((i++));done;CHEATSHEET_TOGGLE="no";print_matrix;echo -e "\e[3m${C2}Nature’s, not honour’s law we must obey: \nThis made me cast my useless shield away.\n                             Archilochus${C0}";[[ $NOTIFICATION_TOGGLE == "yes" ]]&&notify-send -t 5000 -i  "$SHARE_DIR/tui-mines.png" "Quitting tui-mines game...";echo -e "${C0}Press any key to return to the main menu${n}";read -sn 1 v;db="M";clear;fi;
   ;;
   I|i) if [[ $CHEATSHEET_TOGGLE == yes ]];then CHEATSHEET_TOGGLE="no";else CHEATSHEET_TOGGLE="yes";fi;
   ;;
   $REVEAL_BIND) if [[ $first_reveal == 0 ]];then load_mines;TIMER_START="$(date +%s)";fi;[[ ${F[CURSOR]} == " "$FLAG_CHAR" " ]]&&((FLAG_QUANTITY--));quick_switch=0;check_reveal $CURSOR;
   ;;
   $FLAG_BIND)flag_toggle
   ;;
   e) if [[ ${F[CURSOR]} == " "[1-8]" " ]];then count_flags;if [[ $FLAG_COUNT -eq ${G[CURSOR]} ]]; then quick_switch=1;quick_reveal;fi;fi;
   ;;
   *)
  esac
 check_win
 done
}
function cursor_reappear() {
tput cnorm
exit
}

function main_menu ()
{
clear
 mm=""
 while [[ "$mm" != "q" ]]
 do
  echo -e " ${C0}╔═══╤═══╤═══╤═══╤═══╤═══╤═══╤═══╤═══╗"
  echo -e " ${C0}║ ${C2}T ${C0}│${C2} U ${C0}│${C2} I ${C0}│${C2} - ${C0}${C0}│${C6} M ${C0}│${C6} I ${C0}│${C6} N ${C0}│${C6} E ${C0}│${C6} S ${C0}║"
  echo -e " ${C0}╚═══╧═══╧═══╧═══╧═══╧═══╧═══╧═══╧═══╝"
  echo -e "${C0}╔═══╤═══╤═══╤═══╗╭────────────────────╮"
  echo -e "${C0}║${C1} $MINE_CHAR ${C0}│${C6} 2 ${C0}│${C1} $MINE_CHAR ${C0}│${C1} 1 ${C0}║│${C4} n        ${n}${C2} New Game ${C0}│"
  echo -e "${C0}╟───┼───┼───┼───╢├────────────────────┤"
  echo -e "${C0}║${C4} 3 ${C0}│${C3} 4 ${C0}│${C6} 2 ${C0}│${C1} 1 ${C0}║│${C4} e    ${n}${C2}  Preferences ${C0}│"
  echo -e "${C0}╟───┼───┼───┼───╢├────────────────────┤"
  echo -e "${C0}║${J}${C3} $MINE_CHAR ${n}${C0}│${C1} $MINE_CHAR ${C0}│${C6} 2 ${C0}│${C1} 1 ${C0}║│${C4} s      ${n}${C2}Show Top 10 ${C0}│"
  echo -e "${C0}╟───┼───┼───┼───╢├────────────────────┤"
  echo -e "${C0}║${C6} 2 ${C0}│${C6} 2 ${C0}│${C6} 2 ${C0}│${C1} $MINE_CHAR${C0} ║│${C4} q          ${n}${C2}   Exit ${C0}│"
  echo -e "${C0}╚═══╧═══╧═══╧═══╝╰────────────────────╯${n}"
  read -sn 1 mm
  case $mm in
   n)clear;new_game; play_menu;
   ;;
   e) clear;[[ $NOTIFICATION_TOGGLE == "yes" ]]&&notify-send -t 5000 -i "$SHARE_DIR/tui-mines.png" "Editing tui-mines configuration file" &eval $PREFERRED_EDITOR $CONFIG_FILE;tput civis;load_config
   ;;
   s)clear;show_hiscores;echo -e "\n ${C0}Press any key to return${n}";read -sN 1 v;clear;
   ;;
   q)clear;[[ $NOTIFICATION_TOGGLE == "yes" ]]&&notify-send -t 5000 -i  "$SHARE_DIR/tui-mines.png" "Exited tui-mines.";
   ;;
   *)clear;
  esac
 done
}
########################################
trap cursor_reappear HUP INT QUIT TERM EXIT ABRT
tput civis # make cursor invisible
spacebar=$(cat << eof
0000000 000012
0000001
eof
)
I="\e[7m" #invert
J="\e[5m" #blink
n="\e[m" #reset
CONFIG_FILE="$HOME/.config/tui-mines/tui-mines.config"
SHARE_DIR="$HOME/.local/share/tui-mines"
############## GAME ####################
load_config
new_game
main_menu
