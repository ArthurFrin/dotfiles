#!/bin/bash

# --- Variables ---
SDDM_THEME="chili-sddm-theme"     # ou "sddm-astronaut-theme"
SDDM_THEME_NAME="chili"           # ou "astronaut"

# --- Paquets ---
PACMAN_PKGS="hyprland waybar kitty alacritty cantarell-fonts ttf-jetbrains-mono-nerd nerd-fonts noto-fonts-emoji noto-color-emoji-fontconfig base-devel git stow firefox zsh sddm hyprpaper vim fastfetch"
YAY_PKGS="zen-browser-bin $SDDM_THEME bibata-cursor-theme-bin bauh wofi walker elephant elephant-symbols elephant-desktopapplications elephant-calc elephant-websearch elephant-clipboard elephant-files"

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

# --- Masquage d'applications inutiles ---
DESKTOP_DIR="$HOME/.local/share/applications"
mkdir -p "$DESKTOP_DIR"

DESKTOP_HIDE=(
  "xgps.desktop"
  "xgpsspeed.desktop"
  "qv4l2.desktop"
  "v4l2ucp.desktop"
  "avahi-discover.desktop"
  "avahi-ssh.desktop"
  "avahi-vnc.desktop"
  "avahi-zeroconf-browser.desktop"
)

for f in "${DESKTOP_HIDE[@]}"; do
    if [ -f "/usr/share/applications/$f" ]; then
        cp "/usr/share/applications/$f" "$DESKTOP_DIR/$f"
        echo "NoDisplay=true" >> "$DESKTOP_DIR/$f"
        echo "→ Masqué : $f"
    fi
done

# Supprimer config Hyprland par défaut si présente
if [ -f "$HOME/.config/hypr/hyprland.conf" ]; then
    rm -f "$HOME/.config/hypr/hyprland.conf"
fi

cd "$HOME/dotfiles"

# --- Stow configs ---
stow --target="$HOME" bin hypr waybar wallpapers fastfetch kitty zsh walker alacritty
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
