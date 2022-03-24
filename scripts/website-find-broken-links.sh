#!/bin/sh

website="$1"

wget --spider -r -nd -nv -l 5 -w0 -o /dev/stdout "$website"
