#!/usr/bin/sh

set -e

local_uuid="<redacted>"
local_label="<redacted>"

remote_uuid="<redacted>"
remote_label="<redacted>"

if ! ls /dev/disk/by-uuid/$remote_uuid 2>/dev/null 1>&2; then echo "Removable not inserted. Exiting."; exit 1; fi

echo "If any errors occur, please lock the disks."

udisksctl unlock -b /dev/disk/by-uuid/$local_uuid
udisksctl mount -b /dev/disk/by-label/$local_label

udisksctl unlock -b /dev/disk/by-uuid/$remote_uuid
udisksctl mount -b /dev/disk/by-label/$remote_label

rsync -rvPhL --del "/run/media/$USER/$remote_label/" "/run/media/$USER/$local_label/"

udisksctl unmount -b /dev/disk/by-label/$local_label
udisksctl lock -b /dev/disk/by-uuid/$local_uuid

udisksctl unmount -b /dev/disk/by-label/$remote_label
udisksctl lock -b /dev/disk/by-uuid/$remote_uuid
