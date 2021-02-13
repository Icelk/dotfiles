#!/bin/sh

theme=$1

corpl ~/.config/polybar/config.ini -c ";" -e $theme
corpl ~/.config/i3/config ~/.config/dunst/dunstrc ~/.config/alacritty/alacritty.yml -e $theme
corpl ~/.config/rofi/colors.rasi --comment "/*" --closing-comment "*/" -e $theme
sleep 0.25
i3-msg restart
