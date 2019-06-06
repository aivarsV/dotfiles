function tmux-session
  set session "$HOME/.config/tmux-sessions/$argv"
  if tmux ls | grep -w -e "$argv" -q
    tmux attach -t "$argv"
  else
    if test -f "$session"
      tmux start \; source-file "$session"
    else
      tmux new -s $argv 
    end
  end
end
