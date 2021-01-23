#!/usr/bin/sh
path=~/Pictures/screenshot.png

maim -su $path

notify-send -a "Maim" "Took screenshot and saved it to '$path'!"
