#!/usr/bin/sh

echo "This uses outputs specific to my system. Change them in this script."
echo "Outputs can be listed using \`pactl list sinks\`."
echo
echo "Set \`stop\` as the first argument to revert all changes."

ml="Simultaneous:monitor_FL"
mr="Simultaneous:monitor_FR"
l="playback_FL"
r="playback_FR"

o1="alsa_output.usb-Blue_Microphones_Yeti_Stereo_Microphone_REV8-00.analog-stereo"
o2="alsa_output.pci-0000_09_00.4.analog-stereo"
o1c="$"

pw-link -d $ml $o1:$l
pw-link -d $ml $o2:$l
pw-link -d $mr $o1:$r
pw-link -d $mr $o2:$r

pactl unload-module module-null-sink

if [ "$1" != "stop" ]; then
    pactl load-module module-null-sink media.class=Audio/Sink sink_name=Simultaneous channel_map=stereo
    pw-link $ml $o1:$l
    pw-link $ml $o2:$l
    pw-link $mr $o1:$r
    pw-link $mr $o2:$r
fi
