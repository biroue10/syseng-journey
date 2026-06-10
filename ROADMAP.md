# Roadmap — De Service Desk à Senior Systems Engineer

Parcours complet, progressif, basé sur des compétences réelles en production.
Chaque module s'appuie sur le précédent. Ne pas sauter d'étape.

---

## MODULE 01 — Linux Fundamentals ✅ COMPLÉTÉ

> Base absolue. Sans ça, rien d'autre ne tient.

- **Utilisateurs et groupes** : useradd, groupadd, usermod, /etc/passwd, /etc/shadow
- **Permissions** : chmod, chown, lecture rwx, permissions octales, sticky bit
- **systemd** : start, stop, enable, disable, reload, status, journalctl
- **Logs** : journalctl, /var/log, filtres par priorité et par service
- **Réseau de base** : ip a, ip route, ss, firewall-cmd, hardening

---

## MODULE 02 — Nginx ✅ COMPLÉTÉ

> Serveur web le plus utilisé au monde. Incontournable.

- **Installation et démarrage** : dnf, systemctl, vérification avec curl
- **Configuration** : nginx.conf, blocs http/server/location, directives essentielles
- **Virtual hosts** : conf.d, server_name, root, plusieurs sites sur un serveur
- **SELinux** : contextes httpd_sys_content_t, restorecon, getenforce
- **Logs d'accès** : format, filtrage grep, codes HTTP
- **HTTPS** : openssl, certificat auto-signé, ssl_certificate, port 443

---

## MODULE 03 — MariaDB ✅ COMPLÉTÉ

> Base de données relationnelle centrale dans la stack web.

- **Installation et sécurisation** : mysql_secure_installation, hardening de base
- **Gestion des utilisateurs SQL** : CREATE USER, GRANT, FLUSH PRIVILEGES
- **SQL de diagnostic** : SELECT, WHERE, DESCRIBE, SHOW TABLES
- **Backup et restauration** : mysqldump, restauration avec <
- **Scripting Bash** : variables, $?, horodatage, gestion d'erreur
- **Cron** : planification automatique, format crontab

---

## MODULE 04 — Monitoring et alerting 🔜 SUIVANT

> Un serveur sans monitoring est un serveur qu'on découvre cassé trop tard.

### Ce que tu vas apprendre :
- **Health checks en Bash** : script qui vérifie si Nginx et MariaDB tournent, envoie une alerte si non
- **Métriques système** : surveiller CPU (top, mpstat), RAM (free, vmstat), disque (df, iostat)
- **Prometheus + Node Exporter** : collecter des métriques en temps réel depuis le système
- **Grafana** : visualiser les métriques sous forme de dashboards
- **Alertmanager** : déclencher des alertes email/Slack quand un seuil est dépassé
- **Logs centralisés** : rsyslog, rotation des logs avec logrotate

### Pourquoi c'est important :
En production, on détecte les incidents avant que les utilisateurs les signalent. Un ingénieur senior sait construire et lire ses dashboards, et être réveillé par une alerte pertinente — pas par un client mécontent.

---

## MODULE 05 — Bash scripting avancé

> L'automatisation est le cœur du métier. Un bon script remplace des heures de travail manuel.

### Ce que tu vas apprendre :
- **Arguments et options** : $1, $2, getopts, scripts paramétrables
- **Fonctions** : structurer un script comme un programme
- **Boucles et conditions** : for, while, if/elif/else, case
- **Parsing de logs** : grep, awk, sed, couper et analyser des fichiers texte
- **Gestion d'erreurs** : set -e, trap, codes de retour
- **Script de déploiement** : déployer une application, vérifier chaque étape, rollback en cas d'échec
- **Sécurité des scripts** : éviter les injections, protéger les credentials (fichiers .my.cnf)

### Pourquoi c'est important :
Tout ce qu'on fait à la main peut être scripté. Un ingénieur qui scripte bien est 10 fois plus efficace qu'un ingénieur qui fait tout manuellement. C'est aussi la base avant d'apprendre Ansible.

