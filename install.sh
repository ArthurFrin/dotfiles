#!/bin/bash

# --- Variables ---
SDDM_THEME="chili-sddm-theme"     # ou "sddm-astronaut-theme"
SDDM_THEME_NAME="chili"           # ou "astronaut"

# --- Paquets ---
PACMAN_PKGS="hyprland waybar kitty ttf-dejavu nerd-fonts base-devel git stow firefox zsh sddm hyprpaper"
YAY_PKGS="zen-browser-bin $SDDM_THEME bibata-cursor-theme-bin bauh wofi"

echo "$HOME"

# --- Officiels ---
sudo pacman -Syu --noconfirm $PACMAN_PKGS

# --- yay ---
if ! command -v yay &> /dev/null; then
  sudo pacman -S --needed git base-devel
  git clone https://aur.archlinux.org/yay.git
  cd yay && makepkg -si --noconfirm
  cd .. && rm -rf yay
fi

# --- AUR (Discord, Zen, Thème SDDM) ---
yay -S --noconfirm $YAY_PKGS

# Supprimer config Hyprland par défaut si présente
if [ -f "$HOME/.config/hypr/hyprland.conf" ]; then
    rm -f "$HOME/.config/hypr/hyprland.conf"
fi

cd "$HOME/dotfiles"

# --- Stow configs ---
stow --target="$HOME" bin hypr waybar wallpapers fastfetch kitty zsh wofi
sudo stow --target=/ sddm

# --- Activer SDDM ---
sudo systemctl enable sddm

# --- Zsh par défaut ---
chsh -s /bin/zsh

# --- Starship ---
if ! command -v starship &> /dev/null; then
  curl -sS https://starship.rs/install.sh | sh
fi

# --- zsh-autosuggestions ---
ZSH_CUSTOM="$HOME/.zsh"
if [ ! -d "$ZSH_CUSTOM" ]; then
  mkdir -p "$ZSH_CUSTOM"
fi
if [ ! -d "$ZSH_CUSTOM/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/zsh-autosuggestions"
fi


echo "✅ Installation terminée. Reboot recommandé."
