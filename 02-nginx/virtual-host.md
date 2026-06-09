# Nginx — Virtual Host et débogage SELinux

## Objectif

Créer un virtual host Nginx pour `monsite.local` et diagnostiquer une erreur 403 causée par SELinux.

## Fichier de configuration

`/etc/nginx/conf.d/monsite.conf` :

```nginx
server {
    listen       80;
    listen       [::]:80;
    server_name  monsite.local;
    root         /var/www/monsite;
}
```

## Tester un virtual host sans DNS

```bash
curl -H "Host: monsite.local" http://localhost
```

Le header `Host` simule ce qu'un navigateur envoie — Nginx l'utilise pour choisir quel virtual host servir.

## Débogage de l'erreur 403

### Étape 1 — Lire les logs d'erreur
```bash
tail -20 /var/log/nginx/error.log
# → Permission denied (13) sur index.html
```

### Étape 2 — Vérifier SELinux
```bash
getenforce
# → Enforcing

ls -Z /var/www/monsite/
# → unconfined_u:object_r:var_t:s0  (mauvais contexte)
```

### Étape 3 — Corriger le contexte SELinux
```bash
sudo restorecon -Rv /var/www/monsite/
# → restaure le contexte httpd_sys_content_t
```

## Ce que j'ai appris

- Un fichier `conf.d/` ne contient qu'un bloc `server {}` — pas de `user`, `events`, ni `http`
- `server_name` doit être unique par virtual host — `_` est le catch-all par défaut
- Sur RHEL, SELinux est une couche de sécurité au-dessus des permissions Unix
- Les fichiers servis par Nginx doivent avoir le contexte `httpd_sys_content_t`
- `restorecon` recalcule le bon contexte selon l'emplacement du fichier
- Toujours lire `/var/log/nginx/error.log` en premier lors d'un 403