---

## MODULE 06 — Système Linux avancé

> Comprendre ce qui se passe sous le capot pour diagnostiquer les problèmes difficiles.

### Ce que tu vas apprendre :
- **Filesystems** : types (ext4, xfs, tmpfs), montage/démontage, fstab, df, du
- **LVM** : volumes logiques, extension à chaud, snapshots
- **Mémoire** : RAM, swap, OOM killer, /proc/meminfo, vmstat
- **Processus** : ps, top, htop, strace, lsof, signaux (SIGTERM, SIGKILL)
- **Réseau avancé** : tcpdump, netstat, bonding, routing avancé, iptables basics
- **Kernel et sysctl** : paramètres réseau et mémoire, /proc et /sys
- **Performance** : iostat, sar, identifier les goulots d'étranglement

### Pourquoi c'est important :
Quand Nginx est lent ou que la base de données répond mal, il faut savoir si le problème vient du CPU, du disque, de la mémoire ou du réseau. Ces outils sont le kit de diagnostic d'un ingénieur senior.

---

## MODULE 07 — Haute disponibilité (HA)

> Zéro coupure en production. Les utilisateurs ne doivent pas sentir les pannes.

### Ce que tu vas apprendre :
- **Nginx load balancer** : répartir le trafic entre plusieurs serveurs backend
- **Health checks** : Nginx détecte et retire automatiquement un backend défaillant
- **MariaDB replication** : master/slave, binlog, synchronisation en temps réel
- **Failover MariaDB** : promouvoir un slave en master en cas de panne
- **Keepalived** : VIP (Virtual IP) qui bascule automatiquement d'un serveur à l'autre
- **Concepts** : SPOF (Single Point of Failure), RTO, RPO, SLA

### Pourquoi c'est important :
C'est ce qui distingue une infrastructure de production d'un serveur de test. Un senior engineer conçoit des systèmes qui résistent aux pannes matérielles, aux mises à jour et aux pics de charge.

---

## MODULE 08 — Automatisation avec Ansible

> Gérer 1 serveur à la main, c'est faisable. Gérer 50 serveurs, c'est Ansible.

### Ce que tu vas apprendre :
- **Installation et concepts** : control node, managed nodes, inventaire, SSH sans mot de passe
- **Commandes ad-hoc** : lancer une commande sur tous les serveurs en une ligne
- **Playbooks** : fichiers YAML qui décrivent un état souhaité (install Nginx, créer un user...)
- **Variables et templates** : personnaliser la config selon le serveur (Jinja2)
- **Roles** : structurer un playbook réutilisable (role nginx, role mariadb...)
- **Handlers** : recharger Nginx uniquement si la config a changé
- **Vault** : chiffrer les secrets (mots de passe, clés) dans les playbooks
- **Cas pratique** : déployer toute la stack Nginx + MariaDB sur un serveur vierge en une commande

### Pourquoi c'est important :
L'Infrastructure as Code (IaC) est le standard en entreprise. Un déploiement manuel non documenté est un risque. Un playbook Ansible est reproductible, versionnable et auditable.

---

## MODULE 09 — Sécurité système

> Un serveur exposé sans durcissement est une cible. La sécurité se construit couche par couche.

### Ce que tu vas apprendre :
- **Hardening RHEL** : CIS Benchmark, désactiver les services inutiles, sshd_config
- **SSH sécurisé** : désactiver l'auth par mot de passe, changer le port, AllowUsers
- **Fail2ban** : bloquer automatiquement les IPs qui font du brute force SSH/Nginx
- **SELinux avancé** : modes, politiques, audit2allow, résoudre les blocages sans tout désactiver
- **Gestion des certificats** : Let's Encrypt avec Certbot, renouvellement automatique
- **Audit** : auditd, qui a fait quoi sur le système
- **Firewall avancé** : zones firewalld, rich rules, logging des connexions refusées
- **Vulnérabilités** : scanner avec OpenSCAP, appliquer les patches de sécurité

