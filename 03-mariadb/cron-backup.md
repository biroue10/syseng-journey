# Automatisation avec cron

## Objectif

Planifier l'exécution automatique du script de backup chaque nuit via cron.

## Commandes

```bash
# Éditer le crontab de l'utilisateur courant
crontab -e

# Lister les tâches cron actives
crontab -l
```

## Entrée cron ajoutée

```
0 2 * * * ~/backup_db.sh
```

## Format cron

```
minute  heure  jour_mois  mois  jour_semaine  commande
  0       2       *         *        *         ~/backup_db.sh
  │       │       │         │        └── jour de la semaine (0=dimanche)
  │       │       │         └────────── mois (1-12)
  │       │       └──────────────────── jour du mois (1-31)
  │       └──────────────────────────── heure (0-23)
  └──────────────────────────────────── minute (0-59)
```

## Erreurs courantes

| Entrée | Problème |
|---|---|
| `* 2 * * *` | tourne 60 fois entre 2h00 et 2h59 |
| `0 2 * * *` | tourne une seule fois à 2h00 ✓ |

## Ce que j'ai appris

- `crontab -e` édite les tâches planifiées de l'utilisateur courant
- Le premier champ est les minutes — `*` signifie "chaque minute", pas "à cette heure"
- Cron s'exécute sans terminal — les chemins doivent être absolus ou utiliser `~/`
- En production, les sorties cron sont redirigées vers un log pour pouvoir les auditer
