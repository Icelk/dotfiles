#!/usr/bin/fish

if test -z $argv[1]
    echo "State target seconds after boot as first argument."
    exit 1
end

set after $argv[1]

set time (cat /proc/uptime | awk '{print $1}')

while test $time -lt $after
    set time (cat /proc/uptime | awk '{print $1}')
    sleep 1
end
