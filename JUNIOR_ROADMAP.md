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

### MODULE 03 — Bash scripting ✅ COMPLÉTÉ

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

### MODULE 04 — Réseau fondamental ✅ COMPLÉTÉ

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

### MODULE 08 — PHP-FPM — Stack LEMP complète ✅ COMPLÉTÉ

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

## CI/CD & INFRASTRUCTURE AS CODE — Les outils modernes

### MODULE 22 — CI/CD (GitHub Actions / GitLab CI)

> Automatiser les tests et déploiements — compétence devenue incontournable en 2026.

**Ce que tu vas apprendre :**
- Concepts CI/CD : pipeline, stage, job, artifact, runner
- GitHub Actions : workflow YAML, triggers, jobs, steps
- Tester automatiquement un script Bash à chaque push
- Déployer automatiquement sur ton serveur RHEL via SSH
- Notifications en cas d'échec de pipeline
- GitLab CI : `.gitlab-ci.yml`, runners, stages

**Projet :** Pipeline GitHub Actions qui teste et déploie un script sur ton serveur RHEL automatiquement

**Pourquoi c'est important :**
CI/CD apparaît dans la quasi-totalité des offres Junior en 2026. Ton blog utilise déjà GitHub Actions sans que tu l'aies configuré toi-même — il est temps de comprendre et maîtriser ce mécanisme.

---

### MODULE 23 — Python pour SysAdmin

> Le deuxième langage incontournable après Bash — de plus en plus exigé.

**Ce que tu vas apprendre :**
- Syntaxe Python : variables, conditions, boucles, fonctions
- Fichiers : lire, écrire, parser (JSON, YAML, CSV)
- Modules utiles : `os`, `subprocess`, `paramiko` (SSH), `requests` (HTTP)
- Réécrire un script Bash en Python : comparer les deux approches
- Automatisation : interagir avec des APIs REST depuis Python
- Gestion d'erreurs : try/except

**Projet :** Script Python de health check qui interroge l'API Prometheus et envoie une alerte si un service est down

**Pourquoi c'est important :**
Bash est parfait pour les tâches système simples. Python est requis dès que la logique devient complexe — parsing de JSON, appels API, manipulation de données. La plupart des outils DevOps modernes (Ansible, Terraform) s'intègrent via Python.

---

### MODULE 24 — Kubernetes Basics

> L'orchestrateur de conteneurs standard — présent dans toutes les offres DevOps/SysAdmin modernes.

**Ce que tu vas apprendre :**
- Architecture Kubernetes : cluster, node, pod, service, deployment
- kubectl : commandes essentielles (get, describe, logs, exec, apply)
- Manifests YAML : décrire un déploiement et un service
- Namespaces : isoler les environnements
- ConfigMaps et Secrets : gérer la configuration
- Différence entre Docker Compose (local) et Kubernetes (production)
- Minikube : cluster Kubernetes local pour pratiquer

**Projet :** Déployer WordPress + MariaDB sur Minikube avec des manifests YAML

**Pourquoi c'est important :**
Docker sans Kubernetes c'est comme savoir construire une voiture mais ne pas savoir conduire sur autoroute. Kubernetes est le standard de déploiement en production — même les offres Junior commencent à le mentionner.

---

### MODULE 25 — Terraform (Infrastructure as Code)

> Décrire l'infrastructure comme du code — reproductible, versionné, auditable.

**Ce que tu vas apprendre :**
- Concepts IaC : idempotence, état (state), plan vs apply
- HCL : syntaxe Terraform (resources, variables, outputs, modules)
- Provider AWS : créer une EC2, un VPC, un Security Group en code
- `terraform init`, `plan`, `apply`, `destroy`
- State : comprendre le fichier `.tfstate`
- Modules : réutiliser du code Terraform
- Versionner l'infrastructure avec Git

**Projet :** Provisionner un serveur RHEL sur AWS avec Terraform — VPC, Security Group, EC2, Elastic IP

**Pourquoi c'est important :**
Les entreprises ne créent plus d'infrastructure à la main. Terraform est l'outil IaC le plus demandé en 2026. Même un Junior qui connaît Terraform de base se distingue fortement des autres candidats.

---

## RÉSEAU AVANCÉ & SÉCURITÉ — Compétences manquantes très demandées

### MODULE 26 — VPN & Réseau Avancé

> WireGuard et OpenVPN apparaissent dans de nombreuses offres Junior en 2026.

**Ce que tu vas apprendre :**
- VPN : concepts (tunnel, chiffrement, authentification)
- WireGuard : configuration serveur et client, clés publiques/privées
- OpenVPN : configuration avec certificats, MFA
- iptables : règles de filtrage avancées, NAT, MASQUERADE
- Analyse réseau : tcpdump, Wireshark (captures de base)
- NFS : partager des dossiers entre serveurs Linux
- SMB/CIFS : partage de fichiers avec Windows (Samba)

**Projet :** Serveur WireGuard VPN sur RHEL + partage NFS entre deux machines

**Pourquoi c'est important :**
Les entreprises utilisent des VPN pour connecter les télé-travailleurs et les sites distants. NFS/SMB sont les protocoles de partage de fichiers standard en entreprise.

---

### MODULE 27 — ITIL & Gestion des Incidents

> Très demandé dans les offres françaises — surtout les ESN (ex-SSII).

**Ce que tu vas apprendre :**
- ITIL v4 : framework de gestion des services IT
- Incident vs Problem vs Change : les 3 processus clés
- Ticketing : GLPI (open source, standard français), ServiceNow (enterprise)
- SLA : définir et respecter les niveaux de service
- Escalade : quand et comment escalader un incident
- Post-mortem : rédiger un rapport d'incident structuré
- CMDB : inventaire des actifs IT

**Projet :** Installer et configurer GLPI sur RHEL — créer des tickets, gérer des assets, configurer des SLA

**Pourquoi c'est important :**
En France, les offres d'administrateur système mentionnent ITIL et GLPI/ServiceNow dans 60%+ des cas. Sans ces notions, tu rates un filtre automatique ATS.

---

### MODULE 28 — Microsoft Azure

> Plus demandé qu'AWS en Europe et France spécifiquement.

**Ce que tu vas apprendre :**
- Azure vs AWS : différences, équivalences de services
- Azure Core : Virtual Machines, Storage Account, Virtual Network, NSG
- Azure Active Directory : gestion des identités cloud
- Azure CLI : gérer les ressources depuis le terminal
- Microsoft 365 : bases de l'administration (Exchange, Teams, SharePoint)
- Intune : gestion des postes de travail (MDM)
- Certification AZ-104 : Azure Administrator Associate

**Projet :** Déployer une VM RHEL sur Azure avec Azure CLI + configurer les règles réseau

**Pourquoi c'est important :**
En France et en Europe, Azure domine le marché enterprise (Microsoft 365 est omniprésent). Les offres Junior mentionnent Azure 2x plus souvent qu'AWS dans le secteur privé français.

---

### MODULE 29 — PowerShell pour SysAdmin

> Incontournable dans les environnements mixtes Linux/Windows.

**Ce que tu vas apprendre :**
- Syntaxe PowerShell : cmdlets, pipeline, variables, boucles, fonctions
- Gestion Active Directory via PowerShell : créer/modifier/supprimer des users en masse
- Gestion Microsoft 365 via PowerShell (Exchange Online, Azure AD)
- Scripts d'administration : rapports, exports CSV, automatisation de tâches Windows
- Comparaison Bash vs PowerShell : même logique, syntaxe différente
- PowerShell remoting : exécuter des commandes sur des machines distantes

**Projet :** Script PowerShell de création en masse d'utilisateurs Active Directory depuis un fichier CSV

**Pourquoi c'est important :**
90% des entreprises ont un Active Directory. Un Junior Linux qui peut aussi scripter en PowerShell est immédiatement plus utile dans un environnement mixte.

