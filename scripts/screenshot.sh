#!/usr/bin/sh
file=screenshot-"$(date "+%+4Y-%m-%d-%T")".png
path=~/Pictures/"$file"

pre_sleep="$1"
between_sleep="$2"

if [ -n "$pre_sleep" ]; then
    sleep $pre_sleep
fi

geometry="$(slurp)"
status=$?
if [ $status -gt 0 ]; then
    exit $status
fi

if [ -n "$between_sleep" ]; then
    sleep $between_sleep
fi

grim -g "$geometry" $path

if [ $? -eq 0 ]; then
    notify-send -a "Screenshot" "Saved screenshot to '~/Pictures/$file'"
fi
