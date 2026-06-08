# Nginx — Lecture et compréhension de la configuration

## Objectif

Lire et comprendre la configuration principale de Nginx avant toute modification.

## Fichier analysé

`/etc/nginx/nginx.conf`

## Points clés

### Utilisateur système
```
user nginx;
```
Nginx tourne sous l'utilisateur `nginx`, pas root. Principe de moindre privilège.

### Port d'écoute
```
listen 80;
listen [::]:80;
```
Seul le port 80 (HTTP) est actif. Le bloc port 443 (HTTPS) est commenté — il faudra un certificat SSL pour l'activer.

### Les 4 directives `include`

| Directive | Rôle |
|---|---|
| `/usr/share/nginx/modules/*.conf` | charge les modules dynamiques |
| `/etc/nginx/mime.types` | associe extensions de fichiers et types MIME |
| `/etc/nginx/conf.d/*.conf` | charge les configs des virtual hosts |
| `/etc/nginx/default.d/*.conf` | charge les configs du server block par défaut |

### MIME types
Indiquent au navigateur quel type de contenu il reçoit (`text/html`, `image/jpeg`, `application/pdf`...).
Sans eux, le navigateur ne saurait pas comment afficher les fichiers.

### Logs
```
error_log  /var/log/nginx/error.log notice;
access_log /var/log/nginx/access.log main;
```
Deux fichiers de log : erreurs et accès. Premiers endroits à consulter lors d'un incident.

## Ce que j'ai appris

- Les lignes commençant par `#` sont des commentaires — ignorées par Nginx
- Nginx tourne sous un utilisateur dédié (`nginx`), jamais root
- `conf.d/*.conf` est l'endroit standard pour créer de nouveaux virtual hosts
- Les MIME types permettent au navigateur d'interpréter correctement les fichiers reçus
