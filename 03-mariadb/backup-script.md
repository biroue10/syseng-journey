# MariaDB — Script de backup automatisé

## Objectif

Écrire un script Bash qui sauvegarde automatiquement une base de données avec horodatage.

## Script : backup_db.sh

```bash
#!/bin/bash
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
mysqldump --databases monsite_db -u monsite_user -pStr0ngPass! > /var/backups/monsite_db_${DATE}.sql
if [ $? -eq 0 ]; then
    echo "Backup successful!"
    echo "Date: $DATE"
else
    echo "Backup failed!"
    echo "Date: $DATE"
fi
```

## Mise en place

```bash
# Rendre le script exécutable
chmod 755 backup_db.sh

# Donner accès au dossier de backup
sudo chown biroue:biroue /var/backups/

# Tester
./backup_db.sh
```

## Ce que j'ai appris

- `#!/bin/bash` — shebang, indique l'interpréteur à utiliser
- `DATE=$(date +"%Y-%m-%d_%H-%M-%S")` — capture la date dans une variable
- `$?` — code de retour de la dernière commande (0 = succès, autre = erreur)
- `-pMotDePasse` — mot de passe collé sans espace pour éviter l'interactivité
- `chmod 755` — script exécutable par le propriétaire, lisible par les autres (pas 777)
- Le mot de passe en clair dans un script est une mauvaise pratique — en production on utilise `~/.my.cnf`