---

### MODULE 30 — Stockage & NAS

> Compétence pratique demandée dans les offres de gestion d'infrastructure.

**Ce que tu vas apprendre :**
- RAID : niveaux 0, 1, 5, 10 — avantages et cas d'usage
- LVM avancé : thin provisioning, snapshots, VGs multiples
- NAS : protocoles NFS v3/v4, SMB/CIFS, gestion des permissions
- Samba : configurer un partage Samba sur RHEL accessible depuis Windows
- iSCSI : stockage bloc en réseau
- S.M.A.R.T. : surveiller la santé des disques
- Quotas : limiter l'espace disque par utilisateur/groupe

**Projet :** Serveur NAS RHEL avec partages NFS (Linux) et Samba (Windows) + monitoring S.M.A.R.T.

**Pourquoi c'est important :**
La gestion du stockage est une tâche quotidienne en entreprise. Disque plein = service down. Connaître RAID, LVM et les protocoles de partage est attendu dès le niveau Junior.

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

### MODULE 32 — HAProxy & Haute Disponibilité

> Le load balancer open source le plus utilisé en production Linux.

**Ce que tu vas apprendre :**
- HAProxy : concepts frontend/backend, algorithmes de load balancing (round-robin, least-conn, ip-hash)
- Health checks : détecter et exclure automatiquement un serveur down
- SSL termination : déchiffrer HTTPS au niveau du load balancer
- ACLs HAProxy : router le trafic selon l'URL, le host header, les IPs
- Stats page : monitorer les connexions en temps réel
- Keepalived : VIP (Virtual IP) pour la haute disponibilité du load balancer lui-même
- Pacemaker/Corosync : cluster HA pour les services critiques

**Projet :** HAProxy + 2 serveurs Nginx en backend + Keepalived pour VIP — zéro interruption si un serveur tombe

**Pourquoi c'est important :**
En production, aucun service critique ne tourne sur un seul serveur. HAProxy est le standard open source pour distribuer le trafic. Connaître la HA est ce qui distingue un Junior prêt pour la prod.

---

### MODULE 33 — PKI & Gestion des Certificats

> OpenSSL, Let's Encrypt, et la chaîne de confiance SSL/TLS.

**Ce que tu vas apprendre :**
- PKI : Public Key Infrastructure, autorités de certification (CA), chaîne de confiance
- OpenSSL : générer des clés, créer des CSR, signer des certificats, inspecter des certs
- Certificats auto-signés : créer une CA interne pour les services internes
- Let's Encrypt : automatiser le renouvellement avec Certbot (cron + hook)
- Wildcard certificates : couvrir tous les sous-domaines
- Troubleshooting TLS : certificat expiré, chaîne incomplète, CN mismatch
- HSTS : Strict Transport Security

**Projet :** CA interne avec OpenSSL + certificats pour tous les services internes + Let's Encrypt sur le site public

**Pourquoi c'est important :**
Les certificats expirés causent des incidents en production. Un Junior qui sait gérer le cycle de vie des certs (création → déploiement → renouvellement automatique) est immédiatement opérationnel.

---

### MODULE 34 — Serveur Email (Postfix)

> Le service que toute infrastructure doit avoir — et que beaucoup de juniors ne maîtrisent pas.

**Ce que tu vas apprendre :**
- Architecture email : MTA (Postfix), MDA (Dovecot), MUA (client)
- Postfix : installation, configuration SMTP, relais, alias
- DNS email : enregistrements MX, SPF, DKIM, DMARC
- OpenDKIM : signer les emails pour éviter le spam
- TLS : chiffrement des connexions SMTP
- Logs email : `/var/log/maillog` — diagnostiquer un email non reçu
- Monitoring : alertes Prometheus sur la file de mails

**Projet :** Serveur mail Postfix sur RHEL avec SPF/DKIM/DMARC + monitoring de la file

