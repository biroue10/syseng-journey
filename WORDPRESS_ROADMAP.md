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

### PROJET WP-01 — wordpress-deployer ⬜
> Installer WordPress automatiquement avec un script Bash

- PHP-FPM : installation, configuration des pools, socket Unix
- Nginx + PHP-FPM : passer les requêtes `.php` à PHP-FPM
- MariaDB : créer une base de données et un utilisateur pour WordPress
- WordPress : téléchargement, extraction, wp-config.php automatisé
- Permissions : régler `chown` et `chmod` pour que WordPress fonctionne

**Livrable :** Script `deploy-wordpress.sh` qui installe WordPress en une commande

---

### PROJET WP-02 — wp-cli-toolkit ⬜
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

### PROJET WP-03 — wordpress-multisite ⬜
> Héberger plusieurs sites WordPress sur une seule installation

- Activer WordPress Multisite (subdomain vs subdirectory)
- Configurer Nginx pour le multisite
- Créer et gérer plusieurs sous-sites depuis le Network Admin
- Plugins réseau vs plugins site : comprendre la différence
- Thèmes réseau

**Livrable :** Réseau multisite fonctionnel avec 3 sous-sites

---

## PHASE 2 — Sécurité WordPress

### PROJET WP-04 — wordpress-hardening ⬜
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

## Récapitulatif

| # | Projet | Phase | Statut |
|---|--------|-------|--------|
| WP-01 | wordpress-deployer | Déploiement | ⬜ |
| WP-02 | wp-cli-toolkit | Déploiement | ⬜ |
| WP-03 | wordpress-multisite | Déploiement | ⬜ |
| WP-04 | wordpress-hardening | Sécurité | ⬜ |
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

**15 projets · 4 phases · De zéro à expert WordPress/WooCommerce**

---

## Ce que ce roadmap prouve à Automattic

| Compétence demandée | Projet qui le prouve |
|--------------------|---------------------|
| WordPress hands-on | WP-01 à WP-07 |
| WooCommerce experience | WC-01 à WC-05 |
| Troubleshooting technique | WC-05, WP-07 |
| Performance & optimisation | WP-06, WC-04 |
| Backup & recovery | WP-05, WC-03 |
| Infrastructure moderne | WP-09 (Docker) |
| Migration | WP-10 |
| CLI & automatisation | WP-02 (WP-CLI) |
