#!/bin/bash

### ─────────────────────────────
###  Base menu system – Style Omarchy
### ─────────────────────────────

menu() {
  local prompt="$1"
  local options="$2"

  printf "%b" "$options" \
    | walker --dmenu --width 280 -p "$prompt…" \
    2>/dev/null
}

### ─────────────────────────────
###  Sub-menus
### ─────────────────────────────

show_apps_menu() {
  walker -p "Applications…"
}

show_install_menu() {
  case "$(menu 'Install' \
" Install package
󱣱 Install AUR package
")" in
    *"Install package"*) kitty -e sudo pacman -S ;;
    *"Install AUR"*) kitty -e yay -S ;;
    *) show_main_menu ;;
  esac
}

show_remove_menu() {
  case "$(menu 'Remove' \
" Remove package
")" in
    *"Remove") kitty -e sudo pacman -Rns ;;
    *) show_main_menu ;;
  esac
}

show_update_menu() {
  case "$(menu 'Update' \
" Update system
")" in
    *Update*) kitty -e sudo pacman -Syu ;;
    *) show_main_menu ;;
  esac
}

show_system_menu() {
  case "$(menu 'System' \
"󰜉 Restart
󰐥 Shutdown
󰤄 Suspend
 Lock
")" in
    *Restart*) systemctl reboot ;;
    *Shutdown*) systemctl poweroff ;;
    *Suspend*) systemctl suspend ;;
    *Lock*) hyprlock ;;
    *) show_main_menu ;;
  esac
}

### ─────────────────────────────
### Menu principal
### ─────────────────────────────

show_main_menu() {
  case "$(menu 'Menu' \
"󰀻 Applications
 Install
 Remove
 Update
 System
")" in
    *Applications*) show_apps_menu ;;
    *Install*) show_install_menu ;;
    *Remove*) show_remove_menu ;;
    *Update*) show_update_menu ;;
    *System*) show_system_menu ;;
  esac
}

### ─────────────────────────────
### Lancement
### ─────────────────────────────

show_main_menu
