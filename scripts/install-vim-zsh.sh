#!/usr/bin/env bash

# -- [ Handle errors gracefully ]
# --  ==========================
set -euo pipefail

# -- [ Set script colors ]
# --  ===================
# -- * If terminal capabilities has support for less than 256 colors
# -- * use basic colors otherwise 256 colors

DEFAULT=$(tput sgr0) # Reset all attributes

if (( $(echotc Co) < 256 )); then
  RED=$(tput setaf 1)
  GREEN=$(tput setaf 1)
  YELLOW=$(tput setaf 1)
  BLUE=$(tput setaf 1)
  MAGENTA=$(tput setaf 1)
  CYAN=$(tput setaf 1)
else
  echo
fi

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

confirm() {
  local res
  read -r -p "$1 [y/N]" -n 1 res
  echo
  if [[ ${res::1} =~ ^(y|Y)$ ]]; then
    true
  else
    false
  fi
}

NOW=$(date +%x_%X)

if ! which git &> /dev/null; then 
  if confirm "git is requried, install git?"; then
   sudo apt update && sudo apt install git -y
  else
    echo "Aborting.."
    [[ "$0" = "${BASH_SOURCE[0]}" ]] && exit 1 || return 1
  fi
fi

if ! which curl &> /dev/null; then 
  if confirm "curl is requried, install curl?"; then
   sudo apt update && sudo apt install curl -y
  else
    echo "Aborting.."
    [[ "$0" = "${BASH_SOURCE[0]}" ]] && exit 1 || return 1
  fi
fi

if confirm "Do you want to install Vundle?"; then
  echo "Installing vundle..." && \
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

  [[ -f ~/.vimrc ]] && echo "Backing up old .vimrc to ~/.vimrc.old.$NOW" && mv ~/.vimrc ~/.vimrc.old."$NOW"
fi
