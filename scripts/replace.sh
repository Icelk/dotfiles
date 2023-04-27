#!/bin/sh

function print_help {
    echo "Usage: replace.sh [options] FIND REPLACE-WITH [directory]"
    echo
    echo "Options:"
    echo "    -p  Output result into stdout and do not modify files."
    echo
    echo "Arguments:"
    echo "    Replaces all occurrences of FIND in [directory] (defaults to '.') with REPLACE-WITH."
    echo "    FIND can be a Regex. If REPLACE-WITH is '<empty>', the matched text will be removed."

    exit 1
}

preview=""

fd=""
replace_with=""
dir=""

while test $# -gt 0; do
    case "$1" in
        "--help")
            print_help
            ;;
        "-p")
            preview="-p"
            ;;
        -*)
            echo "Unknown option."
            echo
            print_help
            ;;
        *)
            if [ -z "$fd" ]; then
                fd="$1"
            elif [ -z "$replace_with" ]; then
                replace_with="$1"
            elif [ -z "$dir" ]; then
                dir="$1"
            else
                echo "Trailing arguments."
                echo
                print_help
            fi
            ;;
    esac
    shift
done

if [ -z "$fd" ] || [ -z "$replace_with" ]; then
    echo "Must be run with at least two arguments."
    echo
    print_help
fi

if [ "$replace_with" == '<empty>' ]; then
    replace_with=""
fi

dir=${dir:-"."}

sd $preview "$fd" "$replace_with" $(rg --hidden --one-file-system --files-with-matches "$fd" "$dir" | awk '{print "\""$0"\""}')
