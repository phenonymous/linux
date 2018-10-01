#!/usr/bin/env bash

set -euox pipefail

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
  confirm "git is requried, install git?" && sudo apt update && sudo apt install git
fi

if ! which curl 1> /dev/null; then 
  confirm "curl is requried, install curl?" && sudo apt update && sudo apt install curl
fi

if confirm "Do you want to install Vundle?"; then
  echo "Installing vundle..." && \
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

  [[ -f ~/.vimrc ]] && echo "Backing up old .vimrc to ~/.vimrc.old" && mv ~/.vimrc ~/.vimrc.old
fi

