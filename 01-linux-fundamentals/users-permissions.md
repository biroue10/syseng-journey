# Utilisateurs et permissions

## Objectif

Créer un utilisateur système, un groupe, et sécuriser un dossier avec les bonnes permissions — base de toute gestion de serveur.

## Commandes utilisées

```bash
# Créer un utilisateur
sudo useradd webuser

# Vérifier qu'il existe
grep webuser /etc/passwd

# Créer un groupe
sudo groupadd webteam

# Ajouter l'utilisateur au groupe (-a = append, -G = group secondaire)
sudo usermod -aG webteam webuser

# Vérifier l'appartenance aux groupes
id webuser

# Créer un dossier
sudo mkdir -p /var/www/monsite

# Assigner propriétaire et groupe
sudo chown webuser:webteam /var/www/monsite

# Appliquer les permissions 750 (rwxr-x---)
sudo chmod 750 /var/www/monsite

# Vérifier le résultat
ls -la /var/www/
```

## Explication des permissions 750

```
7   5   0
rwx r-x ---
│   │   └── autres : aucun accès
│   └────── groupe (webteam) : lecture + traversée
└────────── propriétaire (webuser) : accès complet
```

## Ce que j'ai appris

- `useradd` crée un utilisateur système avec son répertoire home
- `usermod -aG` ajoute à un groupe sans retirer les groupes existants — le `-a` est critique
- `chown user:group` assigne propriétaire et groupe en une seule commande
- `chmod 750` : le service a les droits, le groupe peut lire, le reste du monde n'entre pas
- `sudo` est requis pour toute modification de ressources système hors de son home
