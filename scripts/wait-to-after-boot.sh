#!/usr/bin/bash

after=10

IFS=".";
time=("0");

while [ "$time" -lt "$after" ]; do
    read -ra time <<< "$(cat /proc/uptime)"
    sleep 0.1
done
