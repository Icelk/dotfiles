# Create SSH server-client keypair
This can be used to create a keypair to enable connection to a SSH server without entering a password.

> It may be desirable to add the server to your `/etc/hosts` file.
> For example, add the line `192.168.86.2    nas` to enable connecting to `root@nas` -> `root@192.168.86.2`

First, create a keypair
```sh
ssh-keygen -t rsa -b 4096
```

then copy it to the remote server
```sh
ssh-copy-id <user>@<host>
```

then, optionally move the id_rsa to your `.private` (e.g. `.private/nas.rsa`) directory and add the following lines to your `.ssh/config`
```
Host nas
HostName nas
IdentityFile ~/.private/nas.rsa
```

> Make sure the `.private` directory is only accessible to you.
> It can be done by `chmod g-r,o-r ~/.private`
> g-r means remove read permission from group
> o-r means remove read permission from others
> Check with ls -la if the directory now has the permissions `drwx--x--x`
