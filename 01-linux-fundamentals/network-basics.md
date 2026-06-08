# Réseau de base et firewall

## Objectif

Diagnostiquer rapidement l'état réseau d'un serveur : interfaces, routage, ports ouverts, règles firewall.

## Commandes utilisées

```bash
# Afficher les interfaces et leurs IPs
ip a

# Afficher la table de routage
ip route

# Lister les ports en écoute (t=tcp, l=listen, n=numérique, p=process)
ss -tlnp

# Afficher les règles firewall complètes
sudo firewall-cmd --list-all

# Supprimer un service du firewall (permanent = survit au reboot)
sudo firewall-cmd --remove-service=cockpit --permanent

# Appliquer les changements sans redémarrer
sudo firewall-cmd --reload
```

## Ce que j'ai trouvé sur ce serveur

**Interfaces réseau :**
| Interface | IP | Rôle |
|---|---|---|
| `lo` | 127.0.0.1 | loopback (interne) |
| `enp1s0` | 192.168.11.104 | réseau local (DHCP) |
| `tailscale0` | 100.65.144.6 | VPN Tailscale |

**Route par défaut :** `192.168.11.1` (passerelle du réseau local)

**Ports ouverts :** SSH (22) sur toutes les interfaces + ports internes Tailscale

## Hardening appliqué

Cockpit était autorisé dans le firewall mais le service était inactif.
Règle supprimée : `firewall-cmd --remove-service=cockpit --permanent`

**Règle de sécurité :** un port ouvert dans le firewall pour un service qui ne tourne pas
est une surface d'attaque inutile. Tout port autorisé doit correspondre à un service actif.

## Ce que j'ai appris

- `ip a` : voir les interfaces et IPs
- `ip route` : comprendre par où part le trafic (`default via` = passerelle)
- `ss -tlnp` : lister ce qui écoute sur le réseau (équivalent moderne de `netstat`)
- `firewall-cmd` : gérer le firewall RHEL/Fedora (firewalld)
- `--permanent` + `--reload` : toujours les utiliser ensemble pour que les changements persistent
- SSH sur `0.0.0.0` = accessible depuis toutes les interfaces (à restreindre en prod)
