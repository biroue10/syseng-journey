# syseng-journey

Mon parcours structuré de Service Desk Analyst à Senior Systems Engineer.

Tout est pratiqué sur un vrai serveur RHEL 10.2, pas sur un simulateur.

**Blog** : [biroue10.github.io](https://biroue10.github.io)

---

## Environnement

| Composant | Détail |
|-----------|--------|
| OS | Red Hat Enterprise Linux 10.2 (Coughlan) |
| Kernel | 6.12.0 |
| Accès | SSH + Tailscale VPN |
| Outils | Git, Bash, Ansible |

---

## Progression

| # | Module | Statut | Compétences acquises |
|---|--------|--------|----------------------|
| 01 | Linux Fundamentals | ✅ | users, permissions, systemd, logs, réseau |
| 02 | Nginx | ✅ | vhosts, SELinux, HTTPS, logs d'accès |
| 03 | MariaDB | ✅ | SQL, backup, scripting Bash, cron |
| 04 | Monitoring | ✅ | Prometheus, Node Exporter, Grafana |
| 05 | Bash avancé | ⏸ | — |
| 06 | Linux Internals | ✅ | LVM, mémoire, processus, réseau avancé |
| 07 | Haute disponibilité | 🔄 | Nginx LB ✅ · MariaDB replication ✅ · Keepalived ⏸ |
| 08 | Ansible | 🔄 | roles ✅ · idempotence ✅ · variables/handlers/Vault ⏸ |
| 09 | Sécurité système | ⬜ | |
| 10 | Gestion d'incidents | ⬜ | |
| 11 | Docker | ⬜ | |
| 12 | Kubernetes | ⬜ | |
| 13 | Terraform | ⬜ | |
| … | … | … | [voir ROADMAP.md](./ROADMAP.md) |

---

## Projets associés

| Projet | Description | Lien |
|--------|-------------|------|
| ansible-lemp-stack | Déploiement LEMP automatisé avec Ansible | [github.com/biroue10/ansible-lemp-stack](https://github.com/biroue10/ansible-lemp-stack) |

---

## Structure

```
syseng-journey/
├── 01-linux-fundamentals/
├── 02-nginx/
├── 03-mariadb/
├── 04-monitoring/
├── 06-linux-internals/
├── 07-high-availability/
│   ├── load-balancing.md
│   └── mariadb-replication.md
├── ROADMAP.md
└── README.md
```

---

## Objectif final

Maîtriser les 38 modules du [ROADMAP.md](./ROADMAP.md) et décrocher un poste de Senior Systems Engineer.
