if test -z "$SSH_AUTH_SOCK"
  set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
end
set -x GPG_TTY (tty)
gpg-connect-agent updatestartuptty /bye >> /dev/null
