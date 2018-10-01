#!/usr/bin/env bash

set -euo pipefail

# Reset color
RS="\e[0m"
# Basic Colors
BLACK="\e[0;30m"
RED="\e[0;31m"
GREEN="\e[0;32m"
YELLOW="\e[0;33m"
BLUE="\e[0;34m"
PURPLE="\e[0;35m"
CYAN="\e[0;36m"
WHITE="\e[0;37m"

function_message_title () {
  echo -e "${CYAN}"
  echo -e "# | ::::::::::::::::::::::::::::::::::::::::::::: | #"
  echo -e "# |      ${RS} $1 ${CYAN}"
  echo -e "# | ::::::::::::::::::::::::::::::::::::::::::::: | #"
  echo -e "${RS}"
}

function_check_intall () {
    type -P $1 &>/dev/null && echo -e  "- Installed - ${GREEN} Ok ${RS} - $1" || echo -e  "- Install - ${RED} No ${RS} - $1"
}

function_check_intall git
function_message_title '- **Install Docker**'
NOW=$(date +%x_%X)

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

if ! which git 1> /dev/null; then 
  if confirm "git is requried, install git?"; then
   sudo apt update && sudo apt install git -y
  else
    echo "Aborting.."
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
  fi
fi

if ! which curl 1> /dev/null; then 
  if confirm "curl is requried, install curl?"; then
   sudo apt update && sudo apt install curl -y
  else
    echo "Aborting.."
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
  fi
fi

if confirm "Do you want to install Vundle?"; then
  echo "Installing vundle..." && \
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

  [[ -f ~/.vimrc ]] && echo "Backing up old .vimrc to ~/.vimrc.old.$NOW" && mv ~/.vimrc ~/.vimrc.old."$NOW"

fi