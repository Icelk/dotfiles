#!/bin/sh

cd ~

export _JAVA_AWT_WM_NONREPARENTING=1
export XCURSOR_SIZE=24

Hyprland 2>&1 > hyprland-$(date +%Y-%m-%d_%H:%M:%S).log
