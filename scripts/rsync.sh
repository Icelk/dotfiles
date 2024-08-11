#!/usr/bin/bash

n=1
while ! ssh icelk@nas; do 
    n=$((n+1))
    if [[ n -gt 20 ]]; then
        exit 0
    fi
    if [[ n -gt 10 ]]; then
        sleep 5
    else
        sleep 1
    fi
done

dataset="computer_erik"

notify-send -a "Sync" "Starting..."

# -P: progress h: human a: archive v: verbose

rsync -ahP --del --delete-excluded /home icelk@nas:/mnt/main/$dataset/ --exclude-from="/home/icelk/Exclude-backup-home.txt"
echo "Done with /home"
rsync -ahP --del --delete-excluded /var icelk@nas:/mnt/main/$dataset/ --exclude-from="/home/icelk/Exclude-backup.txt"
echo "Done with /var"
rsync -ahP --del --delete-excluded /usr/local icelk@nas:/mnt/main/$dataset/usr/
echo "Done with /usr/local"
rsync -ahP --del --delete-excluded /usr/etc icelk@nas:/mnt/main/$dataset/usr/
echo "Done with /usr/etc"
rsync -ahP --del --delete-excluded /etc icelk@nas:/mnt/main/$dataset/ --exclude-from="/home/icelk/Exclude-backup.txt"
echo "Done with /etc"

mounted=$(mount -l)

if echo $mounted | grep -q "/boot "; then
    rsync -ahP --del --delete-excluded /boot icelk@nas:/mnt/main/$dataset/ --exclude-from="/home/icelk/Exclude-backup.txt"
    echo "Done with /boot"
else
    echo "/boot is not mounted, not syncing."
fi
if echo $mounted | grep -q "/archive "; then
    rsync -ahP --del --delete-excluded /archive icelk@nas:/mnt/main/$dataset/ --exclude-from="/home/icelk/Exclude-backup-archive.txt"
    echo "Done with /archive"
else
    echo "/archive is not mounted, not syncing."
fi
if echo $mounted | grep -q "/win "; then
    rsync -ahP --del --delete-excluded /win icelk@nas:/mnt/main/$dataset/ --exclude-from="/home/icelk/Exclude-backup-win.txt"
    echo "Done with /win"
else
    echo "/win is not mounted, not syncing."
fi

notify-send -a "Sync" "Complete!"
