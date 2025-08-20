# Emplacement et configuration de l'historique
HISTFILE=~/.zsh_history
HISTSIZE=10000       # Nombre de commandes dans l'historique de session
SAVEHIST=10000       # Nombre de commandes sauvegardées dans le fichier

# Options pour l'historique
setopt appendhistory       # Ajoute les commandes à l'historique au lieu d'écraser
setopt incappendhistory    # Écrit chaque commande dans le fichier d'historique immédiatement
setopt sharehistory        # Partage l'historique entre les sessions ouvertes

# SSH agent configuration
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" > /dev/null
    ssh-add ~/.ssh/id_pro 2>/dev/null
    ssh-add ~/.ssh/id_perso 2>/dev/null
fi

#charger starship
eval "$(starship init zsh)"

# Charger zsh-autosuggestions pour des suggestions de commandes
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh