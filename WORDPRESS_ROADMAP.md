# Roadmap WordPress & WooCommerce — Objectif Automattic

Parcours pratique pour maîtriser WordPress et WooCommerce en profondeur.
Chaque projet est hands-on sur le serveur RHEL réel.

---

## Pourquoi ce roadmap ?

Automattic (WordPress.com, WooCommerce) cherche des Happiness Engineers capables de :
- Déployer et configurer WordPress
- Diagnostiquer des problèmes techniques complexes
- Comprendre WooCommerce en profondeur
- Optimiser les performances

Ce roadmap te donne cette expérience.

---

## PHASE 1 — Déploiement et configuration

### PROJET WP-01 — wordpress-deployer ✅
> Installer WordPress automatiquement avec un script Bash

- PHP-FPM : installation, configuration des pools, socket Unix
- Nginx + PHP-FPM : passer les requêtes `.php` à PHP-FPM
- MariaDB : créer une base de données et un utilisateur pour WordPress
- WordPress : téléchargement, extraction, wp-config.php automatisé
- Permissions : régler `chown` et `chmod` pour que WordPress fonctionne

**Livrable :** Script `deploy-wordpress.sh` qui installe WordPress en une commande

---

### PROJET WP-02 — wp-cli-toolkit ✅
> Gérer WordPress depuis la ligne de commande avec WP-CLI

- Installer WP-CLI sur RHEL
- Gestion des plugins : install, activate, deactivate, update, delete
- Gestion des thèmes : install, activate, update
- Gestion des utilisateurs : create, update, delete, list
- Gestion du contenu : créer des posts, pages, catégories en CLI
- Mises à jour : mettre à jour WordPress core, plugins, thèmes en masse
- Base de données : search-replace, export, import, optimize

**Livrable :** Cheat sheet WP-CLI + script de maintenance automatisée

---

### PROJET WP-03 — wordpress-multisite ✅
> Héberger plusieurs sites WordPress sur une seule installation

- Activer WordPress Multisite (subdomain vs subdirectory)
- Configurer Nginx pour le multisite
- Créer et gérer plusieurs sous-sites depuis le Network Admin
- Plugins réseau vs plugins site : comprendre la différence
- Thèmes réseau

**Livrable :** Réseau multisite fonctionnel avec 3 sous-sites

---

## PHASE 2 — Sécurité WordPress

### PROJET WP-04 — wordpress-hardening ✅
> Sécuriser WordPress selon les bonnes pratiques

- Permissions de fichiers : wp-content, wp-config.php, uploads
- Désactiver l'édition de fichiers depuis l'admin
- Masquer la version WordPress
- Protéger wp-login.php : limiter l'accès par IP, 2FA
- Désactiver XML-RPC si non utilisé
- Headers de sécurité dans Nginx : X-Frame-Options, CSP, HSTS
- Fail2ban : bloquer les attaques brute force sur wp-login.php
- Scanner de malware : installer et utiliser Wordfence CLI

**Livrable :** Script `harden-wordpress.sh` + documentation des protections

---

### PROJET WP-05 — wordpress-backup ⬜
> Système de backup complet pour WordPress

- Backup des fichiers : wp-content (uploads, plugins, thèmes)
- Backup de la base de données : mysqldump ciblé
- Backup combiné : fichiers + DB dans une archive datée
- Restauration : script de restore depuis un backup
- Test de restauration : vérifier que le backup fonctionne
- Rétention : garder 7 jours, supprimer les anciens

**Livrable :** Script `wp-backup.sh` + script `wp-restore.sh` + cron nightly

---

## PHASE 3 — Performance WordPress

### PROJET WP-06 — wordpress-performance ⬜
> Optimiser les performances d'un site WordPress

- OpCache PHP : activer et configurer le cache d'opcodes
- FastCGI Cache Nginx : cache des pages WordPress au niveau Nginx
- Cache headers : contrôler le cache navigateur pour les assets
- Compression gzip/brotli dans Nginx
- Images : optimiser les images uploadées (ImageMagick, cwebp)
- Base de données : optimiser les tables, supprimer les révisions inutiles
- Mesurer : avant/après avec `ab` (Apache Bench) ou `wrk`

**Livrable :** Guide de performance WordPress + résultats de benchmarks

---

### PROJET WP-07 — wordpress-ssl ⬜
> HTTPS avec Let's Encrypt pour WordPress

- Installer Certbot sur RHEL
- Générer un certificat SSL pour le domaine WordPress
- Configurer Nginx pour HTTPS + redirection HTTP → HTTPS
- Renouvellement automatique : cron + hook post-renewal
- WordPress en HTTPS : mettre à jour siteurl et home dans la DB
- HSTS : activer Strict Transport Security

**Livrable :** Site WordPress accessible en HTTPS avec certificat auto-renouvelé

---

## PHASE 4 — WooCommerce

### PROJET WC-01 — woocommerce-setup ⬜
> Installer et configurer WooCommerce de A à Z

- Installer WooCommerce via WP-CLI
- Configuration : devise, pays, taxes, livraison
- Créer des produits : simple, variable, téléchargeable, virtuel
- Configurer les méthodes de paiement : Stripe (mode test), PayPal Sandbox
- Configurer les emails de commande
- Pages WooCommerce : shop, cart, checkout, my-account
- Tester le parcours complet : ajout au panier → checkout → confirmation

**Livrable :** Boutique WooCommerce fonctionnelle avec 5 produits et paiement de test

---

### PROJET WC-02 — woocommerce-products ⬜
> Import et gestion de produits en masse

- Format d'import CSV WooCommerce : colonnes requises
- Créer un fichier CSV de 20+ produits
- Importer via WP-CLI : `wp wc product import`
- Catégories et attributs : gérer en masse
- Variations : taille, couleur, stock par variation
- Images produit : upload en masse, association aux produits
- Export : sauvegarder le catalogue produits en CSV

**Livrable :** Script d'import de catalogue + fichier CSV de démonstration

---

### PROJET WC-03 — woocommerce-backup ⬜
> Backup spécifique WooCommerce : commandes, produits, clients

- Exporter les commandes WooCommerce en CSV (via WP-CLI)
- Exporter les produits
- Exporter les clients
- Sauvegarder les clés API et configurations WooCommerce
- Script de backup dédié WooCommerce avec rétention
- Restauration : importer les données depuis les exports

**Livrable :** Script `wc-backup.sh` qui sauvegarde les données business critiques

---

### PROJET WC-04 — woocommerce-performance ⬜
> Optimiser les performances d'une boutique WooCommerce

- WooCommerce est plus lourd que WordPress seul — comprendre pourquoi
- Désactiver les fonctionnalités WooCommerce inutilisées
- Cache : configurer les exceptions de cache pour cart/checkout
- Base de données : nettoyer les tables WooCommerce (sessions, logs)
- Index MySQL : ajouter des index pour les requêtes WooCommerce fréquentes
- Lazy loading des scripts WooCommerce
- Mesurer : temps de chargement shop, product, checkout

**Livrable :** Guide d'optimisation WooCommerce avec métriques avant/après

---

### PROJET WC-05 — woocommerce-troubleshooting ⬜
> Diagnostiquer et résoudre des problèmes WooCommerce courants

Scénarios réels à reproduire et résoudre :
1. Checkout qui ne se soumet pas (JS conflict)
2. Emails de commande qui n'arrivent pas (SMTP config)
3. Stock qui ne se décrémente pas
4. Page shop qui retourne 404 après migration
5. Lenteur sur la page checkout
6. Erreur 500 après mise à jour de plugin

**Livrable :** Runbook de troubleshooting WooCommerce — symptôme → diagnostic → solution

---

## PHASE 5 — WordPress en production

### PROJET WP-08 — wordpress-monitoring ⬜
> Monitorer un site WordPress avec Prometheus + Grafana

