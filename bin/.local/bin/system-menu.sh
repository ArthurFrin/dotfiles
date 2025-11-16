#!/bin/bash

menu() {
  local prompt="$1"
  local options="$2"

  printf "%b" "$options" \
    | walker --dmenu --width 280 -p "$prompt…" 2>/dev/null
}

### ─────────────────────────────
###  Sous-menus
### ─────────────────────────────

show_apps_menu() {
  walker -p "Applications…" .
}

show_install_menu() {
  case "$(menu 'Install' \
" Install package
󱣱 Install AUR package
")" in
    *"Install package"*) walker -p "Install…" "! install " ;;
    *"Install AUR"*)     walker -p "Install AUR…" "!! install " ;;
    *) show_main_menu ;;
  esac
}

show_remove_menu() {
  walker -p "Remove…" "! remove "
}

show_update_menu() {
  walker -p "System Update…" "! update"
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
###  Menu principal
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
    *Install*)      show_install_menu ;;
    *Remove*)       show_remove_menu ;;
    *Update*)       show_update_menu ;;
    *System*)       show_system_menu ;;
  esac
}

show_main_menu
