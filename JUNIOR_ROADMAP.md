# Roadmap — De Service Desk à Junior Systems Administrator

Parcours réaliste et complet. Chaque module construit sur le précédent.
Objectif : être opérationnel en entreprise comme Junior SysAdmin.

---

## Progression globale

```
Service Desk Analyst
        │
        ▼
   [TU ES ICI]
        │
        ▼
Junior Systems Administrator
        │
        ▼
  Systems Administrator
```

---

## SOCLE LINUX — La base non-négociable

### MODULE 01 — Linux Fundamentals ✅ COMPLÉTÉ

- Utilisateurs et groupes : useradd, groupadd, /etc/passwd, /etc/shadow
- Permissions : chmod, chown, rwx, sticky bit
- systemd : start, stop, enable, reload, status
- Logs : journalctl, /var/log, filtres
- Réseau de base : ip a, ip route, ss, firewall-cmd

---

### MODULE 02 — Système Linux avancé ✅ COMPLÉTÉ

- Filesystems : ext4, xfs, montage, fstab, df, du
- LVM : volumes logiques, extension à chaud, snapshots
- Mémoire : RAM, swap, OOM killer, /proc/meminfo
- Processus : ps, top, strace, lsof, signaux
- Performance : iostat, vmstat, identifier les goulots

---

### MODULE 03 — Bash scripting

> Automatiser les tâches répétitives — un Junior qui scripte vaut deux.

**Ce que tu vas apprendre :**
- Variables, conditions, boucles : if/elif, for, while, case
- Fonctions : structurer un script proprement
- Arguments : $1, $2, $#, getopts
- Gestion d'erreurs : set -e, $?, trap
- Parsing : grep, awk, sed — lire et extraire des données de logs
- Cron : automatiser l'exécution de scripts
- Script de backup : mysqldump automatisé avec rotation

**Projet :** Script de health check qui vérifie Nginx, MariaDB, l'espace disque et envoie un rapport

**Pourquoi c'est important :**
En entretien Junior, on te demande toujours si tu scriptes. Un script propre montre
que tu penses comme un ingénieur, pas comme un opérateur.

---

## RÉSEAU — Comprendre ce qui se passe sur le fil

### MODULE 04 — Réseau fondamental

> 80% des incidents ont une composante réseau. Sans ça, tu es aveugle.

**Ce que tu vas apprendre :**
- Modèle OSI en pratique : associer chaque outil à la bonne couche
- Adressage IP : subnets, CIDR, calcul de plages, passerelle
- DNS : résolution, dig, nslookup, /etc/resolv.conf, /etc/hosts
- DHCP : comment un client obtient une IP, bail DHCP
- TCP/UDP : différences, ports, états de connexion (ss, netstat)
- Firewall : firewalld zones, rich rules, iptables basics
- Troubleshooting réseau : ping, traceroute, mtr, tcpdump basique

**Projet :** Diagnostiquer et documenter 5 scénarios de panne réseau simulés

**Pourquoi c'est important :**
Un Junior SysAdmin sans bases réseau ne peut pas diagnostiquer les incidents.
C'est un prérequis pour tout le reste.

---

### MODULE 05 — DNS & DHCP en pratique

> Deux services que tu toucheras chaque semaine en entreprise.

**Ce que tu vas apprendre :**
- DNS récursif vs autoritaire : comment fonctionne la résolution
- Enregistrements DNS : A, AAAA, CNAME, MX, TXT, PTR
- Unbound : résolveur DNS local et cache
- BIND : serveur DNS autoritaire, zones, fichiers de zone
- DHCP server : plages, réservations par MAC, options DHCP
- Troubleshooting DNS : dig +trace, ordre de résolution

**Pourquoi c'est important :**
En entreprise, le DNS est partout. Un problème DNS peut mettre hors ligne
toute une infrastructure et personne ne sait pourquoi.

---

## SERVICES WEB — Stack complète

### MODULE 06 — Nginx ✅ COMPLÉTÉ

- Installation, configuration, virtual hosts
- SELinux, logs d'accès, HTTPS
- Reverse proxy

---

### MODULE 07 — MariaDB ✅ COMPLÉTÉ

- Installation, sécurisation, gestion des utilisateurs SQL
- Backup/restauration, scripting Bash, cron

---

