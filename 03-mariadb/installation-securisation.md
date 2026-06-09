# MariaDB — Installation, sécurisation et gestion des utilisateurs

## Objectif

Installer MariaDB, appliquer le hardening de base, créer une base de données et un utilisateur applicatif avec des droits limités.

## Installation et démarrage

```bash
sudo dnf install mariadb-server -y
systemctl enable --now mariadb
```

## Sécurisation initiale

```bash
sudo mysql_secure_installation
```

Réponses recommandées :
| Question | Réponse | Raison |
|---|---|---|
| Switch to unix_socket authentication | Y | accès root uniquement via sudo |
| Change the root password | n | socket auth suffit |
| Remove anonymous users | Y | personne ne doit se connecter sans compte |
| Disallow root login remotely | Y | root ne doit jamais être accessible réseau |
| Remove test database | Y | base inutile accessible à tous |
| Reload privilege tables | Y | applique les changements |

## Connexion en root

```bash
sudo mariadb
```

## Créer une base de données et un utilisateur applicatif

```sql
-- Créer la base
CREATE DATABASE monsite_db;

-- Créer l'utilisateur (toujours avec 'user'@'host')
CREATE USER 'monsite_user'@'localhost' IDENTIFIED BY 'Str0ngPass!';

-- Donner les droits uniquement sur sa base (.* = toutes les tables)
GRANT ALL PRIVILEGES ON monsite_db.* TO 'monsite_user'@'localhost';

-- Appliquer les changements
FLUSH PRIVILEGES;

-- Vérifier
SELECT User, Host FROM mysql.user;
SHOW GRANTS FOR 'monsite_user'@'localhost';
```

## Tester la connexion applicative

```bash
mariadb -u monsite_user -p
```

```sql
SHOW DATABASES;
-- Résultat attendu : uniquement information_schema et monsite_db
```

## Ce que j'ai appris

- Ne jamais donner les credentials root à une application — toujours créer un utilisateur dédié
- Un utilisateur MariaDB = `'nom'@'hôte'` — l'hôte restreint d'où il peut se connecter
- `GRANT ALL PRIVILEGES ON monsite_db.*` — les droits sont limités à une seule base
- `FLUSH PRIVILEGES` applique les changements de droits immédiatement
- Sur RHEL, MariaDB root utilise l'authentification par socket Unix (`sudo mariadb`)
- Les mots de passe sont stockés hashés, jamais en clair
