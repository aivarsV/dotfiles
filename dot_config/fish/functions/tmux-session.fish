function tmux-session
  set session "$HOME/.config/tmux-sessions/$argv"
  if tmux has-session -t "$argv"
    tmux attach -t "$argv"
  else
    if test -f "$session"
      tmux start \; source-file "$session"
    else
      tmux new -s $argv 
    end
  end
end

function __list_all_tmux_sessions
  set session_dir "$HOME/.config/tmux-sessions/"
  if test -d $session_dir
    find -L "$session_dir" -mindepth 1 -maxdepth 1 -type f -printf '%f\n'
  end
  tmux ls -F '#S Running session' 2>>/dev/null
end 

function __complete_tmux_session
__list_all_tmux_sessions | awk '{ sess[$1] = $0 ;} END { for ( i in sess ) print sess[i]; }'
end

complete -c tmux-session -a '(__complete_tmux_session | sed \'s/ /\\t/1\')' -f
