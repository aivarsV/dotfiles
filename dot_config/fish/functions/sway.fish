function sway
set -x QT_QPA_PLATFORM wayland-egl
set -x QT_QPA_PLATFORMTHEME qt5ct
set -x CLUTTER_BACKEND wayland
set -x SDL_VIDEODRIVER wayland
set -x GDK_BACKEND wayland
set -x WALLPAPERS_DIR ~/Attēli/wallpapers

systemctl --user set-environment WALLPAPERS_DIR="$WALLPAPERS_DIR"
systemctl --user start html-wallpaper@8000.service

/usr/bin/sway

systemctl --user stop html-wallpaper@8000.service
end
