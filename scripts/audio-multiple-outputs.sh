#!/usr/bin/bash

echo "This uses outputs specific to my system. Change them in this script."
echo "Outputs can be listed using \`pactl list sinks\`."
echo
echo "Set \`stop\` as the first argument to revert all changes."

if [[ "$1" != "stop" && ("$1" == "" || "$2" == "") ]]; then
    echo
    echo "You must input at least two devices or 'stop'."
    exit 1
fi

echo

ml="Simultaneous:monitor_FL"
mr="Simultaneous:monitor_FR"
l="playback_FL"
r="playback_FR"

for dev in "$(cat /tmp/audio-multiple-devices-list.txt 2>/dev/null)"
do
    if [ "$dev" != "" ]; then
        echo "Unlinking '$dev'."
        pw-link -d $ml $dev:$l
        pw-link -d $mr $dev:$r
    fi
done

rm -f /tmp/audio-multiple-devices-list.txt

pactl unload-module module-null-sink

if [ "$1" != "stop" ]; then
    pactl load-module module-null-sink media.class=Audio/Sink sink_name=Simultaneous channel_map=stereo

    for dev in "$@"
    do
        dev=$(~/scripts/audio-get-device.sh "$dev")
        echo "Linking $dev."
        pw-link $ml $dev:$l
        pw-link $mr $dev:$r
    done

    echo "$@" > /tmp/audio-multiple-devices-list.txt
fi