### MODULE 08 — PHP-FPM — Stack LEMP complète

> Faire tourner une vraie application web — WordPress, Laravel.

**Ce que tu vas apprendre :**
- PHP-FPM : FastCGI Process Manager, pools, socket Unix
- Nginx + PHP-FPM : passer les requêtes .php à PHP-FPM
- OpCache : cache d'opcodes pour accélérer PHP
- Déploiement WordPress : installation, config, permissions
- Sécurité PHP : open_basedir, fonctions dangereuses désactivées
- Logs PHP : erreurs, slow log

**Projet :** Site WordPress fonctionnel sur RHEL avec Nginx + PHP-FPM + MariaDB

**Pourquoi c'est important :**
La majorité des petites et moyennes entreprises tournent sur WordPress.
Un Junior SysAdmin qui sait déployer et maintenir WordPress est immédiatement utile.

---

## MONITORING — Voir avant que ça casse

### MODULE 09 — Monitoring ✅ COMPLÉTÉ

- Prometheus + Node Exporter + Grafana
- Health checks en Bash

---

### MODULE 10 — Logs centralisés

> Sur plusieurs serveurs, lire les logs un par un est impossible.

**Ce que tu vas apprendre :**
- rsyslog : configuration, règles de filtrage, envoi vers serveur central
- logrotate : rotation automatique, compression, rétention
- journald : configuration, persistance, filtres avancés
- Loki + Promtail : centraliser les logs dans Grafana
- Alerting sur les logs : déclencher une alerte sur un pattern d'erreur

**Pourquoi c'est important :**
En entreprise, les logs de tous les serveurs arrivent au même endroit.
Un Junior qui ne sait pas chercher dans les logs centralisés est handicapé.

---

## SÉCURITÉ — Protéger l'infrastructure

### MODULE 11 — Sécurité système ✅ COMPLÉTÉ (en cours)

- SSH hardening, Fail2ban, firewall rich rules
- SELinux avancé, auditd
- Let's Encrypt (à finaliser)
- OpenSCAP (à finaliser)

---

### MODULE 12 — Gestion des accès et identités

> Qui a le droit de faire quoi — la question la plus importante en sécurité.

**Ce que tu vas apprendre :**
- sudo granulaire : autoriser des commandes précises, pas tout sudo
- PAM : authentification pluggable, politiques de mots de passe
- SSH avancé : jump hosts, ProxyJump, config ~/.ssh/config, 2FA
- Gestion des clés SSH : rotation, révocation, authorized_keys centralisé
- Comptes de service : utilisateurs sans shell, sans login
- Audit des accès : qui s'est connecté, quand, depuis où (last, lastlog, auditd)

**Pourquoi c'est important :**
Les accès non maîtrisés sont la première cause de compromission.
Un Junior qui gère les accès proprement est un Junior en qui on a confiance.

---

## AUTOMATISATION — Travailler intelligemment

### MODULE 13 — Ansible ✅ COMPLÉTÉ

- Roles, variables, handlers, templates Jinja2, Vault
- Déploiement LEMP stack automatisé

---

### MODULE 14 — Git & Versionning

> Tout ce qu'on modifie doit être versionné. Pas d'exception.

**Ce que tu vas apprendre :**
- Git basics : init, add, commit, push, pull, clone
- Branches : créer, fusionner, résoudre les conflits
- GitHub/GitLab : pull requests, issues, review
- GitFlow : workflow de collaboration en équipe
- Versionner les configs : ne jamais modifier un fichier sans le committer
- .gitignore : ne pas committer les secrets

**Projet :** Versionner toute la configuration de ton serveur RHEL

**Pourquoi c'est important :**
Un ingénieur qui ne versionne pas ses configs est un ingénieur qui perd ses configs.
Git est le minimum syndical en 2026.

---

## CONTENEURS — L'infrastructure moderne

### MODULE 15 — Docker

> Packager une application pour qu'elle tourne identiquement partout.

**Ce que tu vas apprendre :**
- Concepts : image, conteneur, registry, layers
- docker run : options essentielles (-d, -p, -v, --name, -e)
- Dockerfile : FROM, RUN, COPY, EXPOSE, CMD — construire une image custom
- Volumes : persister les données hors du conteneur
- Réseau Docker : bridge, host, communication inter-conteneurs
- Docker Compose : orchestrer plusieurs conteneurs avec un fichier YAML
- Projet : LEMP stack complète dans des conteneurs avec docker-compose

