#!/bin/bash

# Dossier contenant tes wallpapers
WALLPAPERS_DIR="$HOME/wallpapers"

# Symlink vers le wallpaper actuel
CURRENT_LINK="$WALLPAPERS_DIR/current"

# Charger tous les fichiers images (jpg/png/webp)
mapfile -d '' -t WALLS < <(
  find -L "$WALLPAPERS_DIR" \
    -maxdepth 1 -type f \
    -iregex ".*\.\(jpg\|jpeg\|png\|webp\)" \
    -print0 | sort -z
)

TOTAL=${#WALLS[@]}

if [[ $TOTAL -eq 0 ]]; then
    notify-send "Aucun wallpaper trouvé" -t 2000
    pkill -x swaybg
    setsid uwsm-app -- swaybg --color '#000000' >/dev/null 2>&1 &
    exit
fi

# Récupérer l'actuel via le symlink
if [[ -L "$CURRENT_LINK" ]]; then
    CURRENT_BG=$(readlink "$CURRENT_LINK")
else
    CURRENT_BG=""
fi

# Trouver index actuel
INDEX=-1
for i in "${!WALLS[@]}"; do
    if [[ "${WALLS[$i]}" == "$CURRENT_BG" ]]; then
        INDEX=$i
        break
    fi
done

# Déterminer le suivant
if [[ $INDEX -eq -1 ]]; then
    NEW_BG="${WALLS[0]}"
else
    NEXT=$(((INDEX + 1) % TOTAL))
    NEW_BG="${WALLS[$NEXT]}"
fi

# Mettre à jour le symlink
ln -nsf "$NEW_BG" "$CURRENT_LINK"

# Relancer swaybg
pkill -x swaybg
setsid uwsm-app -- swaybg -i "$CURRENT_LINK" -m fill >/dev/null 2>&1 &
