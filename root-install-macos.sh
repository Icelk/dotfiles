#!/bin/sh

spt_name="rustlang.spotifyd.plist"
spotifyd="/Library/LaunchDaemons/$spt_name"

cp root/$spt_name $spotifyd
chown root:wheel $spotifyd

launchctl load -w $spotifyd
launchctl start $spotifyd

## Symlink vi and vim to NeoVim
bin="/usr/local/bin"
ln -s $bin/nvim $bin/vim
ln -s $bin/nvim $bin/vi
