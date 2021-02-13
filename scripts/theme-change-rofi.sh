#!/usr/bin/fish

set themes "Light Dark"

set selected (string split ' ' $themes | rofi -dmenu)

echo $selected

switch $selected
    case Light
        set selected light
    case Dark
        set selected dark
    case '*'
        echo "Failed to get theme."
        exit 1
end

if test -z $selected
    exit 1
end

~/scripts/theme-change.sh $selected