### Pourquoi c'est important :
Les serveurs exposés sur internet subissent des attaques en continu. Un ingénieur senior est responsable de la surface d'attaque de son infrastructure. La sécurité n'est pas optionnelle.

---

## MODULE 10 — Gestion d'incidents

> Ce n'est pas si on aura une panne, c'est quand. L'important c'est la réaction.

### Ce que tu vas apprendre :
- **Méthodologie de diagnostic** : reproduire, isoler, identifier, corriger, vérifier
- **Checklist d'incident** : les 10 premières commandes à lancer sur un serveur qui a un problème
- **Post-mortem** : rédiger un compte-rendu d'incident professionnel (timeline, cause, actions)
- **Runbooks** : documenter les procédures de résolution pour les incidents récurrents
- **Communication** : informer les parties prenantes pendant et après un incident
- **Cas pratiques** : simuler des pannes réelles (service qui plante, disque plein, OOM, certificat expiré)

### Pourquoi c'est important :
En entretien senior, on te demandera comment tu as géré des incidents. La qualité d'un ingénieur se voit dans sa méthode, pas seulement dans ses connaissances techniques.

---

## MODULE 11 — Conteneurs Docker

> De plus en plus présent dans les infrastructures modernes. Incontournable en 2026.

### Ce que tu vas apprendre :
- **Concepts** : image, conteneur, registry, volumes, réseau Docker
- **Dockerfile** : construire une image personnalisée
- **docker-compose** : orchestrer Nginx + MariaDB + PHP dans des conteneurs
- **Intégration avec Nginx** : reverse proxy vers des conteneurs
- **Persistance** : volumes pour les données MariaDB
- **Sécurité** : utilisateur non-root dans les conteneurs, scan d'images

---

## MODULE 12 — Kubernetes (K8s)

> L'orchestrateur de conteneurs standard en entreprise. Requis pour tout poste senior en 2026.

### Ce que tu vas apprendre :
- **Concepts** : pods, deployments, services, namespaces, ingress
- **Installation** : cluster K8s avec k3s ou kubeadm sur RHEL
- **kubectl** : déployer, scaler, inspecter des applications
- **ConfigMaps et Secrets** : gérer la configuration et les credentials
- **Persistent Volumes** : stocker les données hors des pods
- **Helm** : gestionnaire de paquets K8s, déployer Prometheus/Grafana via Helm
- **Monitoring K8s** : intégrer Prometheus pour surveiller le cluster

### Pourquoi c'est important :
La majorité des infrastructures modernes tournent sur Kubernetes. Un senior engineer qui ne connaît pas K8s est limité dans ses opportunités.

---

## MODULE 13 — Terraform — Infrastructure as Code

> Provisionner l'infrastructure comme du code — reproductible, versionnable, auditable.

### Ce que tu vas apprendre :
- **Concepts** : providers, resources, state, plan, apply
- **Premiers pas** : créer des VMs, des réseaux, des règles firewall
- **Variables et outputs** : paramétrer l'infrastructure
- **Modules** : réutiliser des blocs d'infrastructure
- **Remote state** : partager le state entre équipes
- **Cas pratique** : provisionner un serveur RHEL complet avec Nginx + MariaDB

