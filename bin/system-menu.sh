#!/bin/bash

menu() {
  printf "%s\n" \
    "󰀻  Applications" \
    "  Install package" \
    "  Remove package" \
    "  Update system" \
    "󰜉  Reboot" \
    "󰐥  Shutdown" \
  | walker --dmenu -p "Menu…" --width 260
}


case "$choice" in
  *Applications*) walker . ;;
  *Install*) kitty -e sudo pacman -S ;;
  *Remove*) kitty -e sudo pacman -Rns ;;
  *Update*) kitty -e sudo pacman -Syu ;;
  *Reboot*) systemctl reboot ;;
  *Shutdown*) systemctl poweroff ;;
esac

