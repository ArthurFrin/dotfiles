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
