#!/usr/bin/bash

echo "Starting backup sync!"

# -P: progress h: human a: archive v: verbose

rsync -ahP --del --delete-excluded /home icelk@nas:/mnt/main/computer_erik/ --exclude-from="/home/icelk/Exclude-backup-home.txt"
echo "Done with /home"
rsync -ahP --del --delete-excluded /var icelk@nas:/mnt/main/computer_erik/ --exclude-from="/home/icelk/Exclude-backup.txt"
echo "Done with /var"
rsync -ahP --del --delete-excluded /usr/share icelk@nas:/mnt/main/computer_erik/usr/ --exclude-from="/home/icelk/Exclude-backup-usr-share.txt"
echo "Done with /usr/share"
rsync -ahP --del --delete-excluded /usr/local icelk@nas:/mnt/main/computer_erik/usr/
echo "Done with /usr/local"
rsync -ahP --del --delete-excluded /etc icelk@nas:/mnt/main/computer_erik/ --exclude-from="/home/icelk/Exclude-backup.txt"
echo "Done with /etc"

mounted=$(mount -l)

if echo $mounted | grep -q "/boot "; then
    rsync -ahP --del --delete-excluded /boot icelk@nas:/mnt/main/computer_erik/ --exclude-from="/home/icelk/Exclude-backup.txt"
    echo "Done with /boot"
else
    echo "/boot is not mounted, not syncing."
fi
if echo $mounted | grep -q "/archive "; then
    rsync -ahP --del --delete-excluded /archive icelk@nas:/mnt/main/computer_erik/ --exclude-from="/home/icelk/Exclude-backup-archive.txt"
    echo "Done with /archive"
else
    echo "/archive is not mounted, not syncing."
fi
if echo $mounted | grep -q "/win "; then
    rsync -ahP --del --delete-excluded /win icelk@nas:/mnt/main/computer_erik/ --exclude-from="/home/icelk/Exclude-backup-win.txt"
    echo "Done with /win"
else
    echo "/win is not mounted, not syncing."
fi