**Pourquoi c'est important :**
Chaque application serveur envoie des emails (alertes, confirmations, notifications). Savoir configurer et déboguer Postfix est une compétence quotidienne en entreprise.

---

### MODULE 35 — Vulnerability Scanning & Patch Management

> Identifier et corriger les failles avant qu'elles soient exploitées.

**Ce que tu vas apprendre :**
- Vulnerability scanning : concepts, CVE, CVSS scores
- OpenVAS/Greenbone : scanner open source, lancer un scan, interpréter les résultats
- Patch management Linux : `dnf check-update`, `dnf update`, automatisation
- WSUS : gestion des patches Windows en entreprise
- OpenSCAP : audit de conformité RHEL (CIS Benchmark, STIG)
- Suivi des CVEs : abonnement aux bulletins de sécurité RHEL/Nginx/PHP
- Remédiation : prioriser et corriger les vulnérabilités critiques

**Projet :** Scan OpenVAS complet du serveur RHEL + rapport de remédiation + automatisation des patches via Ansible

**Pourquoi c'est important :**
La gestion des vulnérabilités est une responsabilité quotidienne en entreprise. Un Junior qui sait scanner, prioriser et corriger les failles est un atout sécurité immédiat.

---

### MODULE 36 — FreeIPA & LDAP

> Gestion centralisée des identités pour les environnements Linux enterprise.

**Ce que tu vas apprendre :**
- LDAP : protocole d'annuaire, arborescence DIT, entrées, attributs, schéma
- FreeIPA : solution intégrée LDAP + Kerberos + DNS + CA pour Linux
- Kerberos : authentification réseau par tickets (SSO pour Linux)
- Joindre un serveur RHEL à FreeIPA : `ipa-client-install`
- Gérer les utilisateurs et groupes centralement
- Sudo rules : définir qui peut exécuter quoi sur quels serveurs via FreeIPA
- HBAC (Host-Based Access Control) : qui peut se connecter où

**Projet :** Serveur FreeIPA + 2 clients RHEL joints au domaine + règles sudo centralisées

**Pourquoi c'est important :**
Dans les entreprises avec 10+ serveurs Linux, gérer les utilisateurs manuellement sur chaque machine est impossible. FreeIPA est l'équivalent Linux d'Active Directory.

---

### MODULE 37 — Performance Tuning Linux

> Optimiser le système d'exploitation pour les charges de travail production.

**Ce que tu vas apprendre :**
- sysctl : paramètres kernel — réseau (net.core, tcp), mémoire (vm.swappiness), fichiers (fs.file-max)
- tuned : profils de performance automatiques (throughput-performance, latency-performance)
- CPU : gouverneurs de fréquence, NUMA, isolcpus
- Mémoire : huge pages, OOM killer tuning, transparent huge pages
- I/O : schedulers de disque (deadline, noop, cfq), iostat, fio benchmarks
- Réseau : buffer sizes, TCP window scaling, offloading
- Profiling : perf, sar, iotop — identifier les goulots d'étranglement

**Projet :** Audit de performance complet du serveur RHEL + rapport avant/après tuning avec métriques

**Pourquoi c'est important :**
Un Junior qui peut diagnostiquer un serveur lent (CPU saturé ? RAM insuffisante ? I/O bloquant ?) et l'optimiser sans ajouter du hardware est immédiatement précieux en production.

---

### MODULE 31 — CompTIA Network+ & Security+

> Les deux certifications les plus demandées par les employeurs en 2026 après RHCSA.

**CompTIA Network+ (N10-009)**
- Modèle OSI, TCP/IP, subnetting
- Protocoles réseau : DNS, DHCP, HTTP, SMTP, FTP, SSH
- Topologies réseau, VLANs, routage
- Dépannage réseau : méthodologie, outils
- Sécurité réseau : firewalls, VPN, IDS/IPS

**CompTIA Security+ (SY0-701)**
- Menaces et attaques : malware, phishing, ransomware, SQL injection
- Cryptographie : chiffrement symétrique/asymétrique, PKI, certificats TLS
- Gestion des identités : MFA, SSO, OAuth, LDAP
- Sécurité réseau : segmentation, DMZ, honeypot
- Réponse aux incidents : forensics, logs, SIEM

