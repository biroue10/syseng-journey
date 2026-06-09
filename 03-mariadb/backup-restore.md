# MariaDB — Sauvegarde et restauration

## Objectif

Sauvegarder une base de données, simuler une perte de données, et restaurer depuis le dump.

## Sauvegarde avec mysqldump

```bash
# Dump vers le home (pas de problème de permissions)
mysqldump --databases monsite_db -u monsite_user -p > ~/monsite_db.sql

# Déplacer vers le dossier de backup
sudo mv ~/monsite_db.sql /var/backups/monsite_db.sql

# Vérifier que le fichier est présent et non vide
ls -lh /var/backups/monsite_db.sql
```

## Restauration

```bash
# Injecter le fichier SQL dans MariaDB avec <
mariadb -u monsite_user -pMotDePasse < /var/backups/monsite_db.sql
```

## Vérification après restauration

```sql
USE monsite_db;
SHOW TABLES;
SELECT * FROM utilisateurs;
```

## Points importants

- Le mot de passe se colle directement après `-p` sans espace : `-pMotDePasse`
- La redirection `<` envoie le fichier en entrée à mariadb — pas de pipe, pas de tee
- Toujours vérifier que le dump n'est pas vide avant de compter dessus
- Tester la restauration régulièrement — un backup non testé n'est pas un backup fiable

## Ce que j'ai appris

- `mysqldump` génère un fichier SQL rejouable contenant la structure et les données
- La restauration avec `<` est la méthode standard et la plus simple
- En production, les backups se font automatiquement via cron (prochaine étape)
- Un ingénieur teste toujours la restauration — sauvegarder sans vérifier ne sert à rien
