#!/bin/sh

PATH=~/.cargo/bin:$PATH

if rg -q -- '^-- inputVariant = "ansi-switched-slash"$' ~/.config/hypr/hyprland.lua; then
    corpl --comment=-- -k -e ansi-switched ~/.config/hypr/hyprland.lua
    notify-send -a "Keyboard layout" "Now using alternate layout."
else
    corpl --comment=-- -k -d ansi-switched ~/.config/hypr/hyprland.lua
    notify-send -a "Keyboard layout" "Now using default layout."
fi
