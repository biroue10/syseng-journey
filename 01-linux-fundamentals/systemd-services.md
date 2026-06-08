# Gestion des services avec systemd

## Objectif

Inspecter, démarrer, arrêter et diagnostiquer des services Linux avec systemctl et journalctl.

## Commandes utilisées

```bash
# Voir le statut complet d'un service
systemctl status sshd

# Voir les derniers logs d'un service
journalctl -u sshd -n 10

# Vérifier si un service démarre au boot
systemctl is-enabled sshd

# Arrêter un service
sudo systemctl stop crond

# Démarrer un service
sudo systemctl start crond

# Redémarrer (stop + start)
sudo systemctl restart crond

# Recharger la config sans couper les connexions
sudo systemctl reload nginx
```

## Différence restart vs reload

| Commande | Effet | Quand l'utiliser |
|---|---|---|
| `restart` | coupe et redémarre le processus | après un changement majeur |
| `reload` | relit la config sans interruption | en prod pour éviter les coupures |

## Ce que journalctl m'apprend

Dans les logs de sshd, on peut lire :
```
Accepted publickey for biroue from 192.168.11.101 port 53630 ssh2: ED25519
```
Cela indique : qui s'est connecté, depuis quelle IP, via quelle méthode (clé publique ED25519).

## Ce que j'ai appris

- `systemctl status` donne en un coup d'oeil : actif/inactif, uptime, PID, derniers logs
- `enabled` = démarre au boot, `disabled` = ne démarre pas au boot
- `journalctl -u <service>` lit les logs d'un service spécifique
- Ne jamais stopper `sshd` sur un serveur distant — on perd la connexion
- `reload` est préféré à `restart` en production pour éviter les interruptions de service
