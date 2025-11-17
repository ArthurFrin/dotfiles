#!/bin/bash

WALLPAPERS_DIR="$HOME/wallpapers"
STATE_FILE="$HOME/.cache/current_wallpaper_index"

mkdir -p "$HOME/.cache"

mapfile -t WALLS < <(ls -1 "$WALLPAPERS_DIR")

TOTAL=${#WALLS[@]}

if [ ! -f "$STATE_FILE" ]; then
    INDEX=0
else
    INDEX=$(cat "$STATE_FILE")
fi

if [ "$INDEX" -ge "$TOTAL" ]; then
    INDEX=0
fi

FILE="$WALLPAPERS_DIR/${WALLS[$INDEX]}"

hyprctl hyprpaper unload all
hyprctl hyprpaper preload "$FILE"
hyprctl hyprpaper wallpaper ",$FILE"

NEXT=$(( (INDEX + 1) % TOTAL ))
echo "$NEXT" > "$STATE_FILE"