**Valeur marché :**
- Security+ est demandé dans ~40% des offres Junior SysAdmin en 2026
- Network+ valide les bases réseau — complémentaire au Module 04
- Reconnues mondialement, contrairement à des certifications vendeur

---

## Résumé de progression

| # | Module | Statut | Compétences clés |
|---|--------|--------|-----------------|
| 01 | Linux Fundamentals | ✅ | users, permissions, systemd, logs |
| 02 | Linux System avancé | ✅ | LVM, mémoire, processus, performance |
| 03 | Bash Scripting | ✅ | variables, boucles, fonctions, cron |
| 04 | Réseau Fondamental | ✅ | IP, DNS, DHCP, TCP, firewalld, ss, tcpdump, traceroute |
| 05 | DNS & DHCP | ⬜ | BIND, Unbound, enregistrements |
| 06 | Nginx | ✅ | vhost, SSL, reverse proxy |
| 07 | MariaDB | ✅ | SQL, backup, scripting |
| 08 | PHP-FPM / LEMP | ✅ | WordPress, PHP-FPM, OpCache |
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
| 22 | CI/CD | ⬜ | GitHub Actions, GitLab CI, pipelines, déploiement automatique |
| 23 | Python SysAdmin | ⬜ | scripts Python, APIs, paramiko, subprocess |
| 24 | Kubernetes Basics | ⬜ | pods, deployments, kubectl, Minikube |
| 25 | Terraform | ⬜ | IaC, HCL, AWS provider, state |
| 26 | VPN & Réseau Avancé | ⬜ | WireGuard, OpenVPN, iptables, NFS, SMB |
| 27 | ITIL & Ticketing | ⬜ | GLPI, ServiceNow, incidents, SLA, CMDB |
| 28 | Microsoft Azure | ⬜ | VMs, Azure AD, CLI, Microsoft 365, AZ-104 |
| 29 | PowerShell | ⬜ | cmdlets, Active Directory, Microsoft 365, remoting |
| 30 | Stockage & NAS | ⬜ | RAID, NFS, Samba, iSCSI, S.M.A.R.T., quotas |
| 31 | CompTIA Network+ & Security+ | ⬜ | certifications réseau et sécurité reconnues mondialement |
| 32 | HAProxy & Haute Disponibilité | ⬜ | load balancing, health checks, Keepalived, VIP, Pacemaker |
| 33 | PKI & Certificats | ⬜ | OpenSSL, CA interne, Let's Encrypt, wildcard, TLS troubleshooting |
| 34 | Serveur Email Postfix | ⬜ | SMTP, SPF, DKIM, DMARC, TLS, logs mail |
| 35 | Vulnerability Scanning | ⬜ | OpenVAS, patch management, WSUS, OpenSCAP, CVE |
| 36 | FreeIPA & LDAP | ⬜ | annuaire LDAP, Kerberos, SSO Linux, sudo centralisé, HBAC |
| 37 | Performance Tuning | ⬜ | sysctl, tuned, CPU/RAM/I/O, profiling, benchmarks |

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
| Tu scriptes en Bash et Python | Modules 03 + 23 |
| Tu connais Docker et Kubernetes | Modules 15 + 24 |
| Tu fais du CI/CD | Module 22 |
| Tu gères les incidents | Module 17 |
| Tu fais de l'IaC avec Terraform | Module 25 |
| Tu as une certification | RHCSA |

Tu n'as pas besoin de tout finir pour postuler —
**Modules 01-04 + 06-07 + 11 + 13 + 14 + 15 + 22 + certification RHCSA** suffisent pour la plupart des offres Junior en 2026.

**Pour les offres françaises (ESN/DSI) ajouter :** Module 27 (ITIL/GLPI) + Module 28 (Azure) + Module 29 (PowerShell).
