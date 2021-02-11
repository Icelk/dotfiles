#!/bin/sh

theme=$1

corpl ~/.config/polybar/config.ini -c ";" -e $theme
corpl ~/.config/i3/config ~/.config/dunst/dunstrc -e $theme
i3-msg restart
