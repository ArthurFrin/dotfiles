#!/bin/bash
set -e

# --- Variables ---
SDDM_THEME="sddm-theme-chili"     # ou "sddm-astronaut-theme"
SDDM_THEME_NAME="chili"           # ou "astronaut"

# --- Paquets ---
PACMAN_PKGS="hyprland waybar kitty ttf-jetbrains-mono-nerd ttf-dejavu base-devel git stow walker firefox zsh sddm"
YAY_PKGS="discord zen-browser-bin $SDDM_THEME"

# --- Officiels ---
sudo pacman -Syu --noconfirm $PACMAN_PKGS

# --- Oh My Zsh ---
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# --- yay ---
if ! command -v yay &> /dev/null; then
  sudo pacman -S --needed git base-devel
  git clone https://aur.archlinux.org/yay.git
  cd yay && makepkg -si --noconfirm
  cd .. && rm -rf yay
fi

# --- AUR (Discord, Zen, Thème SDDM) ---
yay -S --noconfirm $YAY_PKGS

# --- Dotfiles ---
if [ ! -d "$HOME/dotfiles" ]; then
  git clone https://github.com/<TON_USER>/<TON_REPO>.git "$HOME/dotfiles"
fi
cd "$HOME/dotfiles"
stow --target="$HOME" hyp

# --- Activer SDDM ---
sudo systemctl enable sddm

# --- Zsh par défaut ---
chsh -s /bin/zsh

echo "✅ Installation terminée. Reboot recommandé."
