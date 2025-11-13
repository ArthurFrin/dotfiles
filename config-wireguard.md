# README — Intégration WireGuard (afrin) + Waybar (toggle)

Ce guide explique comment installer WireGuard, utiliser un fichier de configuration existant (`afrin.conf`), désactiver le DNS si nécessaire, ajouter un bouton de toggle dans Waybar, et permettre l’exécution sans mot de passe `sudo`.

---

## 1. Installation des outils nécessaires

WireGuard nécessite uniquement le paquet suivant :

```bash
sudo pacman -S wireguard-tools
```

---

## 2. Placer la configuration WireGuard

Déplacez votre fichier téléchargé (`afrin.conf`) dans `/etc/wireguard` :

```bash
sudo mkdir -p /etc/wireguard
sudo mv afrin.conf /etc/wireguard/
sudo chmod 600 /etc/wireguard/afrin.conf
```

---

## 3. Désactiver la modification DNS (optionnel)

Si vous ne souhaitez pas que WireGuard modifie `/etc/resolv.conf`, commentez la ligne suivante dans `afrin.conf` :

```
# DNS = ...
```

---

## 4. Tester le VPN

Activation :

```bash
sudo wg-quick up afrin
```

Désactivation :

```bash
sudo wg-quick down afrin
```

Statut :

```bash
sudo wg show
```

---

## 5. Script de toggle WireGuard

Créer le script de bascule :

```bash
sudo nano /usr/local/bin/wg-toggle-afrin
```

Contenu :

```bash
#!/bin/bash
IF="afrin"

if ip link show "$IF" &>/dev/null; then
    sudo wg-quick down "$IF"
    notify-send "WireGuard" "VPN $IF désactivé"
else
    sudo wg-quick up "$IF"
    notify-send "WireGuard" "VPN $IF activé"
fi
```

Rendre le script exécutable :

```bash
sudo chmod +x /usr/local/bin/wg-toggle-afrin
```

---

## 6. Ajouter le module dans Waybar

Dans le fichier `~/.config/waybar/config.jsonc`, ajoutez dans la liste `modules-right`, juste après `"bluetooth"` :

```jsonc
"modules-right": [
    "mpris",
    "group/tray-expander",
    "bluetooth",
    "custom/wg",
    "network",
    "pulseaudio",
    "cpu",
    "battery"
],
```

Puis ajoutez le module Waybar :

```jsonc
"custom/wg": {
  "exec": "bash -c 'ip link show afrin &>/dev/null && echo \"\" || echo \"\"'",
  "interval": 3,
  "tooltip-format": "WireGuard VPN (afrin)",
  "on-click": "/usr/local/bin/wg-toggle-afrin"
},
```

Recharge Waybar :

```bash
pkill -SIGUSR2 waybar
```

---

## 7. Exécution sans mot de passe sudo

Pour permettre à Waybar d’activer ou désactiver WireGuard sans demande de mot de passe :

```bash
sudo EDITOR=nano visudo
```

Ajoutez cette ligne à la fin (remplacez `arcoss` par votre nom d’utilisateur) :

```
arcoss ALL=(ALL) NOPASSWD: /usr/bin/wg-quick up afrin, /usr/bin/wg-quick down afrin
```

Testez ensuite :

```bash
sudo wg-quick down afrin
sudo wg-quick up afrin
```

Aucune demande de mot de passe ne doit apparaître.

---

## 8. Résultat

* Une icône apparaît entre Bluetooth et Network dans Waybar.
* Icône verrou : VPN actif.
* Icône ouvert : VPN désactivé.
* Un clic bascule instantanément l’état du VPN.
* Fonctionne sans mot de passe si configuré dans `sudoers`.

---
