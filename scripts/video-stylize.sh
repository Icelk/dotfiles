#!/usr/bin/sh

b=50
c=5
s=40

case $1 in
    old)
        b=75
        c=10
        s=0
        ;;
    normal)
        b=75
        c=10
        s=40
        ;;
    insane)
        b=100
        c=10
        s=200
        ;;
    *)
esac

v4l2-ctl --set-ctrl brightness=$b
v4l2-ctl --set-ctrl contrast=$c
v4l2-ctl --set-ctrl saturation=$s
