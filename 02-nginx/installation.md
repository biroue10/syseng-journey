# Nginx — Installation et configuration de base

## Objectif

Installer Nginx, le rendre opérationnel au boot, ouvrir le firewall, et servir une page HTML personnalisée.

## Commandes utilisées

```bash
# Installer Nginx
sudo dnf install nginx

# Démarrer et activer au boot en une commande
systemctl enable --now nginx

# Vérifier que le service tourne
systemctl status nginx

# Ouvrir le port HTTP dans le firewall
sudo firewall-cmd --add-port=80/tcp --permanent
sudo firewall-cmd --reload

# Tester la réponse du serveur
curl http://localhost

# Trouver le dossier racine par défaut
grep -n "root" /etc/nginx/nginx.conf
```

## Fichiers clés

| Fichier / Dossier | Rôle |
|---|---|
| `/etc/nginx/nginx.conf` | configuration principale |
| `/usr/share/nginx/html/` | dossier racine par défaut (webroot) |
| `/usr/share/nginx/html/index.html` | page servie par défaut |

## Ce que j'ai appris

- `systemctl enable --now` démarre le service ET l'active au boot en une seule commande
- `--permanent` + `--reload` sont toujours nécessaires ensemble pour que les règles firewall persistent
- `curl http://localhost` permet de tester un serveur web sans navigateur
- La directive `root` dans nginx.conf définit où Nginx cherche les fichiers à servir
- `<head>` contient les métadonnées (`<title>`, `<meta>`), `<body>` contient le contenu visible
