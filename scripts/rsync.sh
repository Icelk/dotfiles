#!/usr/bin/bash

echo "Starting backup sync!"

# -P: progress h: human a: archive v: verbose

rsync -a --del --delete-excluded /home icelk@nas:/mnt/main/computer_erik/ --exclude-from="/home/icelk/Exclude-backup.txt"
echo "Done with /home"
rsync -a --del --delete-excluded /var icelk@nas:/mnt/main/computer_erik/ --exclude-from="/home/icelk/Exclude-backup.txt"
echo "Done with /var"
rsync -a --del --delete-excluded /usr/share icelk@nas:/mnt/main/computer_erik/usr/ --exclude-from="/home/icelk/Exclude-backup-usr-share.txt"
echo "Done with /usr/share"
rsync -a --del --delete-excluded /usr/local icelk@nas:/mnt/main/computer_erik/usr/
echo "Done with /usr/local"
rsync -a --del --delete-excluded /etc icelk@nas:/mnt/main/computer_erik/ --exclude-from="/home/icelk/Exclude-backup.txt"
echo "Done with /etc"
rsync -a --del --delete-excluded /boot icelk@nas:/mnt/main/computer_erik/ --exclude-from="/home/icelk/Exclude-backup.txt"
echo "Done with /boot"

rsync -a --del --delete-excluded /archive icelk@nas:/mnt/main/computer_erik/ --exclude-from="/home/icelk/Exclude-backup-archive.txt"
echo "Done with /archive"
rsync -a --del --delete-excluded /win icelk@nas:/mnt/main/computer_erik/ --exclude-from="/home/icelk/Exclude-backup-win.txt"
echo "Done with /win"
