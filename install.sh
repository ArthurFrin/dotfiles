#!/bin/bash

# --- Paquets ---
PACMAN_PKGS="hyprland waybar kitty alacritty ttf-jetbrains-mono-nerd noto-fonts-emoji base-devel git stow firefox zsh hyprpaper vim fastfetch greetd greetd-tuigreet"
YAY_PKGS="bibata-cursor-theme-bin wofi walker elephant elephant-symbols elephant-desktopapplications elephant-calc elephant-websearch elephant-clipboard elephant-files"

echo "$HOME"

# --- Officiels ---
sudo pacman -Syu --noconfirm $PACMAN_PKGS

# --- yay installation ---
if ! command -v yay &> /dev/null; then
  sudo pacman -S --needed git base-devel
  git clone https://aur.archlinux.org/yay.git
  cd yay && makepkg -si --noconfirm
  cd .. && rm -rf yay
fi

# --- AUR ---
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
        echo "Hidden=true" >> "$DESKTOP_DIR/$f"
        echo "→ Masqué (Hidden=true) : $f"
    fi
done

# --- Supprimer config Hyprland par défaut si présente ---
if [ -f "$HOME/.config/hypr/hyprland.conf" ]; then
    rm -f "$HOME/.config/hypr/hyprland.conf"
fi

cd "$HOME/dotfiles"

# --- Shell par défaut ---
chsh -s /bin/zsh

# --- Starship ---
if ! command -v starship &> /dev/null; then
  curl -sS https://starship.rs/install.sh | sh
fi

# --- zsh-autosuggestions ---
ZSH_CUSTOM="$HOME/.zsh"
mkdir -p "$ZSH_CUSTOM"
if [ ! -d "$ZSH_CUSTOM/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/zsh-autosuggestions"
fi

# --- Stow configs ---
stow --target="$HOME" bin hypr waybar wallpapers fastfetch kitty zsh walker alacritty

# --- Déploiement du CSS greetd via stow ---
sudo stow --target=/ greetd

# --- Détection de l'utilisateur réel ---
CURRENT_USER="$(logname)"

# --- Génération de la config greetd ---
sudo tee /etc/greetd/config.toml >/dev/null <<EOF
[terminal]
vt = 1

[default_session]
command = "/usr/bin/tuigreet \
 --style dark \
 --css /usr/share/greetd/style.css \
 --scaled \
 --remember \
 --time \
 --asterisks \
 --user ${CURRENT_USER} \
 --cmd Hyprland"
user = "greeter"
EOF

# --- Création utilisateur greeter ---
if ! id greeter &>/dev/null; then
    sudo useradd -r -s /usr/bin/nologin greeter
fi

sudo usermod -aG video,input,seat,tty greeter

# --- Activer greetd ---
sudo systemctl enable greetd --now



echo "✅ Installation terminée. Reboot recommandé."
