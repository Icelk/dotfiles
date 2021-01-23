#!/bin/bash

killall -w polybar

tray_output=DP-0

for m in $(polybar --list-monitors | cut -d ":" -f1); do
    export MONITOR=$m
    if [[ $m != $tray_output ]]; then
        export TRAY_POSITION=none
    fi

    polybar -c ~/.config/polybar/config.ini -r main&
done
