new-session ~/.scripts/status_info
split-window -h -p 75 journalctl -f 
split-window -v -b -p 80 newsboat
set-option status off
