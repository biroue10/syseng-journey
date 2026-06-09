# Nginx — Lecture et analyse des logs

## Objectif

Lire, comprendre et filtrer les logs d'accès Nginx pour diagnostiquer rapidement des erreurs.

## Fichiers de logs

| Fichier | Contenu |
|---|---|
| `/var/log/nginx/access.log` | toutes les requêtes HTTP reçues |
| `/var/log/nginx/error.log` | erreurs serveur (403, 500, config...) |

## Format d'une ligne access.log

```
::1 - - [09/Jun/2026:01:29:28 +0100] "GET /page-inexistante HTTP/1.1" 404 153 "-" "curl/8.12.1" "-"
```

| Champ | Valeur | Signification |
|---|---|---|
| 1 | `::1` | IP du client |
| 2 | `-` | identité remote (vide en pratique) |
| 3 | `-` | utilisateur authentifié (vide = pas d'auth) |
| 4 | `[09/Jun/2026:01:29:28 +0100]` | date et heure |
| 5 | `"GET /page-inexistante HTTP/1.1"` | méthode + URL + protocole |
| 6 | `404` | code HTTP de réponse |
| 7 | `153` | taille de la réponse en octets |
| 8 | `"-"` | Referer (page d'origine) |
| 9 | `"curl/8.12.1"` | User-Agent |
| 10 | `"-"` | IP du proxy |

## Codes HTTP essentiels

| Code | Signification |
|---|---|
| `200` | succès |
| `403` | accès refusé (permissions ou SELinux) |
| `404` | page introuvable |
| `500` | erreur serveur |

## Filtrer les logs en pratique

```bash
# Voir les dernières lignes en temps réel
tail -f /var/log/nginx/access.log

# Filtrer par code HTTP
grep " 404 " /var/log/nginx/access.log
grep " 500 " /var/log/nginx/access.log

# Compter les erreurs
grep -c " 404 " /var/log/nginx/access.log
```

## Ce que j'ai appris

- Les logs d'accès tracent chaque requête avec IP, heure, URL, code et taille
- `grep " 404 "` isole immédiatement les pages introuvables
- En prod, on surveille les 404 (liens cassés) et 500 (bugs applicatifs) en priorité
- Les 403 répétés sont souvent un signe de problème de permissions ou SELinux
