#!/usr/bin/env zsh

#####################[term]#####################
# * Set default colors                       ###
# *                                         ###
#####################                      ##
if [ -e /usr/share/terminfo/x/xterm-256color ]; then
        export TERM='xterm-256color'
else
        export TERM='xterm-color'
fi


#####################[nvm]######################
# * Load nvm                                 ###
# *                                         ###
#####################                      ##
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"


################################################
# * Load Nerd Fonts symbolfunctions
# * https://github.com/ryanoasis/nerd-fonts/tree/master/bin/scripts/lib
# * 
################################################
if [[ -d $HOME/.local/share/fonts/nerdfontssymbols ]]; then
  source $HOME/.local/share/fonts/nerdfontssymbols/*.sh
fi


#####################[antigen]#################
# * Load antigen                            ###
# *                                        ###
#####################                     ##
if [[ -r $HOME/.antigen/antigen.zsh ]]; then

  source $HOME/.antigen/antigen.zsh

#######
#### | Load various lib files
##

  antigen use oh-my-zsh

  antigen bundle command-not-found
  antigen bundle history
  antigen bundle vagrant
  antigen bundle git
  antigen bundle git-extras
  antigen bundle nvm
  antigen bundle docker
  antigen bundle docker-compose
  antigen bundle pip
  antigen bundle ssh

  antigen bundle kennethreitz/autoenv
  antigen bundle robbyrussell/oh-my-zsh lib/
  antigen bundle zsh-users/zsh-syntax-highlighting
  antigen bundle zsh-users/zsh-completions src
  antigen bundle zsh-users/zsh-history-substring-search
  antigen bundle endaaman/lxd-completion-zsh

  antigen apply
fi

#####################[git-prompt]###############
# * Load zsh-git-promt
# * https://github.com/starcraftman/zsh-git-prompt
# * https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg
# *
# * Non-git prompt originally by Mayccoll https://gitlab.com/Mayccoll/Linux-Utils
# *
###############################################
[[ -r $HOME/.zsh-git-prompt/zshrc.sh  ]] && source $HOME/.zsh-git-prompt/zshrc.sh


if [[ $EUID -ne 0 ]]; then
# no root
PROMPT='
%F{blue}  ﰣ %F{237}  $(pwd) %{$reset_color%} $(git_super_status)
%{$fg[green]%} %{$fg[yellow]%} %{$fg[red]%} %F{255}'
RPROMPT='%F{237} %n %F{yellow}  %F{237}%m  %F{243} %T  %{$reset_color%}'
else
# root
PROMPT='
%F{orange}   %F{236}  $(pwd) %{$reset_color%} $(git_super_status)
%{$fg[red]%} %{$fg[red]%} %{$fg[red]%} %F{255}'
RPROMPT='%{$fg[black]%} %n %F{yellow}  %{$fg[black]%}%m  %F{243} %T  %{$reset_color%}'
fi
# | ::::::: zsh git prompt ::::::::::::::::::::::::::::::::::::::::::::::::: <<<

#source $HOME/.vim/bundle/powerline/powerline/bindings/zsh/powerline.zsh

export PATH="/snap/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/phen/.antigen/bundles/robbyrussell/oh-my-zsh/lib:/home/phen/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/command-not-found:/home/phen/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/fabric:/home/phen/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/heroku:/home/phen/.antigen/bundles/kennethreitz/autoenv:/home/phen/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/lein:/home/phen/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/pip:/home/phen/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/rake:/home/phen/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/rvm:/home/phen/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/sprunge:/home/phen/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/vundle:/home/phen/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/bundler:/home/phen/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/node:/home/phen/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/npm:/home/phen/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/python:/home/phen/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/history:/home/phen/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/rsync:/home/phen/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/vagrant:/home/phen/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/git:/home/phen/.antigen/bundles/zsh-users/zsh-syntax-highlighting:/home/phen/.antigen/bundles/zsh-users/zsh-completions/src:/home/phen/.antigen/bundles/zsh-users/zsh-history-substring-search:/home/phen/.vimpkg/bin:/home/phen/.local/lib/python2.7/site-packages:/home/phen/.local/bin"
