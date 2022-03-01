#!/bin/fish

if echo $argv | rg -q -- "--help"
    echo "Usage: totp.fish APPLICATION LOCKED_UUID UNLOCKED_UUID"
    echo
    echo "Unlocks the device with UUID LOCKED_UUID (e.g. a LUKS partition)"
    echo "Mounts the device with UUID UNLOCKED_UUID (e.g. the UUID of the file system of the LUKS partition)"
    echo "Reads the file <mounted device>/totp/<APPLICATION>. That file should contain the token."
    echo
    echo "Example: one can have the file `totp/github` (on an USB) with the GitHub token. Then, set up a script which calls this script with args `github` and the UUIDs of my device."
    exit
end

set application $argv[1]

if test -z $application
    echo "Specify the application as the first argument."
    exit 1
end

# set uuid "da2b22be-2cb9-4298-957d-63e0c70c6a0a"
# set unlocked_uuid "918c4335-abcd-4834-9f38-59d5fffc651a"
set uuid $argv[2]
set unlocked_uuid $argv[3]
if test -z $uuid || test -z $unlocked_uuid
    echo "Specify device UUIDs. See `--help`."
    exit 1
end

if ! ls /dev/disk/by-uuid/$remote_uuid 2>/dev/null 1>&2
    echo "Removable not inserted. Exiting."
    exit 1
end

# reset
udisksctl unmount -b /dev/disk/by-uuid/$unlocked_uuid 2>/dev/null 1>&2
udisksctl lock -b /dev/disk/by-uuid/$uuid 2>/dev/null 1>&2

set unlock (udisksctl unlock -b /dev/disk/by-uuid/$uuid 2>/dev/null)
if test $status -ne 0
    echo "Failed to unlock device."
    exit 1
end

set disk (echo "$unlock" | awk '{print $4}' | string split .)[1]

set location (udisksctl mount -b $disk)
if test $status -ne 0
    echo "Failed to mount device."
    exit 1
end
set location (echo "$location" | awk '{print $4}')
set token (cat "$location/totp/$application")

if test $status -ne 0
    echo "TOTP token file not found. Looked in $location/totp/$application"
    exit 1
end

echo "First one is the current. Prints the next two if you don't enter the code in time."
oathtool -w2 --totp --base32 "$token"

udisksctl unmount -b /dev/disk/by-uuid/$unlocked_uuid 1>/dev/null
udisksctl lock -b /dev/disk/by-uuid/$uuid 1>/dev/null
