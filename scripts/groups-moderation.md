## And and remove groups

Add: `groupadd <group>`

Delete: `groupdel <group>`

## Change groups

Change name: `groupmod -n <new-name> <old-name>`

Change gid: `groupmod -g <new-gid> <name>`

## Add and remove users from groups

Add: `gpasswd -a <user> <group>`

Delete: `gpasswd -d <user> <group>`

## Group password(?)

Remove: `gpasswd -r <group>`

Change: `gpasswd <group>`

List user as admin: `gpasswd -A <user> <group>`
List user as member (default behaviour): `gpasswd -M <user> <group>`
