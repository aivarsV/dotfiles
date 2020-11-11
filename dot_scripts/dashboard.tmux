new-session -s dashboard bash -c 'sleep 1; exec conky -c ~/.config/conky/dashboard.conf'
split-window -h -p 75 newsboat
set-option status off
