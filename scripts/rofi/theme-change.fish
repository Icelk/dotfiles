#!/usr/bin/fish

set themes "Light
Dark
Dark split"

set selected (string split '\n' $themes | rofi -dmenu -i -p "Select theme")

echo $selected

switch $selected
    case Light
        set selected light
    case Dark
        set selected dark
    case "Dark split"
        set selected "dark split"
    case '*'
        echo "Failed to get theme."
        echo "Got invalid item: $selected"
        exit 1
end

if test -z $selected
    exit 1
end

~/scripts/theme-change.sh $selected
