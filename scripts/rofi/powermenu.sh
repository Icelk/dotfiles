#!/usr/bin/sh

if [ -z "$@" ]; then
    # CORPL option light
    # echo -en "Shutdown\0icon\x1fsystem-shutdown\n"
    # echo -en "Close GUI\0icon\x1fsystem-log-out\n"
    # echo -en "Suspend\0icon\x1fsystem-suspend\n"
    # echo -en "Reboot\0icon\x1fsystem-restart\n"
    # CORPL option dark
    echo -en "Shutdown\0icon\x1fsystem-shutdown-symbolic\n"
    echo -en "Close GUI\0icon\x1fsystem-log-out-symbolic\n"
    echo -en "Suspend\0icon\x1fsystem-suspend-symbolic\n"
    echo -en "Reboot\0icon\x1fsystem-restart-symbolic\n"
    # CORPL end
else
    if [ "$1" = "Shutdown" ]; then
        systemctl poweroff
    elif [ "$1" = "Close GUI" ]; then
        i3-msg exit
    elif [ "$1" = "Reboot" ]; then
        systemctl reboot
    elif [ "$1" = "Suspend" ]; then
        systemctl suspend
    fi
fi
