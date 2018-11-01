#!/usr/bin/env zsh

################################################
# * Set default editor and visual
# *
# ##############################################
	# export EDITOR='subl'
	# export VISUAL='subl'

################################################
# * Load Nerd Fonts symbolfunctions
# * https://github.com/ryanoasis/nerd-fonts/tree/master/bin/scripts/lib
# * 
################################################
if [[ -d $HOME/.local/share/fonts/nerdfontssymbols ]]; then
  source $HOME/.local/share/fonts/nerdfontssymbols/*.sh
fi


################################################
# * Load antigen
# * https://github.com/zsh-users/antigen
# * 
################################################
if [[ -r $HOME/.antigen/antigen.zsh ]]; then
  
  source $HOME/.antigen/antigen.zsh
  
  antigen use oh-my-zsh
  
  antigen bundle git
  antigen bundle git-extras
  antigen bundle git-flow
  antigen bundle git-flow-avh
  antigen bundle git-hubflow
  antigen bundle git-remote-branch
  antigen bundle github
  antigen bundle gitignore

  antigen apply
fi

setopt prompt_subst

autoload -Uz vcs_info

function +vi-git-branchformat () {
  : ${omg_rebase_tracking_branch_symbol:=''}     #   
  : ${omg_merge_tracking_branch_symbol:=''} 
  : ${omg_detached_symbol:=''}
  : ${omg_not_tracked_branch_symbol:=''} 

  local upstream current_branch will_rebase type_of_upstream branch
  current_branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  if [[ $current_branch == 'HEAD' ]]; then
    local current_commit_hash=$(git rev-parse HEAD 2> /dev/null)
    branch="$omg_detached_symbol (${current_commit_hash:0:7})"
  else
    upstream=${$(command git rev-parse --verify HEAD@{upstream} --symbolic-full-name 2>/dev/null)/refs\/(remotes|heads)\/}
    if [[ -n "${upstream}" && "${upstream}" != "@{upstream}" ]]; then
      will_rebase=$(command git config --get branch.${current_branch}.rebase 2> /dev/null)
      if [[ $will_rebase == true ]]; then
          type_of_upstream=$omg_rebase_tracking_branch_symbol
      else
          type_of_upstream=$omg_merge_tracking_branch_symbol
      fi
    else
      type_of_upstream=${omg_not_tracked_branch_symbol}
    fi
    branch="(${current_branch} ${type_of_upstream} ${upstream//\/$current_branch/})"
  fi

  hook_com[branch]=$branch
}

function +vi-git-status() {
  : ${VCS_INCOMING_CHANGES_ICON:=''}
  : ${VCS_OUTGOING_CHANGES_ICON:=''}
  : ${VCS_DIVERGED_BRANCH_ICON:=''} 
  : ${VCS_STATUS_INDICATOR_ICON:=' '} # Whitespace
  local ahead behind aheadbehind branch_name
  local -a gitstatus

  branch_name=$(command git symbolic-ref --short HEAD 2>/dev/null)
  
  ahead=$(command git rev-list "${current_branch}"@{upstream}..HEAD 2>/dev/null | wc -l)
  (( $ahead )) && gitstatus+=( "+${ahead}" ) && aheadbehind+="1" || gitstatus+=( "--" ) && aheadbehind+="0"

  behind=$(command git rev-list HEAD.."${current_branch}"@{upstream} 2>/dev/null | wc -l)
  (( $behind )) && gitstatus+=( "-${behind}" ) && aheadbehind+="1" || gitstatus+=( "--" ) && aheadbehind+="0"

  case $aheadbehind in
    00 )
    ;;
    01 )
      VCS_STATUS_INDICATOR_ICON=$VCS_INCOMING_CHANGES_ICON
    ;;
    10 )
      VCS_STATUS_INDICATOR_ICON=$VCS_OUTGOING_CHANGES_ICON
    ;;
    11 )
      VCS_STATUS_INDICATOR_ICON=$VCS_DIVERGED_BRANCH_ICON
    ;;
  esac


  hook_com[misc]+=${(j:" $VCS_STATUS_INDICATOR_ICON ":)gitstatus}
}

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git*' formats "%{$fg[grey]%}%s %{$reset_color%}%r/%S%{$fg[grey]%} %{$fg[blue]%}%b%{$reset_color%}%m%u%c%{$reset_color%} "
zstyle ':vcs_info:git*' actionformats "%s  %r/%S %b %m%u%c "
zstyle ':vcs_info:*+*:*' debug true
zstyle ':vcs_info:git*+set-message:*' hooks git-branchformat git-status

precmd () { vcs_info }
PS1='%F{5}[%F{2}%n%F{5}] %F{3}%3~ ${vcs_info_msg_0_}%f%# '