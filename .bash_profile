#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# set some initial vars
if [[ -z "$SSH_AUTH_SOCK" ]]
then
  export MPD_HOST=/run/user/$(id -u)/mpd/socket
  export EDITOR=vim
  export GOPATH=~/.local/share/go
  export SSH_AUTH_SOCK=`gpgconf --list-dirs agent-ssh-socket`
fi
