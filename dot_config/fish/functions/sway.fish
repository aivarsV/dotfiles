function sway
set -x QT_QPA_PLATFORM wayland-egl
set -x QT_QPA_PLATFORMTHEME qt5ct
set -x CLUTTER_BACKEND wayland
set -x SDL_VIDEODRIVER wayland
set -x GDK_BACKEND wayland
set -x WALLPAPER_FILE ~/Attēli/wallpaper.png
set -x BROWSER firefox

systemctl --user set-environment WALLPAPER_FILE="$WALLPAPER_FILE"
systemctl --user start html-wallpaper@8000.service

/usr/bin/sway

systemctl --user stop html-wallpaper@8000.service
systemctl --user stop fetch-wallpaper.timer
end
