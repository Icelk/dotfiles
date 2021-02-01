#!/bin/bash

echo "Warning: This folder should be in a permanent place before running this script."
echo "This script will not create or remove any folders/files. If errors appear, nothing has been overriden."
read -p "Press enter to continue or Ctrl+C to exit..."

shopt -s expand_aliases

echo "Add the -f flag to the following line in this script to override any present files. Can be used after moving the dotfiles directory."
alias l="ln -s"
wdc="$PWD/config"
wdh="$PWD/home"
hc=~/.config

##-------
# Config
##-------

## VSCodium
l $wdc/VSCodium/User/keybindings.json $hc/VSCodium/User/
l $wdc/VSCodium/User/settings.json $hc/VSCodium/User/
l $wdc/vscode.json $hc/.vscode/settings.json

## Alacritty
l $wdc/alacritty.yml $hc/alacritty/

## Dunst
l $wdc/dunstrc $hc/dunst/

## Fish
l $wdc/config.fish $hc/fish/
l $wdc/fish_variables $hc/fish/

## Gtk
l $wdc/gtk-3.0.ini $hc/gtk-3.0/

## i3
l $wdc/i3 $hc/i3/config

## Picom
l $wdc/picom.conf $hc/picom/

## Polybar
l $wdc/polybar.ini $hc/polybar/config.ini

## Rofi
l $wdc/rofi/ $hc/rofi

## Spotifyd
l $wdc/spotifyd.conf $hc/spotifyd/spotifyd.conf

## Systemd
l $wdc/systemd/ $hc/systemd/user

## Thunar
l $wdc/thunar-uca.xml $hc/Thunar/uca.xml

##--------
# Scripts
##--------

l $PWD/scripts/ ~/scripts


##---------
# Packages
##---------

l $PWD/packages/ ~/packages

##-----------
# Home files
##-----------

l $wdh/aliases ~/.aliases
l $wdh/gitconfig ~/.gitconfig
l $wdh/gtkrc-2.0 ~/.gtkrc-2.0
l $wdh/profile ~/.profile
l $wdh/xinitrc ~/.xinitrc
l $wdh/zprofile ~/.zprofile
l $wdh/zshrc ~/.zshrc

## Backup exclude
l $wdh/Exclude-backup.txt ~/Exclude-backup.txt
l $wdh/Exclude-backup-archive.txt ~/Exclude-backup-archive.txt
l $wdh/Exclude-backup-usr-share.txt ~/Exclude-backup-usr-share.txt
l $wdh/Exclude-backup-win.txt ~/Exclude-backup-win.txt
