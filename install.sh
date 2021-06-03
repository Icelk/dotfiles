#!/bin/bash

echo "Some of the files has me (icelk) as a hardcoded user, mostly in ssh and /home/icelk."
echo "The file \"icelk-specific.txt\" contains all files I'm hardcoded in, and where."

echo

echo "Warning: You must be in the dotfile's root directory when running this script."
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

## Fish
l $wdc/fish/ $hc/fish

## Kitty
l $wdc/kitty.conf $hc/kitty/kitty.conf

## Kitty
l $wdc/kitty.conf $hc/kitty/kitty.conf

## NeoVim
l $wdc/nvim/init.vim $hc/nvim/
l $wdc/nvim/coc-settings.json $hc/nvim/

## Spotifyd
l $wdc/spotifyd.conf $hc/spotifyd/

## Starship
l $wdc/starship.toml $hc/

##-----------
# Home files
##-----------

l $wdh/aliases ~/.aliases
l $wdh/gitconfig ~/.gitconfig
l $wdh/Config-files.txt ~/
l $wdh/ssh ~/.ssh/config
l $wdh/vim-things.md ~/
