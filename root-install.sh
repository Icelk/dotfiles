#!/bin/bash

echo "Warning: You must be in the dotfile's root directory when running this script."
echo "Warning: This folder should be in a permanent place before running this script. Else critical system files will be broken links!"
echo "This script will not create or remove any folders/files. If errors appear, nothing has be
en overriden. You must have root privileges to run this script."
echo "The owner of the doas config file will be changed to root."
read -p "Press enter to continue or Ctrl+C to exit..."

shopt -s expand_aliases

echo "Add the -f flag to the following line in this script to override any present files. Can b
e used after moving the dotfiles directory."
alias l="ln -s"
wdr="$PWD/root"
bin="/usr/bin"

# Suppress kernel info messages at boot.
l $wdr/kernel-info.conf /etc/sysctl.d/disable-kernel-info.conf

# Make the main RAM more used
l $wdr/swappiness.conf /etc/sysctl.d/less_swappy.conf

# Disable mouse acceleration
l $wdr/mouse-acceleration.conf /etc/X11/xorg.conf.d/50-mouse-acceleration.conf

# Set DPMS timeout to 5 minutes
l $wdr/dpms.conf /etc/X11/xorg.conf.d/40-dpms.conf

# Pacman config
l $wdr/pacman.conf /etc/

# Enable auto-login
#mkdir /etc/systemd/system/getty@tty1.service.d
#ln -s $PWD/root/getty.conf /etc/systemd/system/getty@tty1.service.d/override.conf
echo "An automatic login configuration file is included but not in this install script due to the username being needed. The line above (in this script) can be used to create a symlink."

#ln -s $PWD/root/xorg.conf /etc/X11/
echo "A xorg configuration file is included but not in this install script due to hardware-specific configuration. The line above (in this script) can be used to create a symlink."

#ln -s $PWD/root/fstab /etc/
#ln -s $PWD/root/rsnapshot.config /etc/
echo "rsnapshot and fstab config files in included but not in this install script due to hardware-specific mount-points."

# rustup pacman hook
l $wdr/rustup.hook /etc/pacman.d/hooks/
echo "A rustup pacman hook has been installed. It will update Rust when the system updates. To remove it, remove /etc/pacman.d/hooks/rustup.hook"
# Kora icon theme hook
l $wdr/kora.hook /etc/pacman.d/hooks/

l $bin/nvim $bin/vi
l $bin/nvim $bin/vim

read -p "The following will override certain system files. Press Ctrl+C to quit."
read -p "Please make sure this is what you want; it'll DELETE the target files!"
read -p "Also make sure your user is part of the 'wheel' group as the doas configuration file only allows users in that group."

# Reduced pam failure timeout
l -f $wdr/pam-system-auth /etc/pam.d/system-auth

# Hosts
l -f $wdr/hosts /etc/
echo "The hosts file contains 'icelk' as the name of the computer. You might want to change that if you want another name to link to localhost."

# makepkg
l -f $wdr/makepkg.conf /etc/

# doas
l -f $wdr/doas.conf /etc/
chown root /etc/doas.conf

# pacman
l -f $wdr/pacman.conf /etc/

# reflector
# ln -sf $wdr/reflector.conf /etc/xdg/reflector/
echo "A reflector configuration file was included, but it contains location-specific options and isn't installed. See this script for the command."
