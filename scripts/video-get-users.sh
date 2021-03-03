#!/usr/bin/fish

set on $argv[1]
set off $argv[2]

set devices (v4l2-ctl --list-devices 2>/dev/null | grep -o "/dev/video[0-9]*")

if test $status -ne 0
    exit 1
end

for device in $devices
    set pid (fuser $device 2>/dev/null | grep -Po " *\K.*")
    if test $status -ne 0
        continue
    end
    set name (ps -p $pid -o comm=)

    echo $on
    exit 0
end

echo $off
exit 0
