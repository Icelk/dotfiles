#!/bin/sh

alternate=$(rg -q "# kb_variant = ansi-switched-slash" ~/.config/hypr/hyprland.conf; echo $?)

PATH=~/.cargo/bin:$PATH

if [ $alternate == "0" ]; then
    corpl -k -e ansi-switched ~/.config/hypr/hyprland.conf
    notify-send -a "Keyboard layout" "Now using alternate layout."
else
    corpl -k -d ansi-switched ~/.config/hypr/hyprland.conf
    notify-send -a "Keyboard layout" "Now using default layout."
fi
