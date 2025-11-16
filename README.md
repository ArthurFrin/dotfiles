# Dotfiles – Installation rapide (Arch/Arch-like)

## À installer (paquets)
- hyprland
- waybar
- kitty
- ttf-jetbrains-mono-nerd
- ttf-dejavu
- yay (AUR helper)

## Installation avec pacman
Ces paquets se trouvent dans les dépôts officiels (sauf yay) :

```zsh
sudo pacman -S hyprland waybar kitty ttf-jetbrains-mono-nerd ttf-dejavu
```

## Installer yay (depuis l’AUR)
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

## Notes
- Police par défaut : JetBrainsMono Nerd; fallback : DejaVu Sans.
- Waybar peut être rechargée après modification du style :
```zsh
killall waybar && waybar &
```
- Les raccourcis Hyprland sont adaptés pour clavier AZERTY dans `hypr/.config/hypr/hyprland.conf`.

zen: enlever la zone de fermeteur au hover:
dans about:config -> zen.view.experimental-no-window-controls = false




### Forcer XCursor par défaut (pour Electron/XWayland)
```sh
mkdir -p ~/.icons/default
cat > ~/.icons/default/index.theme <<'EOF'
[Icon Theme]
Inherits=Bibata-Modern-Ice
EOF
```

### doc walker
`https://walkerlauncher.com/docs/theming`