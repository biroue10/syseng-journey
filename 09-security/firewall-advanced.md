# Firewall avancé — Rich Rules

## Objectif

Aller au-delà des règles basiques `--add-service` / `--add-port` pour contrôler précisément qui peut accéder à quoi, depuis quelle IP, et logger les tentatives.

---

## Règles basiques vs Rich Rules

```bash
# Basique — tout le monde peut accéder
firewall-cmd --add-port=9090/tcp

# Rich rule — seulement le subnet 192.168.11.0/24
firewall-cmd --add-rich-rule='rule family="ipv4" source address="192.168.11.0/24" port port="9090" protocol="tcp" accept'
```

---

## --permanent vs sans --permanent

| Sans `--permanent` | Avec `--permanent` |
|-------------------|-------------------|
| Active immédiatement | Sauvegardé sur disque |
| Disparaît au reload/reboot | Survit au reload et reboot |
| Utile pour tester | Obligatoire en production |

**Toujours tester sans `--permanent` d'abord, puis ajouter `--permanent` si ça marche.**

---

## Rich rules appliquées

### 1. Logger les tentatives SSH

```bash
sudo firewall-cmd --add-rich-rule='rule service name="ssh" log prefix="SSH_ATTEMPT " level="warning" limit value="3/m"' --permanent
```

| Partie | Signification |
|--------|--------------|
| `service name="ssh"` | Applique au trafic SSH |
| `log prefix="SSH_ATTEMPT "` | Préfixe dans le journal — facilite le grep |
| `level="warning"` | Niveau de log |
| `limit value="3/m"` | Max 3 entrées de log par minute |

### 2. Restreindre Prometheus et Grafana au réseau local

```bash
# Supprimer les ports ouverts à tout le monde
sudo firewall-cmd --remove-port=9090/tcp --permanent
sudo firewall-cmd --remove-port=3000/tcp --permanent

# Autoriser uniquement le subnet local
sudo firewall-cmd --add-rich-rule='rule family="ipv4" source address="192.168.11.0/24" port port="9090" protocol="tcp" accept' --permanent
sudo firewall-cmd --add-rich-rule='rule family="ipv4" source address="192.168.11.0/24" port port="3000" protocol="tcp" accept' --permanent

sudo firewall-cmd --reload
```

---

## Commandes utiles

```bash
# Voir toutes les règles actives
sudo firewall-cmd --list-all

# Voir uniquement les rich rules
sudo firewall-cmd --list-rich-rules

# Supprimer une rich rule
sudo firewall-cmd --remove-rich-rule='...' --permanent

# Vérifier les logs SSH_ATTEMPT
sudo journalctl -k --grep="SSH_ATTEMPT" 
```

---

## Ce que j'ai appris

- Les règles sans `--permanent` disparaissent au premier `firewall-cmd --reload`
- Les interfaces de monitoring (Prometheus, Grafana) ne doivent jamais être ouvertes publiquement
- `limit value="3/m"` évite de saturer les logs en cas d'attaque volumétrique
- `family="ipv4"` est obligatoire dans une rich rule qui spécifie une adresse source
- Tester sans `--permanent` d'abord permet de valider avant de rendre permanent
