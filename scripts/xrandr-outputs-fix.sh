#!/usr/bin/sh

mode="2560x1440"
rate=165

xrandr --output DP-0 --mode $mode --rate $rate
xrandr --output DP-2 --mode $mode --rate $rate

xrandr --output DP-0 --panning 2560x1440+0+0 --primary --pos 0x0
xrandr --output DP-2 --panning 2560x1440+0+0 --left-of DP-0

sleep 5
systemctl --user restart polybar nitrogen
