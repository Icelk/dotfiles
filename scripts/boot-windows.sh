#!/usr/bin/sh

windows="$(efibootmgr | grep "Windows")"

if test -z "$windows"; then
    notify-send -a "Windows® boot" "Failed to boot into Windows; no boot manager was found, or you don't have 'efibootmgr' installed."
    exit 1
fi

id="$(echo $windows | grep -o "[0-9][0-9][0-9][0-9]" | cut --delimiter \n --fields 1)"
doas /usr/bin/efibootmgr -n $id
if test "$?" != "0"; then
    notify-send -a "Windows® boot" "Failed to set UEFI var NEXT_BOOT. Aborting."
    exit 1
fi
reboot
