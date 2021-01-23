#!/bin/bash

if [ -z "$@" ]; then
    echo -en "Shutdown\0icon\x1fsystem-shutdown-symbolic\n"
    echo -en "Relog\0icon\x1fsystem-log-out-symbolic\n"
    echo -en "Suspend\0icon\x1fsystem-suspend-symbolic\n"
    echo -en "Reboot\0icon\x1fsystem-restart-symbolic\n"
else
    if [ "$1" = "Shutdown" ]; then
        systemctl poweroff
    elif [ "$1" = "Relog" ]; then
        i3-msg exit
    elif [ "$1" = "Reboot" ]; then
        systemctl reboot
    elif [ "$1" = "Suspend" ]; then
        systemctl suspend
    fi
fi
