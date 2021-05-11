#!/bin/bash

echo
echo "Type 'exit' or 'e' and <enter> to leave or <enter> to generate a new password."
echo
pass

while : ; do
    read
    line=${REPLY}
    case $line in
        exit | e)
            exit 0;;
        *) ;;
    esac

    pass
done
