#!/bin/sh

cd ~

export _JAVA_AWT_WM_NONREPARENTING=1
export XCURSOR_SIZE=24

scripts/import-gsettings-themes.sh

exec Hyprland
