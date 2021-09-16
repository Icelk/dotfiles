#!/usr/bin/sh

timeout 10 ~/scripts/internet-wait.sh

sleep 1

systemctl --user start thunar gvfs-udisks2-volume-monitor
