#!/bin/sh

# Include cargo programs
PATH=~/.cargo/bin:$PATH

theme=$1
hc=~/.config

corpl $hc/picom/picom.conf $hc/i3/config $hc/dunst/dunstrc $hc/kitty/kitty.conf ~/scripts/rofi/powermenu.sh -e $theme
corpl $hc/rofi/colors.rasi --comment "/*" --closing-comment "*/" -e $theme
i3-msg restart
systemctl --user restart dunst

# Do polybar later, so i3 had time to restart
corpl $hc/polybar/config.ini -c ";" -e $theme
