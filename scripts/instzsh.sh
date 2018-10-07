#!/bin/bash

zshrc[0]="   ███████╗███████╗██╗  ██╗██████╗  ██████╗"
zshrc[1]="   ╚══███╔╝██╔════╝██║  ██║██╔══██╗██╔════╝"
zshrc[2]="     ███╔╝ ███████╗███████║██████╔╝██║     "
zshrc[3]="    ███╔╝  ╚════██║██╔══██║██╔══██╗██║     "
zshrc[4]="██╗███████╗███████║██║  ██║██║  ██║╚██████╗"
zshrc[5]="╚═╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝"

vimrc[0]="  ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗"
vimrc[1]="  ██║   ██║██║████╗ ████║██╔══██╗██╔════╝"
vimrc[2]="  ██║   ██║██║██╔████╔██║██████╔╝██║     "
vimrc[3]="  ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║     "
vimrc[4]="██╗╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗"
vimrc[5]="╚═╝ ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝"
                                           
REAL_OFFSET_X=$(tput cols)
REAL_OFFSET_Y=$(tput lines)

draw_char() {
  V_COORD_X=$1
  V_COORD_Y=$2

  tput cup $(((REAL_OFFSET_Y/2) + V_COORD_Y - 3)) $(((REAL_OFFSET_X/2) + V_COORD_X - (LENGTH/2)))

  if [[ "$3" == "outro" ]]; then
    echo " "
  else
    echo -e "${DATA[V_COORD_Y]:V_COORD_X:1}"
  fi
}

draw_text() {
  case "$1" in
    zshrc )
      DATA=("${zshrc[@]}")  ;;
    vimrc )
      DATA=("${vimrc[@]}")  ;;
    * )
      echo ;;
  esac

  LENGTH=${#DATA[0]}

  declare -a rand_order

  for (( i=0; i<${#DATA[@]}; i++ )); do
    for (( j=0; j<${#DATA[0]}; j++ )); do
      rand_order+=("$j;$i")
    done
  done

  rand_order=($(echo "${rand_order[@]}" | tr " " "\n" | shuf | tr "\n" " "))

  tput civis
  clear

  for (( i=0; i<${#rand_order[@]}; i++ )); do
    draw_char ${rand_order[i]/;/ }
    sleep 0.01s
  done

  sleep 2s

  for (( i=0; i<${#rand_order[@]}; i++ )); do
    draw_char ${rand_order[i]/;/ } outro
    sleep 0.01s
  done

  tput cnorm
  clear
}