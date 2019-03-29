if [[ ! $DISPLAY && $XDG_VTNR -eq 1 && -e "$HOME/.xinitrc" ]]; then
    exec startx ~/.xinitrc i3
fi