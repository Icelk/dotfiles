#!/usr/bin/bash
# Copyright © Icelk 2021-present

dev_path=~/dev/

language=$(ls $dev_path | rofi -i -dmenu -p "Choose language")

if [ $? -ne 0 ]; then
    exit 1
fi

project=$(ls $dev_path"$language" | rofi -i -dmenu -p "Choose project")

codium $dev_path"$language"/"$project"