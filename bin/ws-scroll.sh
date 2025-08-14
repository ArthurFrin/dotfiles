#!/bin/bash
lockfile=/tmp/hypr-scroll.lock
if [ -f "$lockfile" ]; then
    exit
fi
touch "$lockfile"
if [ "$1" = "up" ]; then
    hyprctl dispatch workspace e+1
else
    hyprctl dispatch workspace e-1
fi
sleep 0.15
rm -f "$lockfile"

