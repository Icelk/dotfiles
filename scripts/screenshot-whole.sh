#!/usr/bin/sh
path=~/Pictures/screenshot.png

maim $path

notify-send -a "Maim" "Took screenshot of whole screen and saved it to '$path'!"
