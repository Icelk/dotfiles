#!/bin/sh

theme=$1
hc=~/.config

corpl $hc/picom/picom.conf $hc/i3/config $hc/dunst/dunstrc $hc/alacritty/alacritty.yml ~/scripts/rofi/powermenu.sh -e $theme
corpl $hc/rofi/colors.rasi --comment "/*" --closing-comment "*/" -e $theme
i3-msg restart

# Do poly bar later, so i3 had time to restart
corpl $hc/polybar/config.ini -c ";" -e $theme
