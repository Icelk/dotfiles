#!/usr/bin/sh

if [ -z "$@" ]; then
    echo -en "Shutdown\0icon\x1fsystem-shutdown-symbolic\n"
    echo -en "Close GUI\0icon\x1fsystem-log-out-symbolic\n"
    echo -en "Windows®\0icon\x1fdistributor-logo-windows\n"
    echo -en "Suspend\0icon\x1fsystem-suspend-symbolic\n"
    echo -en "Reboot\0icon\x1fsystem-reboot-symbolic\n"
else
    if [ "$1" = "Shutdown" ]; then
        systemctl poweroff
    elif [ "$1" = "Close GUI" ]; then
        hyprctl dispatch exit
    elif [ "$1" = "Windows®" ]; then
        ~/scripts/boot-windows.sh
    elif [ "$1" = "Reboot" ]; then
        systemctl reboot
    elif [ "$1" = "Suspend" ]; then
        systemctl suspend
    fi
fi
