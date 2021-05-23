#!/usr/bin/sh

mode="2560x1440"
rate=165

xrandr --output DP-2 --mode $mode --rate $rate --pos 0x0
xrandr --output DP-0 --mode $mode --rate $rate --right-of DP-2 --primary

sleep 5
systemctl --user restart polybar nitrogen
