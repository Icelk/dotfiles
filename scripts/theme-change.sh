#!/bin/bash

# Include cargo programs
PATH=~/.cargo/bin:$PATH

themes="$@"
hc=~/.config

flags=""

for theme in $themes; do
    flags+="-e $theme "
done

corpl $hc/dunst/dunstrc $hc/kitty/kitty.conf $hc/hypr/hyprland.conf $flags
corpl $hc/rofi/colors.rasi $hc/waybar/style.css --comment "/*" --closing-comment "*/" $flags
killall -s SIGUSR1 kitty
systemctl --user restart dunst waybar
