#!/usr/bin/sh

windows="$(efibootmgr | rg "Windows")"

if test -z "$windows"; then
    notify-send -a "Windows® boot" "Failed to boot into Windows; no boot manager was found, or you don't have 'efibootmgr' installed."
    exit 1
fi

id="$(echo $windows | rg -o "[0-9][0-9][0-9][0-9]" | head -n1)"
doas -n efibootmgr -n $id
if test "$?" != "0"; then
    notify-send -a "Windows® boot" "Failed to set UEFI var NEXT_BOOT. Aborting."
    exit 1
fi
reboot