**Pourquoi c'est important :**
Docker est dans la quasi-totalité des offres d'emploi Junior en 2026.
C'est le standard de déploiement des nouvelles applications.

---

## STOCKAGE & BACKUP — Ne jamais perdre de données

### MODULE 16 — Backup & Disaster Recovery

> Les backups ne comptent que si on sait les restaurer.

**Ce que tu vas apprendre :**
- Stratégie 3-2-1 : 3 copies, 2 supports, 1 hors site
- rsync : synchronisation incrémentale de fichiers entre serveurs
- Backup MariaDB : mysqldump automatisé, rotation, vérification d'intégrité
- Snapshots LVM : backup cohérent sans arrêter les services
- Restauration : tester et documenter les procédures — un backup non testé n'est pas un backup
- Rétention : garder 7 jours, 4 semaines, 12 mois
- RTO / RPO : définir les objectifs de reprise

**Projet :** Système de backup automatisé avec script Bash + cron + alertes

**Pourquoi c'est important :**
Un Junior qui ne sait pas restaurer un backup n'est pas prêt pour la prod.
La première question d'un recruteur senior : "Comment tu testes tes backups ?"

---

## GESTION D'INCIDENTS — Réagir sous pression

### MODULE 17 — Troubleshooting & Incidents

> Ce n'est pas si on aura une panne, c'est quand.

**Ce que tu vas apprendre :**
- Méthodologie : reproduire → isoler → identifier → corriger → vérifier
- Les 10 premières commandes sur un serveur problématique
- Scénarios réels simulés : service qui plante, disque plein, OOM, CPU à 100%
- Post-mortem : rédiger un compte-rendu d'incident (timeline, cause, actions)
- Runbooks : documenter les procédures pour les incidents récurrents
- Communication : tenir les parties prenantes informées sans paniquer

**Projet :** Documenter 5 incidents réels ou simulés avec post-mortem complet

**Pourquoi c'est important :**
En entretien, on te demandera toujours "raconte-moi un incident que tu as géré".
La méthode compte autant que la solution technique.

---

## WINDOWS & ACTIVE DIRECTORY — La réalité des entreprises

### MODULE 18 — Windows Server & Active Directory

> 90% des entreprises ont un Active Directory. Tu dois savoir t'y repérer.

**Ce que tu vas apprendre :**
- Windows Server : rôles, fonctionnalités, interface
- Active Directory : domaine, utilisateurs, groupes, OU, GPO
- Intégration Linux/AD : joindre un serveur RHEL à un domaine Windows (SSSD, realm join)
- PowerShell basics : commandes d'administration essentielles
- RDP & WinRM : accès distant sécurisé
- Troubleshooting AD : authentification, permissions, GPO

**Pourquoi c'est important :**
La plupart des environnements enterprise sont mixtes Linux/Windows.
Un Junior SysAdmin qui ne connaît pas l'AD est limité dans les PME.

---

## VIRTUALISATION — Comprendre l'infrastructure physique

### MODULE 19 — Virtualisation (KVM/VMware basics)

> Les serveurs physiques font tourner des VMs — tu dois savoir les gérer.

**Ce que tu vas apprendre :**
- Concepts : hyperviseur, VM, vCPU, vRAM, snapshot
- KVM/libvirt : créer et gérer des VMs sur RHEL
- virsh : commandes de gestion des VMs
- VMware vSphere basics : vCenter, ESXi, datastore (notions)
- Proxmox : alternative open source populaire en PME
- Migration à chaud : déplacer une VM sans interruption
- Snapshots : sauvegarder l'état d'une VM avant une intervention

**Pourquoi c'est important :**
En entreprise, tu travailles sur des VMs, pas des physiques.
Un Junior qui ne sait pas créer ou cloner une VM est bloqué dès le premier jour.

---

## CLOUD — L'infrastructure de demain

### MODULE 20 — Cloud Fundamentals (AWS)

> Une introduction suffisante pour ne pas être perdu quand le sujet arrive.

