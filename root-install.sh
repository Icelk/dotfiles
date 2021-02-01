#!/bin/bash

echo "Warning: You must be in the dotfile's root directory when running this script."
echo "Warning: This folder should be in a permanent place before running this script. Else critical system files will be broken links!"
echo "This script will not create or remove any folders/files. If errors appear, nothing has be
en overriden. You must have root privileges to run this script."
read -p "Press enter to continue or Ctrl+C to exit..."

shopt -s expand_aliases

echo "Add the -f flag to the following line in this script to override any present files. Can b
e used after moving the dotfiles directory."
alias l="ln -s"
wdr="$PWD/root"

# Suppress kernel info messages at boot.
l $wdr/kernel-info.conf /etc/sysctl.d/disable-kernel-info.conf

# Make the main RAM more used
l $wdr/swappiness.conf /etc/sysctl.d/less_swappy.conf

# Disable mouse acceleration
l $wdr/mouse-acceleration.conf /etc/X11/xorg.conf.d/50-mouse-acceleration.conf

# Set DPMS timeout to 5 minutes
l $wdr/dpms.conf /etc/X11/xorg.conf.d/40-dpms.conf

# Enable auto-login
#ln -s $PWD/root/getty.conf /etc/systemd/system/getty@tty1.service.d/override.conf
echo "An automatic login configuration file is included but not in this install script due to the username being needed. The line above (in this script) can be used to create a symlink."

echo "An xorg configuration file is included but not in this install script due to hardware-specific configuration."