### Pourquoi c'est important :
Terraform est le standard IaC en entreprise. Il complète Ansible (Terraform crée l'infra, Ansible la configure).

---

## MODULE 14 — Observabilité avancée (ELK / Loki)

> Prometheus surveille les métriques. ELK ou Loki centralisent les logs de tous les serveurs.

### Ce que tu vas apprendre :
- **Loki + Promtail** : collecter et centraliser les logs dans Grafana (même stack que Prometheus)
- **Elasticsearch + Kibana** : moteur de recherche sur les logs, dashboards avancés
- **Logstash** : pipeline de traitement des logs
- **Alerting sur les logs** : déclencher une alerte quand un pattern d'erreur apparaît
- **Distributed tracing** : suivre une requête à travers plusieurs services
- **Cas pratique** : centraliser les logs Nginx, MariaDB et système en un seul endroit

### Pourquoi c'est important :
Sur une infrastructure avec 10+ serveurs, lire les logs un par un est impossible. La centralisation des logs est essentielle pour le diagnostic d'incidents.

---

## MODULE 15 — Stack PHP-FPM (LEMP complet)

> Compléter la stack web avec PHP pour faire tourner WordPress, Laravel ou toute app PHP.

### Ce que tu vas apprendre :
- **PHP-FPM** : FastCGI Process Manager, communication avec Nginx via socket Unix
- **Configuration** : pools PHP-FPM, limites mémoire, timeout
- **Nginx + PHP-FPM** : passer les requêtes `.php` à PHP-FPM
- **Déploiement d'application** : WordPress ou Laravel en production
- **OpCache** : accélérer PHP avec le cache d'opcodes
- **Sécurité** : `open_basedir`, désactiver les fonctions dangereuses

### Pourquoi c'est important :
90% des sites web tournent sur PHP. Un sysadmin web qui ne sait pas configurer PHP-FPM est incomplet.

---

## MODULE 16 — Backup & Disaster Recovery

> Les backups ne comptent que si on sait les restaurer.

### Ce que tu vas apprendre :
- **Stratégie 3-2-1** : 3 copies, 2 supports différents, 1 hors site
- **rsync** : synchronisation incrémentale de fichiers entre serveurs
- **Snapshots LVM** : backup cohérent sans arrêter les services
- **Backup MariaDB** : mysqldump, xtrabackup pour les backups à chaud
- **Restauration** : tester et documenter les procédures de restauration
- **Rétention** : rotation automatique des sauvegardes (garder 7 jours, 4 semaines, 12 mois)
- **RTO / RPO** : définir les objectifs de reprise

### Pourquoi c'est important :
Un ingénieur senior est responsable de la continuité de service. Sans backup testé, il n't y a pas de backup.

---

## MODULE 17 — CI/CD et Git avancé

> Livrer plus vite et plus sûrement, sans intervention manuelle.

### Ce que tu vas apprendre :
- **Git avancé** : branches, merge, rebase, tags, workflows (GitFlow, trunk-based)
- **GitHub Actions** : pipeline qui teste et déploie automatiquement
- **Déploiement sans interruption** : blue/green, rolling updates, canary
- **Tests automatisés** : lint, syntax check, tests d'intégration dans le pipeline
- **Secrets dans CI/CD** : gérer les credentials de façon sécurisée

---

## MODULE 18 — Réseau avancé

> Un senior engineer diagnostique les problèmes réseau sans aide. C'est non-négociable.

### Ce que tu vas apprendre :
- **Modèle OSI en pratique** : associer chaque outil à la bonne couche
- **tcpdump** : capturer et analyser le trafic réseau en temps réel
- **nftables / iptables** : firewall bas niveau, NAT, règles de filtrage
- **Routage** : table de routage, routes statiques, `ip route`
- **VLANs** : segmentation réseau, interfaces taggées
- **Bonding / Teaming** : agrégation de liens réseau pour la redondance
- **Troubleshooting réseau** : méthodologie — ping, traceroute, mtr, ss, nmap
- **Wireshark** : analyse de captures réseau (.pcap)

### Pourquoi c'est important :
80% des incidents en production ont une composante réseau. Savoir lire un tcpdump ou tracer un paquet est la différence entre un junior et un senior.

---

## MODULE 19 — DNS & Mail

> Deux services fondamentaux de toute infrastructure. Souvent mal compris, toujours critiques.

### Ce que tu vas apprendre :

#### DNS
- **Concepts** : résolution récursive vs autoritaire, A, AAAA, CNAME, MX, TXT, PTR, SOA
- **BIND** : serveur DNS autoritaire, zones, fichiers de zone
- **Unbound** : résolveur DNS récursif et cache local
- **DNSSEC** : signature des zones, chaîne de confiance
- **Troubleshooting DNS** : dig, nslookup, resolver order

#### Mail
- **Postfix** : MTA (Mail Transfer Agent), relai SMTP
- **SPF, DKIM, DMARC** : authentification des emails, protection anti-spam
- **Dovecot** : serveur IMAP/POP3 pour la réception
- **Cas pratique** : serveur mail fonctionnel avec anti-spam basique

### Pourquoi c'est important :
Le DNS est le pilier de tout service réseau. Un problème DNS peut mettre hors ligne toute une infrastructure. Le mail est souvent géré par les sysadmins dans les PME.

---

## MODULE 20 — VPN & Accès sécurisé

> Sécuriser les accès distants à l'infrastructure — comme tu le fais déjà avec Tailscale.

### Ce que tu vas apprendre :
- **WireGuard** : VPN moderne, rapide, configuration minimaliste
- **OpenVPN** : VPN traditionnel, PKI, certificats clients
- **SSH avancé** : tunneling, jump hosts, ProxyJump, `~/.ssh/config`
- **Bastion host** : architecture de saut sécurisé
- **Fail2ban VPN** : protéger les points d'entrée
- **2FA SSH** : authentification à deux facteurs avec Google Authenticator
- **Audit des connexions** : qui s'est connecté, quand, depuis où

### Pourquoi c'est important :
L'accès distant sécurisé est la première ligne de défense. Un ingénieur senior conçoit des architectures d'accès qui ne compromettent pas la sécurité.

---

## MODULE 21 — HAProxy & Reverse Proxy avancé

> Le load balancer utilisé par GitHub, Stack Overflow, Twitter. Plus puissant que Nginx pour ce rôle.

### Ce que tu vas apprendre :
- **HAProxy vs Nginx** : différences, quand utiliser lequel
- **Configuration** : frontend, backend, ACL, modes TCP et HTTP
- **Algorithmes de load balancing** : round-robin, least-conn, ip-hash, random
- **Health checks actifs** : retirer automatiquement un backend défaillant
- **SSL termination** : déchiffrer le TLS au niveau du load balancer
- **Stats dashboard** : monitoring temps réel des connexions et backends
- **Sticky sessions** : maintenir un utilisateur sur le même backend
- **Cas pratique** : HAProxy devant 2 serveurs Nginx avec failover automatique

### Pourquoi c'est important :
HAProxy est le standard industriel du load balancing. Il est présent dans la majorité des stacks de production.

---

## MODULE 22 — Redis & Caching

> La vitesse d'une application dépend souvent de sa couche de cache.

### Ce que tu vas apprendre :
- **Concepts** : cache en mémoire, TTL, éviction (LRU, LFU)
- **Redis** : installation, CLI, types de données (string, list, hash, set, sorted set)
- **Cas d'usage** : cache de sessions PHP, cache de requêtes SQL, file d'attente
- **Redis Sentinel** : haute disponibilité, failover automatique
- **Redis Cluster** : sharding pour la scalabilité
- **Monitoring Redis** : redis-cli INFO, métriques Prometheus
- **Sécurité** : authentification, binding, ACL

### Pourquoi c'est important :
Redis est dans le top 5 des technologies les plus utilisées en production. Il réduit la charge sur MariaDB et accélère les applications de 10x à 100x.

---

## MODULE 23 — PostgreSQL

> Le SGBD open source le plus avancé. Complémentaire à MariaDB, requis dans de nombreuses stacks.

### Ce que tu vas apprendre :
- **Installation et configuration** : postgresql.conf, pg_hba.conf, rôles
- **SQL avancé** : transactions, index, EXPLAIN ANALYZE, vues, procédures stockées
- **Backup** : pg_dump, pg_basebackup, PITR (Point-In-Time Recovery)
- **Réplication** : streaming replication, réplication logique
- **Performance** : connection pooling avec PgBouncer, vacuum, autovacuum
- **Extensions** : pgvector, PostGIS, timescaledb
- **Monitoring** : pg_stat_* views, intégration Prometheus

### Pourquoi c'est important :
PostgreSQL est adopté par AWS, GitLab, Shopify, Instagram. Connaître les deux SGBD majeurs (MariaDB + PostgreSQL) est un avantage compétitif fort.

---

## MODULE 24 — Stockage avancé

> Gérer le stockage d'une infrastructure multi-serveurs.

### Ce que tu vas apprendre :
- **NFS** : partage de fichiers entre serveurs Linux, montage automatique via fstab
- **Samba** : partage de fichiers Windows/Linux
- **iSCSI** : stockage bloc réseau, initiator/target
- **MinIO** : stockage objet compatible S3, auto-hébergé
- **Snapshots LVM** : sauvegardes cohérentes sans arrêt de service
- **Quota disque** : limiter l'espace par utilisateur ou groupe
- **RAID logiciel** : mdadm, RAID 1 / RAID 5 / RAID 6

### Pourquoi c'est important :
Dans une infrastructure HA, le stockage est souvent le point de défaillance unique. Un senior engineer sait concevoir une architecture de stockage redondante.

---

## MODULE 25 — Base de données HA avancée

> Aller au-delà de la réplication simple — clustering et proxy de base de données.

### Ce que tu vas apprendre :
- **Galera Cluster** : réplication multi-master synchrone pour MariaDB
- **ProxySQL** : proxy intelligent qui route les requêtes lecture/écriture
- **Percona XtraBackup** : backup à chaud sans verrouillage de tables
- **Orchestrator** : gestion automatique du failover de réplication
- **MaxScale** : proxy MariaDB avancé avec load balancing de requêtes SQL
- **Monitoring avancé** : métriques Galera dans Prometheus, alertes de lag de réplication

### Pourquoi c'est important :
La base de données est souvent le goulot d'étranglement en production. Un ingénieur capable de concevoir un cluster MariaDB HA est très recherché.

---

## MODULE 26 — Virtualisation (KVM/libvirt)

> Créer et gérer des machines virtuelles directement sur RHEL — comme le font les hébergeurs.

### Ce que tu vas apprendre :
- **KVM** : hyperviseur Linux natif, intégré au kernel
- **libvirt** : API de gestion des VMs, virsh, virt-manager
- **Création de VMs** : images qcow2, réseaux virtuels, stockage
- **Cloud-init** : provisioning automatique des VMs au premier démarrage
- **Migration à chaud** : déplacer une VM sans interruption
- **Snapshots** : sauvegarder l'état d'une VM
- **Réseau virtuel** : bridge, NAT, VLAN pour les VMs

### Pourquoi c'est important :
KVM est la base de nombreux clouds privés (OpenStack, oVirt). Comprendre la virtualisation au niveau hyperviseur est essentiel pour un senior engineer en datacenter.

---

## MODULE 27 — HashiCorp Vault — Gestion des secrets

> Ne jamais stocker un mot de passe en clair dans un fichier de config.

### Ce que tu vas apprendre :
- **Concepts** : secrets statiques vs dynamiques, policies, tokens
- **Installation** : Vault en mode dev puis production
- **Secrets engines** : KV (clé/valeur), PKI (certificats), database (credentials temporaires)
- **Auth methods** : AppRole, AWS, Kubernetes
- **Credentials dynamiques** : Vault génère un utilisateur MariaDB temporaire à la demande
- **Intégration Ansible** : lire les secrets Vault dans les playbooks
- **Audit log** : qui a accédé à quel secret, quand

### Pourquoi c'est important :
Les fuites de credentials sont la première cause de compromission des infrastructures. Vault est le standard pour la gestion des secrets en production.

---

## MODULE 28 — GitOps (ArgoCD / Flux)

> L'état de l'infrastructure déclaré dans Git — tout changement passe par une pull request.

### Ce que tu vas apprendre :
- **Concepts GitOps** : déclaratif vs impératif, source de vérité unique
- **ArgoCD** : déploiement continu sur Kubernetes depuis Git
- **Flux** : alternative à ArgoCD, plus léger
- **Helm + GitOps** : gérer les releases Helm via Git
- **Drift detection** : détecter quand l'infra réelle diverge de Git
- **Rollback** : revenir à un état précédent avec un simple `git revert`

### Pourquoi c'est important :
GitOps est le modèle opérationnel des équipes Platform Engineering. Tout change par Git, tout est auditable, tout est réversible.

---

## MODULE 29 — Python pour SysAdmin

> Bash a des limites. Python les dépasse.

### Ce que tu vas apprendre :
- **Bases Python** : variables, fonctions, fichiers, exceptions — vue du sysadmin
- **Modules essentiels** : os, sys, subprocess, shutil, pathlib
- **Parsing** : lire des fichiers de logs, CSV, JSON, YAML avec Python
- **Requêtes HTTP** : requests — interroger des APIs (Prometheus, Grafana, GitHub)
- **Fabric** : exécuter des commandes SSH depuis Python
- **Scripts de maintenance** : nettoyage de fichiers, rotation de logs, rapports
- **Cas pratique** : script Python qui interroge l'API Prometheus et envoie un rapport par email

### Pourquoi c'est important :
Python est le deuxième langage des sysadmins après Bash. Ansible est écrit en Python. Terraform providers sont écrits en Go mais les scripts de glue sont en Python.

---

## MODULE 30 — Cloud (AWS / GCP fundamentals)

> L'infrastructure ne vit plus seulement dans des datacenters physiques.

### Ce que tu vas apprendre :
- **Concepts cloud** : IaaS, PaaS, SaaS, régions, AZ, VPC
- **AWS Core** : EC2, S3, RDS, IAM, VPC, Route53, CloudWatch
- **CLI AWS** : aws-cli, créer et gérer des ressources depuis le terminal
- **Terraform + AWS** : provisionner une infrastructure AWS complète
- **Sécurité cloud** : IAM least privilege, Security Groups, KMS
- **Coûts** : comprendre la facturation, éviter les surprises
- **Migration** : déplacer une app on-premise vers le cloud

### Pourquoi c'est important :
La majorité des nouvelles infrastructures sont cloud ou hybrides. Un senior engineer incapable de travailler sur AWS est de moins en moins employable.

---

## MODULE 31 — SRE & Fiabilité (Site Reliability Engineering)

> Passer de sysadmin réactif à ingénieur qui construit des systèmes fiables par design.

### Ce que tu vas apprendre :
- **SLI / SLO / SLA** : définir et mesurer la fiabilité d'un service
- **Error budget** : tolérance aux pannes, gel des déploiements
- **Toil** : identifier et réduire le travail répétitif
- **Capacity planning** : prévoir les ressources avant la saturation
- **Chaos engineering** : tester la résilience en simulant des pannes intentionnelles
- **On-call** : rotation, escalade, blameless post-mortems
- **Dashboard de fiabilité** : golden signals (latence, trafic, erreurs, saturation)

### Pourquoi c'est important :
Le titre "Senior Systems Engineer" se rapproche de "SRE" dans les entreprises tech. Comprendre les pratiques SRE transforme la façon dont tu conçois et opères des systèmes.

---

## MODULE 32 — Compliance & Audit

> Les environnements réglementés (santé, finance, gouvernement) imposent des standards stricts.

### Ce que tu vas apprendre :
- **CIS Benchmark** : référentiel de durcissement pour RHEL, appliquer les recommandations
- **OpenSCAP** : scanner de conformité automatisé, générer des rapports HTML
- **auditd** : journaliser les accès fichiers, les commandes root, les connexions
- **GDPR / PCI-DSS** : comprendre les exigences techniques des réglementations
- **Séparation des rôles** : sudo granulaire, comptes de service, least privilege
- **Gestion des patches** : politique de mise à jour, CVE tracking, dnf-automatic
- **Rapport de conformité** : produire un rapport auditable pour une DSI ou un auditeur

### Pourquoi c'est important :
De plus en plus d'entreprises sont soumises à des audits de sécurité. Un ingénieur qui parle le langage de la conformité vaut beaucoup plus qu'un ingénieur purement technique.

---

## Résumé de progression

| Module | Statut | Compétences clés |
|---|---|---|
| 01 | Linux Fundamentals | ✅ | users, permissions, systemd, logs, réseau |
| 02 | Nginx | ✅ | install, vhost, SELinux, HTTPS, logs |
| 03 | MariaDB | ✅ | install, SQL, backup, Bash, cron |
| 04 | Monitoring | ✅ | Prometheus, Grafana, Node Exporter |
| 05 | Bash avancé | ⏸ | fonctions, parsing, args, déploiement |
| 06 | Linux Internals | ✅ | LVM, mémoire, processus, kernel |
| 07 | Haute disponibilité | ⬜ | load balancing, replication, failover |
| 08 | Ansible | ⬜ | playbooks, roles, IaC |
| 09 | Sécurité système | ⬜ | hardening, Fail2ban, Let's Encrypt |
| 10 | Gestion d'incidents | ⬜ | diagnostic, post-mortem, runbooks |
| 11 | Docker | ⬜ | conteneurs, compose, sécurité |
| 12 | Kubernetes | ⬜ | pods, deployments, Helm, monitoring |
| 13 | Terraform | ⬜ | IaC, provisioning, modules |
| 14 | Observabilité (ELK/Loki) | ⬜ | logs centralisés, alerting, tracing |
| 15 | PHP-FPM (LEMP complet) | ⬜ | PHP-FPM, WordPress/Laravel, OpCache |
| 16 | Backup & Disaster Recovery | ⬜ | rsync, snapshots, RTO/RPO |
| 17 | CI/CD et Git avancé | ⬜ | GitHub Actions, blue/green, GitFlow |
| 18 | Réseau avancé | ⬜ | tcpdump, nftables, VLANs, bonding |
| 19 | DNS & Mail | ⬜ | BIND, Unbound, Postfix, DKIM, SPF |
| 20 | VPN & Accès sécurisé | ⬜ | WireGuard, SSH avancé, bastion, 2FA |
| 21 | HAProxy & Reverse Proxy | ⬜ | frontend/backend, ACL, SSL termination |
| 22 | Redis & Caching | ⬜ | cache, Sentinel, Cluster, monitoring |
| 23 | PostgreSQL | ⬜ | SQL avancé, réplication, PgBouncer |
| 24 | Stockage avancé | ⬜ | NFS, Samba, MinIO, RAID, quotas |
| 25 | Base de données HA avancée | ⬜ | Galera, ProxySQL, XtraBackup |
| 26 | Virtualisation KVM | ⬜ | libvirt, virsh, cloud-init, migration |
| 27 | HashiCorp Vault | ⬜ | secrets, PKI, credentials dynamiques |
| 28 | GitOps (ArgoCD/Flux) | ⬜ | déploiement déclaratif, drift detection |
| 29 | Python pour SysAdmin | ⬜ | scripts, APIs, Fabric, rapports |
| 30 | Cloud AWS/GCP | ⬜ | EC2, S3, IAM, VPC, Terraform+Cloud |
| 31 | SRE & Fiabilité | ⬜ | SLI/SLO, error budget, chaos, on-call |
| 32 | Compliance & Audit | ⬜ | CIS, OpenSCAP, auditd, GDPR, patches |