**Ce que tu vas apprendre :**
- Concepts cloud : IaaS, PaaS, SaaS, régions, zones de disponibilité
- AWS Core : EC2 (VMs), S3 (stockage), VPC (réseau), IAM (accès), Route53 (DNS)
- CLI AWS : créer et gérer des ressources depuis le terminal
- Sécurité cloud : IAM least privilege, Security Groups
- Coûts : comprendre la facturation, éviter les surprises

**Pourquoi c'est important :**
De plus en plus d'offres Junior mentionnent "notions cloud appréciées".
Pas besoin d'être expert — connaître les concepts suffit au niveau Junior.

---

## CERTIFICATION — Valider les compétences

### MODULE 21 — RHCSA (Red Hat Certified System Administrator)

> La certification la plus reconnue pour un Junior Linux en entreprise.

**Exam EX200 — 100% pratique, 3h en ligne de commande**

**Compétences testées :**
- Gestion des utilisateurs et groupes
- Permissions et SELinux
- LVM et stockage
- systemd et services
- Réseau de base
- Firewall
- Cron et scripts Bash

**Préparation :** Modules 01-05, 11-12 de cette roadmap

**Valeur marché :**
- Salaire moyen +15-20% vs sans certification
- Signal fort pour les recruteurs : exam pratique, impossible de tricher
- Requis ou fortement apprécié dans les offres Linux enterprise

---

## Résumé de progression

| # | Module | Statut | Compétences clés |
|---|--------|--------|-----------------|
| 01 | Linux Fundamentals | ✅ | users, permissions, systemd, logs |
| 02 | Linux System avancé | ✅ | LVM, mémoire, processus, performance |
| 03 | Bash Scripting | ⬜ | variables, boucles, fonctions, cron |
| 04 | Réseau Fondamental | ⬜ | IP, DNS, DHCP, TCP, troubleshooting |
| 05 | DNS & DHCP | ⬜ | BIND, Unbound, enregistrements |
| 06 | Nginx | ✅ | vhost, SSL, reverse proxy |
| 07 | MariaDB | ✅ | SQL, backup, scripting |
| 08 | PHP-FPM / LEMP | ⬜ | WordPress, PHP-FPM, OpCache |
| 09 | Monitoring | ✅ | Prometheus, Grafana, alertes |
| 10 | Logs centralisés | ⬜ | rsyslog, Loki, logrotate |
| 11 | Sécurité système | 🔄 | SSH, Fail2ban, SELinux, auditd |
| 12 | Accès & Identités | ⬜ | sudo, PAM, SSH avancé, 2FA |
| 13 | Ansible | ✅ | roles, variables, vault, templates |
| 14 | Git & Versionning | ⬜ | branches, PR, GitFlow |
| 15 | Docker | 🔄 | images, Dockerfile, Compose |
| 16 | Backup & Recovery | ⬜ | rsync, mysqldump, snapshots, RTO/RPO |
| 17 | Troubleshooting | ⬜ | méthodologie, post-mortem, runbooks |
| 18 | Windows Server & AD | ⬜ | Active Directory, PowerShell, intégration |
| 19 | Virtualisation KVM | ⬜ | VMs, virsh, snapshots, migration |
| 20 | Cloud AWS | ⬜ | EC2, S3, IAM, VPC, notions cloud |
| 21 | RHCSA | ⬜ | certification pratique Red Hat |

**Légende :** ✅ Complété · 🔄 En cours · ⬜ À faire

---

## Combien de temps ?

| Rythme | Durée estimée |
|--------|--------------|
| 1h/jour · 5j/semaine | 10-12 mois |
| 2h/jour · 5j/semaine | 5-6 mois |
| Temps plein (8h/jour) | 2-3 mois |

Le rythme importe moins que la régularité. 1h chaque jour bat 8h le weekend.

---

## Ce qui te rend employable en Junior

Un recruteur cherche ces signaux :

| Signal | Comment tu le montres |
|--------|----------------------|
| Tu pratiques sur un vrai serveur | Ton blog + GitHub |
| Tu documentes ce que tu fais | syseng-journey |
| Tu comprends les bases réseau | Module 04 |
| Tu scriptes en Bash | Module 03 |
| Tu connais Docker | Module 15 |
| Tu gères les incidents | Module 17 |
| Tu as une certification | RHCSA |

Tu n'as pas besoin de tout finir pour postuler —
**Modules 01-04 + 06-07 + 11 + 13 + 14 + certification RHCSA** suffisent pour la plupart des offres Junior.
