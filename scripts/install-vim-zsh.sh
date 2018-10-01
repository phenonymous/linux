#!/usr/bin/env bash

set -euox pipefail

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
   sudo apt update && sudo apt install git
  else
    echo "Aborting.."
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
  fi
fi

if ! which curl 1> /dev/null; then 
  if confirm "curl is requried, install curl?"; then
   sudo apt update && sudo apt install curl
  else
    echo "Aborting.."
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
  fi
fi

if confirm "Do you want to install Vundle?"; then
  echo "Installing vundle..." && \
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

  [[ -f ~/.vimrc ]] && echo "Backing up old .vimrc to ~/.vimrc.old" && mv ~/.vimrc ~/.vimrc.old."$NOW"
fi