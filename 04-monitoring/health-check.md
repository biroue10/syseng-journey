# Health Check Script

## Objectif

Détecter automatiquement si un service est tombé et retourner un code de sortie exploitable.

## Script : health_check.sh

```bash
#!/bin/bash
SERVICE="mariadb"
SERVICE2="nginx"
EXIT_CODE=0

if systemctl is-active --quiet "$SERVICE"; then
    echo "✅ Le service $SERVICE est EN COURS D'EXÉCUTION"
else
    echo "❌ Le service $SERVICE EST ARRÊTÉ"
    EXIT_CODE=1
fi

if systemctl is-active --quiet "$SERVICE2"; then
    echo "✅ Le service $SERVICE2 est EN COURS D'EXÉCUTION"
else
    echo "❌ Le service $SERVICE2 EST ARRÊTÉ"
    EXIT_CODE=1
fi

exit $EXIT_CODE
```

## Concepts clés

| Élément | Rôle |
|---|---|
| `systemctl is-active --quiet` | vérifie si le service tourne sans afficher de texte |
| `EXIT_CODE=0` | variable qui mémorise l'état global |
| `exit $EXIT_CODE` | retourne 1 si au moins un service a échoué |
| `$?` | capture le code de retour de la dernière commande |

## Erreurs à éviter

- Ne jamais mettre `exit` dans les blocs `if/else` — le script s'arrête et les services suivants ne sont jamais vérifiés
- `exit EXIT_CODE` (sans `$`) retourne littéralement la chaîne, pas la valeur de la variable

## Ce que j'ai appris

- `systemctl is-active --quiet` est la bonne commande pour les scripts — pas de sortie parasite
- Le code de retour `$?` permet à cron ou à un autre script de détecter l'échec
- Une variable `FAILED` ou `EXIT_CODE` permet de vérifier tous les services avant de sortir
