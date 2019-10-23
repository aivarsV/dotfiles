function _fzf_marker
	if commandline | grep -q -P '{{'
    set -l strp (commandline | grep -Z -P -b -o "\{\{[\w.()/]+\}\}" | head -1)
    set -l pos (echo $strp | cut -d ":" -f1)
    set -l placeholder (echo $strp | cut -d ":" -f2)
    commandline -r -- (commandline | sed "s|$placeholder||")
    commandline -C $pos
  else
    set -l selected (cat ~/.config/marker/*.txt |sed -e "s/\(^[a-zA-Z0-9_-]\+\)\s/\x1b[38;5;255m\1\x1b[0m /" \
              -e "s/\s*\(#\+\)\(.*\)/\x1b[38;5;8m  \1\2\x1b[0m/" |\
          fzf --reverse --bind 'tab:down,btab:up' --height=80% --ansi -q (commandline -c))
      if test -n "$selected"
        commandline -r -- $selected
      end
    commandline -f repaint
  end
end
