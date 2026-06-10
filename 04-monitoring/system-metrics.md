# Métriques système : RAM, disque, CPU

## Objectif

Lire et interpréter les métriques système essentielles pour diagnostiquer rapidement un problème.

## RAM — free -h

```bash
free -h
```

| Colonne | Signification |
|---|---|
| `total` | RAM physique totale |
| `used` | RAM utilisée par les processus |
| `free` | RAM complètement vide |
| `buff/cache` | RAM utilisée comme cache disque (récupérable) |
| `available` | RAM réellement disponible pour les applications |

**Règle :** regarder `available`, pas `free`. Le cache est récupérable instantanément.
**Swap à 0** = la RAM physique suffit. Du swap actif = signal d'alerte.

## Disque — df -h

```bash
df -h
```

Partitions physiques du serveur :
- `/` (root) : 70G, 5% utilisé
- `/boot` : 960M, 33% utilisé — surveiller, échec des mises à jour kernel au-delà de 80%
- `/home` : 398G, 3% utilisé

**Règle :** alerte à 80%, critique à 90%.

## CPU — top

```bash
top -bn1 | head -20
```

| Métrique | Signification |
|---|---|
| `load average: X, Y, Z` | charge moyenne sur 1min, 5min, 15min |
| `%id` | pourcentage d'inactivité CPU (idle) |
| `%wa` | attente I/O disque — élevé = disque lent |
| `zombie` | processus dont le parent est mort |

**Load average :** comparer au nombre de cœurs (`nproc`). Si load > nproc = serveur sous pression.

## Ce que j'ai appris

- `available` > `free` car Linux utilise la RAM libre comme cache disque
- Un swap à 0 est un bon signe — la RAM physique est suffisante
- `id` dans top = idle (inactivité CPU), pas identifiant
- Le load average sur 15min révèle une tendance, pas un pic ponctuel
- `/boot` plein = mises à jour kernel impossibles
