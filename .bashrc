#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f ~/.config/bash/functions ]] && . ~/.config/bash/functions



GPG_TTY=`tty` gpg-connect-agent updatestartuptty /bye >> /dev/null

# history config
HISTSIZE=5000
HISTFILE=~/.cache/bash_history
~/.local/bin/cleanup-history $HISTFILE
# reload history
builtin history -c
builtin history -r
# fzf history searching
source /usr/share/fzf/key-bindings.bash

# some useful aliases
alias ls='ls --color=auto -1'
alias gcp='gopass list -f | fzf | xargs --delimiter="\n" --no-run-if-empty gopass show -c'
alias gsh='gopass list -f | fzf | xargs --delimiter="\n" --no-run-if-empty gopass show'
alias sway='QT_QPA_PLATFORM=wayland-egl \
  QT_QPA_PLATFORMTHEME=qt5ct \
  CLUTTER_BACKEND=wayland \
  SDL_VIDEODRIVER=wayland \
  GDK_BACKEND=wayland \
  WALLPAPER_FILE=~/Attēli/wallpaper.png \
  BROWSER=firefox \
  exec sway'
alias river='QT_QPA_PLATFORM=wayland-egl \
  QT_QPA_PLATFORMTHEME=qt5ct \
  CLUTTER_BACKEND=wayland \
  SDL_VIDEODRIVER=wayland \
  GDK_BACKEND=wayland \
  WALLPAPER_FILE=~/Attēli/wallpaper.png \
  BROWSER=firefox \
  XKB_DEFAULT_LAYOUT="lv" \
  XKB_DEFAULT_OPTIONS="caps:escape" \
  exec river'

# For interaction with dotfiles repository
alias dotfiles='GIT_DIR=$HOME/.dotfiles GIT_WORK_TREE=$HOME /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'



PROMPT_COMMAND=__prompt_command

__prompt_command() {
  local _cmdResult="$?"

  local _colReset='\[\e[0m\]'
  local _colPwd='\[\e[97;44m\]'
  local _colDelim='\[\e[0m\e[34m\]'
  local _colFailure='\[\e[31m\]'
  local _colCmd='\[\e[0m\e[94m\]'

  # Shortened version of $PWD
  PS1="$_colPwd \$(pwd | sed -r -e 's@'\"$HOME\"'@~@; s@([^/]{3})[^/]+/@\1/@g') ${_colDelim}$_colReset"
  # change prompt color depending on previous command exit state
  if [ "$_cmdResult" != 0 ]; then
    PS1+="$_colFailure"
  fi
  PS1+=" \\$ $_colCmd"

  # reset color after user entry
  PS0="$_colReset"
}

trap '[[ "${BASH_COMMAND}" == __prompt_command ]] || echo -ne "\033]0;${PWD}: (${BASH_COMMAND})\007"' DEBUG
