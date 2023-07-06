#!/bin/sh

monitor=$1
wallpaper="$2"

store_path=/tmp/hyprpaper-last-wallpaper.txt

old_wallpaper=$(cat $store_path 2>/dev/null)

echo $monitor
echo $wallpaper

echo hyprctl hyprpaper unload "$old_wallpaper"
hyprctl hyprpaper unload "$old_wallpaper"

hyprctl hyprpaper preload "$wallpaper"
hyprctl hyprpaper wallpaper $monitor,"$wallpaper"

echo "$wallpaper" >$store_path
