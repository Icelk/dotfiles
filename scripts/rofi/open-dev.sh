#!/usr/bin/sh
# Copyright © Icelk 2021-present

dev_path=~/dev/
editor="kitty -e"

language=$(ls $dev_path | rofi -i -dmenu -p "Choose language")
if [ $? -ne 0 ]; then exit 1; fi

new_list=$(ls $dev_path"$language")
if [ $? -ne 0 ]; then exit 1; fi

project=$(ls $dev_path"$language" | rofi -i -dmenu -p "Choose project")

ls $dev_path"$language"/"$project" >/dev/null
if [ $? -ne 0 ]; then exit 1; fi

$editor $dev_path"$language"/"$project"