- Installer le plugin WordPress Prometheus Exporter
- Métriques : nombre de posts, utilisateurs, commentaires, requêtes DB
- Grafana dashboard dédié WordPress
- Alertes : site down, temps de réponse élevé, erreurs PHP

**Livrable :** Dashboard Grafana WordPress fonctionnel avec alertes

---

### PROJET WP-09 — wordpress-docker ⬜
> WordPress dans des conteneurs Docker

- Dockerfile WordPress custom
- docker-compose.yml : WordPress + MariaDB + Nginx
- Volumes : persister wp-content et la base de données
- Variables d'environnement : configurer WordPress sans toucher wp-config.php
- WooCommerce dans Docker

**Livrable :** Stack WordPress complète en Docker Compose — `docker-compose up` suffit

---

### PROJET WP-10 — wordpress-migration ⬜
> Migrer un site WordPress d'un serveur à un autre

- Export du site source : fichiers + base de données
- Transfert sécurisé : rsync + SSH
- Import sur le serveur destination
- Search-replace : mettre à jour les URLs en base de données (WP-CLI)
- Vérification post-migration : liens, images, plugins, formulaires
- Redirection DNS : basculer le trafic vers le nouveau serveur

**Livrable :** Script de migration + checklist de vérification post-migration

---

## PHASE 6 — Écosystème Automattic

### PROJET A-01 — wordpress-com-explorer ⬜
> Maîtriser WordPress.com — la plateforme principale d'Automattic

- Créer un compte WordPress.com et configurer un site complet
- Explorer toutes les fonctionnalités : éditeur, thèmes, domaines, stats
- Documenter les différences entre WordPress.com et self-hosted (hosting, plugins, accès FTP, wp-config)
- Tester les plans : Free, Personal, Business — ce que chaque plan permet
- Connecter un domaine custom à WordPress.com

**Livrable :** Site live sur WordPress.com + article comparatif WordPress.com vs self-hosted

---

### PROJET A-02 — wordpress-rest-api ⬜
> Interagir avec WordPress via l'API REST

- Comprendre l'architecture REST : endpoints, méthodes HTTP, authentification
- Lire des posts, créer des pages, gérer des utilisateurs via curl
- Authentification : Application Passwords (WordPress 5.6+)
- Script Python qui crée des articles WordPress automatiquement
- Script Bash qui exporte tous les posts en JSON via l'API

**Livrable :** Scripts curl + Python + Bash — repo public avec exemples documentés

---

### PROJET A-03 — gutenberg-blocks ⬜
> Maîtriser l'éditeur Gutenberg et créer un bloc custom

- Explorer tous les blocs natifs : paragraphe, image, galerie, groupe, colonnes, query loop
- Créer un bloc custom simple en PHP (bloc statique sans JavaScript)
- Full Site Editing (FSE) : éditer header, footer, templates depuis l'éditeur
- Comprendre la différence entre blocs et shortcodes (ancien système)
- Tester la compatibilité thème classique vs thème blocs

**Livrable :** Plugin avec 1 bloc custom + tutoriel FSE documenté

---

### PROJET A-04 — jetpack-complete ⬜
> Maîtriser Jetpack — le plugin flagship d'Automattic

- Installer Jetpack et connecter au compte WordPress.com
- Jetpack Backup : configurer, déclencher un backup manuel, tester une restauration
- Jetpack Security : activer le scan malware, la protection brute force, WAF
- Jetpack Performance : CDN images, lazy load, concaténation CSS/JS
- Jetpack Stats : analyser le trafic, comparer avec Google Analytics
- Jetpack Social : autopublier sur les réseaux sociaux

**Livrable :** Site WordPress avec Jetpack complet configuré + rapport de chaque fonctionnalité testée

---

### PROJET A-05 — akismet-spam ⬜
> Comprendre et configurer Akismet — protection anti-spam d'Automattic

- Installer Akismet et obtenir une clé API WordPress.com
- Comprendre le scoring spam : comment Akismet décide qu'un commentaire est spam
- Tester avec de faux commentaires spam
- Configurer les seuils : tenir en attente vs rejeter automatiquement
- Analyser les faux positifs : récupérer un commentaire légitime marqué spam

**Livrable :** Site configuré + documentation du processus de scoring Akismet

---

## PHASE 7 — WooCommerce Avancé

### PROJET A-06 — woocommerce-payments ⬜
> Configurer les paiements WooCommerce de A à Z

- Stripe en mode test : créer un compte, configurer les webhooks, tester un paiement
- PayPal Sandbox : créer des comptes test acheteur/vendeur, simuler un achat
- WooCommerce Payments (plugin officiel Automattic) : installer et tester
- Gérer les remboursements : total et partiel
- Tester les échecs de paiement : carte déclinée, fonds insuffisants
- Logs de paiement : où les trouver, comment les lire

**Livrable :** Boutique avec 3 passerelles de paiement configurées + runbook de troubleshooting paiements

---

### PROJET A-07 — woocommerce-subscriptions ⬜
> Produits récurrents — abonnements mensuels et annuels

- Installer WooCommerce Subscriptions
- Créer des produits avec abonnement mensuel et annuel
- Gérer le cycle de vie : activation → renouvellement → annulation → réactivation
- Tester les échecs de renouvellement automatique
- Emails automatiques : rappel de renouvellement, confirmation d'annulation
- Rapports : MRR, ARR, churn rate

**Livrable :** Boutique avec 3 produits en abonnement + documentation du cycle de vie complet

---

### PROJET A-08 — woocommerce-multisite ⬜
> Réseau WooCommerce sur WordPress Multisite

- Activer WooCommerce sur un réseau Multisite existant (WP-03)
- Configurer WooCommerce par sous-site : chaque site a sa propre boutique
- Produits partagés vs produits par site
- Gestion des stocks sur un réseau multi-boutiques
- Troubleshooting Multisite + WooCommerce : conflits courants

**Livrable :** Réseau Multisite avec 2 boutiques WooCommerce indépendantes

---

## PHASE 8 — Debugging & Troubleshooting WordPress

### PROJET A-09 — wordpress-debug ⬜
> Maîtriser le debugging WordPress comme un Happiness Engineer

- Activer WP_DEBUG, WP_DEBUG_LOG, WP_DEBUG_DISPLAY dans wp-config.php
- Installer Query Monitor : analyser les requêtes SQL lentes, les hooks, les erreurs PHP
- Lire les logs PHP-FPM et Nginx pour diagnostiquer une erreur 500
- Identifier un conflit de plugins : méthode de désactivation par bisection
- Health Check & Troubleshooting plugin officiel WordPress
- Mode maintenance : activer manuellement avec fichier `.maintenance`

**Livrable :** Runbook de debugging WordPress — 10 scénarios avec méthode et solution

---

### PROJET A-10 — wordpress-errors ⬜
> Reproduire et résoudre les 10 erreurs WordPress les plus courantes

Scénarios à reproduire et résoudre :
1. White Screen of Death (WSOD) — erreur PHP fatale
2. Error 500 — permission ou plugin
3. Error 404 sur les articles — permaliens cassés
4. "Sorry, you are not allowed to access this page" — rôles utilisateurs
5. Boucle de redirection infinie — siteurl/home mal configuré
6. Images qui ne s'affichent pas après migration
7. Mise à jour WordPress qui échoue — espace disque ou permissions
8. Plugin qui casse le site après activation
9. Emails WordPress qui n'arrivent pas — wp_mail et SMTP
10. Base de données corrompue — réparation via wp-config.php

**Livrable :** Repo GitHub avec scripts de reproduction + solutions documentées pour chaque erreur

---

### PROJET A-11 — wordpress-email ⬜
> Configurer et déboguer les emails WordPress

