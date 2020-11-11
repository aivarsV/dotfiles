if test -z "$SSH_AUTH_SOCK"
  set -x MPD_HOST ~/.mpd/socket
  set -x EDITOR vim
  set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
  set -x SUMMON_PROVIDER (which gopass-summon-provider)
end
set -x GPG_TTY (tty)
gpg-connect-agent updatestartuptty /bye >> /dev/null
bind -M insert \cl _fzf_marker
