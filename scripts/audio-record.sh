#!/usr/bin/sh

device=$1
output=$2

if [ "$1" == "--help" ]; then
    echo -e "\
First argument is source. \
Use \`pactl list short sources\` to get available sources. \
Alternatively, use \`default\` for your default input source.\n\
\n\
Second argument is output file. This script will append \`.m4a\` to it."
    exit 1
fi

ffmpeg -f pulse -i $device -ac 2 $output.m4a