- Comprendre wp_mail() et comment WordPress envoie les emails
- Configurer WP Mail SMTP avec un vrai service (SendGrid ou Mailgun)
- Tester la délivrabilité : SPF, DKIM, DMARC pour le domaine WordPress
- WooCommerce emails : personnaliser les templates HTML
- Déboguer les emails manquants : logs SMTP, test avec Email Log plugin
- Configurer les emails de notification admin, client, WooCommerce

**Livrable :** WordPress avec emails SMTP configurés + templates WooCommerce personnalisés

---

### PROJET A-12 — wordpress-staging ⬜
> Environnement de staging professionnel

- Créer un environnement staging sur le même serveur (sous-domaine ou dossier)
- Synchroniser staging → production : fichiers + base de données
- WP-CLI search-replace pour les URLs
- Plugin WP Staging : automatiser la création de staging
- Workflow : développer en staging, tester, pousser en production
- Protéger le staging avec authentification HTTP de base

**Livrable :** Script de déploiement staging → production + documentation du workflow

---

## Récapitulatif

| # | Projet | Phase | Statut |
|---|--------|-------|--------|
| WP-01 | wordpress-deployer | Déploiement | ✅ |
| WP-02 | wp-cli-toolkit | Déploiement | ✅ |
| WP-03 | wordpress-multisite | Déploiement | ✅ |
| WP-04 | wordpress-hardening | Sécurité | ✅ |
| WP-05 | wordpress-backup | Sécurité | ⬜ |
| WP-06 | wordpress-performance | Performance | ⬜ |
| WP-07 | wordpress-ssl | Performance | ⬜ |
| WC-01 | woocommerce-setup | WooCommerce | ⬜ |
| WC-02 | woocommerce-products | WooCommerce | ⬜ |
| WC-03 | woocommerce-backup | WooCommerce | ⬜ |
| WC-04 | woocommerce-performance | WooCommerce | ⬜ |
| WC-05 | woocommerce-troubleshooting | WooCommerce | ⬜ |
| WP-08 | wordpress-monitoring | Production | ⬜ |
| WP-09 | wordpress-docker | Production | ⬜ |
| WP-10 | wordpress-migration | Production | ⬜ |
| A-01 | wordpress-com-explorer | Automattic | ⬜ |
| A-02 | wordpress-rest-api | Automattic | ⬜ |
| A-03 | gutenberg-blocks | Automattic | ⬜ |
| A-04 | jetpack-complete | Automattic | ⬜ |
| A-05 | akismet-spam | Automattic | ⬜ |
| A-06 | woocommerce-payments | WooCommerce Avancé | ⬜ |
| A-07 | woocommerce-subscriptions | WooCommerce Avancé | ⬜ |
| A-08 | woocommerce-multisite | WooCommerce Avancé | ⬜ |
| A-09 | wordpress-debug | Debugging | ⬜ |
| A-10 | wordpress-errors | Debugging | ⬜ |
| A-11 | wordpress-email | Debugging | ⬜ |
| A-12 | wordpress-staging | Debugging | ⬜ |

**27 projets · 8 phases · De zéro à Happiness Engineer Automattic**

---

## Ce que ce roadmap prouve à Automattic

| Compétence demandée | Projet qui le prouve |
|--------------------|---------------------|
| WordPress hands-on | WP-01 à WP-07 |
| WordPress.com experience | A-01 |
| WooCommerce experience | WC-01 à WC-05, A-06 à A-08 |
| Jetpack (produit Automattic) | A-04 |
| Akismet (produit Automattic) | A-05 |
| REST API | A-02 |
| Gutenberg/FSE | A-03 |
| Troubleshooting technique | A-09, A-10, WC-05 |
| Performance & optimisation | WP-06, WC-04 |
| Backup & recovery | WP-05, WC-03, A-04 |
| Email & délivrabilité | A-11 |
| Infrastructure moderne | WP-09 (Docker) |
| Migration | WP-10, A-12 |
| CLI & automatisation | WP-02 (WP-CLI) |
| AI fluency | Claude Code sur tous les projets |
