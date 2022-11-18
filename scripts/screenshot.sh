#!/usr/bin/sh
file=screenshot-"$(date "+%+4Y-%m-%d-%T")".png
path=~/Pictures/"$file"

grim -g "$(slurp)" $path

if [ $? -eq 0 ]; then
    notify-send -a "Screenshot" "Saved screenshot to '~/Pictures/$file'"
fi
