#!/usr/bin/sh

device=$1
output=$2

if [ "$1" == "--help" ]; then
    echo -e "\
First argument is source. \
Use the flag \`--list\` to get available sources. \
Alternatively, use \`default\` for your default input source.\n\
\n\
Second argument is output file. This script will append \`.m4a\` to it."
    exit 1
fi
if [ "$1" == "--list" ]; then
    pactl list short sources
    exit
fi

ffmpeg -f pulse -i $device -ac 2 $output.m4a
