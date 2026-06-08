# Lecture des logs système avec journalctl

## Objectif

Savoir lire, filtrer et prioriser les logs système — compétence critique lors d'un incident.

## Commandes utilisées

```bash
# 20 dernières lignes du journal
journalctl -n 20

# Erreurs depuis le dernier boot
journalctl -b -p err --no-pager

# Logs en temps réel
journalctl -f

# Logs d'un service spécifique
journalctl -u sshd -n 10
```

## Options clés

| Option | Signification |
|---|---|
| `-n 20` | affiche les N dernières lignes |
| `-b` | filtre sur le boot actuel |
| `-p err` | filtre par priorité (err, warning, info...) |
| `-f` | mode temps réel (follow) |
| `-u sshd` | filtre sur un service spécifique |

## Prioriser les erreurs

Toutes les erreurs ne sont pas égales :

| Type | Exemple | Priorité |
|---|---|---|
| Erreurs kernel/ACPI au boot | `ACPI BIOS Error` | Faible — souvent du bruit firmware |
| Erreurs de services | `firewalld: Failed to load policy` | Haute — des règles ne sont pas appliquées |
| Échecs d'authentification | `pam_unix: auth could not identify password` | Haute — événement de sécurité à surveiller |

## Ce que j'ai appris

- `journalctl` est l'outil central pour lire tous les logs systemd
- Les erreurs kernel au boot sont souvent des bugs firmware non critiques
- Les erreurs de services (firewalld, nginx...) sont actionables et prioritaires
- Les échecs d'auth sudo/ssh sont des signaux de sécurité à surveiller en prod
- En production, on monitore `-p err` en continu pour détecter les incidents
