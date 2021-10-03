#!/usr/bin/bash

set -e

function dm {
    rofi -dmenu -l $1 -i -p "$2" -matching ${3:normal}
}
function choose-services {
    services=$(cat - | awk "{gsub(/.service/, \"\", \$1); print \$1}")

    # Get count
    count=$(echo "$services" | wc -l)

    # If count >= 40, clamp it!
    if [[ $count -gt 40 ]]; then
        count=40
    fi

    echo "$services" | dm $count "$1" ${3:normal}
}
function get-running-service {
    services=$(systemctl --user list-units --state=active --type=service --no-pager --no-legend)

    echo "$services" | choose-services "$1"
}
function get-inactive-service {
    active_services=$(systemctl --user list-units --state=active --type=service --no-pager --no-legend | awk "{print \$1}")
    # inactive_services=$(systemctl --user list-units --state=inactive --type=service --no-pager --no-legend | grep "loaded *inactive" | awk "{print \$1}")
    all_services=$(systemctl --user list-unit-files --type=service --no-pager --no-legend | awk "{print \$1}")

    inactive_services="$(echo -e "${active_services[@]}\n${all_services[@]}" | sort | uniq -u)"

    echo "$inactive_services" | choose-services "$1"
}

modes="\
Restart
Stop
Start"

mode=$(echo "$modes" | dm 3 "Mode" "prefix")

case $mode in
    "Restart")
        service=$(get-running-service "Restart")
        systemctl --user restart "$service"
    ;;
    "Stop")
        service=$(get-running-service "Stop")
        systemctl --user stop "$service"
    ;;
    "Start")
        service=$(get-inactive-service "Start")
        systemctl --user start "$service"
    ;;
    *)
        exit 1
    ;;
esac
