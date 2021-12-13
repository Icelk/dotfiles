#!/bin/sh

name=$1

devices=$(pactl list sinks)

if echo "$devices" | rg " *Name: $name" -q ; then
    echo "$name"
    exit 0
fi

description=$(echo "$devices" | rg -B 1 " *Description: .*$name")

if [[ $? != 0 ]]; then
    exit 1
fi

echo $(echo "$description" | head -n1 | awk '{print $2}')
