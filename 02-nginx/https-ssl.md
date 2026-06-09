# Nginx — HTTPS avec certificat auto-signé

## Objectif

Configurer HTTPS sur un virtual host Nginx avec un certificat auto-signé.

## Générer le certificat

```bash
sudo mkdir /etc/nginx/ssl
sudo openssl req -x509 -newkey rsa:2048 \
  -keyout /etc/nginx/ssl/monsite.key \
  -out /etc/nginx/ssl/monsite.crt \
  -days 365 -nodes
```

| Option | Signification |
|---|---|
| `-x509` | certificat auto-signé (pas signé par une CA) |
| `-newkey rsa:2048` | génère une nouvelle clé RSA 2048 bits |
| `-days 365` | valide 1 an |
| `-nodes` | clé privée non chiffrée (Nginx ne demande pas de mot de passe) |

## Permissions des fichiers SSL

```
-rw-r--r-- monsite.crt   (644) → certificat public, lisible par tous
-rw------- monsite.key   (600) → clé privée, root uniquement
```

## Configuration du virtual host

`/etc/nginx/conf.d/monsite.conf` :

```nginx
server {
    listen       80;
    listen       [::]:80;
    server_name  monsite.local;
    root         /var/www/monsite;
}

server {
    listen       443 ssl;
    listen       [::]:443 ssl;
    http2        on;
    server_name  monsite.local;
    root         /var/www/monsite;

    ssl_certificate     "/etc/nginx/ssl/monsite.crt";
    ssl_certificate_key "/etc/nginx/ssl/monsite.key";
}
```

## Ouvrir le port 443

```bash
sudo firewall-cmd --add-port=443/tcp --permanent
sudo firewall-cmd --reload
```

## Tester

```bash
# -k ignore la vérification du certificat auto-signé
curl -k https://localhost -H "Host: monsite.local"
```

## Ce que j'ai appris

- Un certificat auto-signé chiffre le trafic mais n'est pas vérifié par une CA — utilisé en interne
- La clé privée ne doit jamais être lisible par d'autres utilisateurs (600)
- `nginx -t` vérifie toujours la syntaxe avant de recharger
- En production on utilise Let's Encrypt pour des certificats gratuits et reconnus par les navigateurs
