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
Si yay n’est pas déjà installé, deux options :

1) Avec pacman (si dispo dans vos dépôts/chaur local) :
```zsh
sudo pacman -S yay
```

2) Méthode AUR (classique) :
```zsh
sudo pacman -S --needed base-devel git
cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

### Configuration minimale de yay
- Synchroniser et nettoyer les dépendances orphelines automatiquement :
```zsh
yay --save --sudoloop --combinedupgrade --answerdiff None --answerclean All --removemake --cleanafter
```
- Mise à jour système (paquets + AUR) :
```zsh
yay -Syu
```

## Notes
- Police par défaut : JetBrainsMono Nerd; fallback : DejaVu Sans.
- Waybar peut être rechargée après modification du style :
```zsh
killall waybar && waybar &
```
- Les raccourcis Hyprland sont adaptés pour clavier AZERTY dans `hypr/.config/hypr/hyprland.conf`.
