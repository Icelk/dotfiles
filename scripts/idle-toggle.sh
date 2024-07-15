#!/bin/sh

alternate=$(rg -q "# timeout = 30" ~/.config/hypr/hypridle.conf; echo $?)

PATH=~/.cargo/bin:$PATH

if [ $alternate == "0" ]; then
    corpl -k -e powersave ~/.config/hypr/hypridle.conf
    notify-send -a "Idle timers" "Reenabled powersave"
else
    corpl -k -d powersave ~/.config/hypr/hypridle.conf
    notify-send -a "Idle timers" "Disabled powersave"
fi

killall hypridle
