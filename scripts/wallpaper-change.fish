#!/usr/bin/fish

# Smoothly changes wallpapers every $hold seconds.
set hold 60

# you need the packages `xwinwrap-git` and `feh` to run this.

while :; xwinwrap -b -fs -sp -ov -- feh --bg-fill --random /home/icelk/Pictures/wallpapers/; sleep $hold; end
