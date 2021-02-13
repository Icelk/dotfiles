#!/bin/sh

theme=$1
hc=~/.config

corpl $hc/polybar/config.ini -c ";" -e $theme
corpl $hc/i3/config $hc/dunst/dunstrc $hc/alacritty/alacritty.yml ~/scripts/rofi/powermenu.sh -e $theme
corpl $hc/rofi/colors.rasi --comment "/*" --closing-comment "*/" -e $theme
sleep 0.25
i3-msg restart
