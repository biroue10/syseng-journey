# Fail2ban — Bannissement automatique des IPs

## Objectif

Bloquer automatiquement les IPs qui font du brute force SSH ou Nginx en ajoutant des règles firewall dynamiquement.

---

## Comment ça marche

```
IP tente de se connecter → SSH échoue → journald enregistre →
Fail2ban détecte le pattern → firewalld banne l'IP
```

Fail2ban lit les logs (journal systemd sur RHEL), détecte les patterns d'échec, et crée des règles `firewall-cmd` pour bloquer l'IP.

---

## Installation

EPEL requis sur RHEL 10 :

```bash
sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm -y
sudo dnf install fail2ban -y
```

---

## Configuration — /etc/fail2ban/jail.local

Toujours créer `jail.local`, jamais modifier `jail.conf` — `jail.conf` est écrasé lors des mises à jour du package, `jail.local` survit.

```ini
[DEFAULT]
bantime  = 1h
findtime = 10m
maxretry = 3
ignoreip = 127.0.0.1/8

[sshd]
enabled = true
port    = ssh
backend = systemd
```

| Paramètre | Valeur | Signification |
|-----------|--------|--------------|
| `bantime` | `1h` | Durée du ban |
| `findtime` | `10m` | Fenêtre de temps pour compter les échecs |
| `maxretry` | `3` | Nombre d'échecs dans findtime avant ban |
| `ignoreip` | `127.0.0.1/8` | IPs jamais bannies (localhost) |
| `backend` | `systemd` | Lire le journal systemd (pas un fichier log) |

`findtime` + `maxretry` ensemble : 3 échecs **en 10 minutes** → ban. 3 échecs en 2 heures → pas de ban.

---

## Démarrage

```bash
sudo systemctl enable fail2ban --now
sudo systemctl status fail2ban --no-pager
```

---

## Vérification

```bash
# Status de la jail SSH
sudo fail2ban-client status sshd

# Voir les règles firewall créées par Fail2ban
sudo firewall-cmd --list-rich-rules

# Voir les logs Fail2ban
sudo journalctl -u fail2ban --no-pager | tail -20

# Débanner une IP manuellement
sudo fail2ban-client unban <IP>
```

---

## Ce que j'ai appris

- `jail.local` > `jail.conf` — toujours utiliser local pour les modifications
- `backend = systemd` est obligatoire sur RHEL 10 — SSH écrit dans le journal, pas dans `/var/log/secure`
- Fail2ban utilise firewalld pour appliquer les bans — une règle rich rule est créée par IP bannie
- `findtime` est la fenêtre temporelle — les échecs en dehors de cette fenêtre ne comptent pas
- EPEL n'est pas disponible nativement sur RHEL 10 — installer depuis Fedora directement
