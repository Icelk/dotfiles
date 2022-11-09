#!/usr/bin/fish

set on $argv[1]
set off $argv[2]
# pipewire watches from both pipewire and wireplumber
# it doesn't seem like any application uses this interface to access video, so it's safe to ignore for now
set watch_limit 2

set devices (v4l2-ctl --list-devices 2>/dev/null | grep -o "/dev/video[0-9]*")

if test $status -ne 0
    # No video device is connected
    echo $off
    exit 0
end

set count 0

for device in $devices
    set pid (fuser $device 2>/dev/null | grep -Po " *\K.*")
    if test $status -ne 0
        continue
    end
    set pids (echo $pid | string split -n " ")
    set c (count $pids)

    set count (math $count + $c)
end

if test $count -gt $watch_limit
    echo $on
    exit 0
end

echo $off
exit 0
