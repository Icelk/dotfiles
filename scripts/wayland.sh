#!/bin/sh

export LIBVA_DRIVER_NAME=nvidia
export XDG_SESSION_TYPE=wayland
export GBM_BACKEND=nvidia-drm
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export WLR_NO_HARDWARE_CURSORS=1
Hyprland 2>&1 > hyprland-$(date +%Y-%d-%m_%H:%M:%S).log
