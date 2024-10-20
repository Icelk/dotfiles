#!/usr/bin/bash

dataset="aperol/backup/erik-home"
host="tensor"
user="erik"

n=1
while ! ssh $user@tensor; do 
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

notify-send -a "Sync" "Starting..."

# -P: progress h: human a: archive v: verbose

rsync -ahP --del --delete-excluded /home $user@"$host:/$dataset/" --exclude-from="/home/icelk/Exclude-backup-home.txt"
echo "Done with /home"
rsync -ahP --del --delete-excluded /var $user@"$host:/$dataset/" --exclude-from="/home/icelk/Exclude-backup.txt"
echo "Done with /var"
rsync -ahP --del --delete-excluded /usr/local $user@"$host:/$dataset/usr/"
echo "Done with /usr/local"
rsync -ahP --del --delete-excluded /usr/etc $user@"$host:/$dataset/usr/"
echo "Done with /usr/etc"
rsync -ahP --del --delete-excluded /etc $user@"$host:/$dataset/" --exclude-from="/home/icelk/Exclude-backup.txt"
echo "Done with /etc"

mounted=$(mount -l)

if echo $mounted | grep -q "/boot "; then
    rsync -ahP --del --delete-excluded /boot $user@"$host:/$dataset/" --exclude-from="/home/icelk/Exclude-backup.txt"
    echo "Done with /boot"
else
    echo "/boot is not mounted, not syncing."
fi
# if echo $mounted | grep -q "/win "; then
#     rsync -ahP --del --delete-excluded /win $user@"$host:/$dataset/" --exclude-from="/home/icelk/Exclude-backup-win.txt"
#     echo "Done with /win"
# else
#     echo "/win is not mounted, not syncing."
# fi

notify-send -a "Sync" "Complete!"
