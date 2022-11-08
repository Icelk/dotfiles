#!/bin/sh
sleep="0.5"
sleep $sleep

if /bin/ps -aux | rg -i hyprland\$; then
    hyprctl dispatch dpms off
else
    xset dpms force off
fi
