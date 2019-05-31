function sway
	set -x QT_QPA_PLATFORM wayland-egl
set -x CLUTTER_BACKEND wayland
set -x SDL_VIDEODRIVER wayland
set -x GDK_BACKEND wayland
/usr/bin/sway
end
