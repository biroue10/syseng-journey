# Roadmap WordPress & Automattic — Objectif Happiness Engineer

Parcours pratique et complet pour maîtriser tous les produits Automattic.
Chaque projet est hands-on, public sur GitHub, avec des scénarios de troubleshooting réels.

---

## Produits qu'un Happiness Engineer utilise au quotidien

| Produit | Rôle dans le support |
|---------|---------------------|
| WordPress.com | Plateforme principale — plans, domaines, thèmes, plugins |
| Jetpack | Backup, sécurité, CDN, stats, social |
| WooCommerce | Boutiques, paiements, commandes, abonnements |
| Tumblr | Comptes, posts, thèmes, communauté, monétisation |
| Akismet | Protection anti-spam commentaires et formulaires |
| Gravatar | Avatars universels liés à WordPress.com |
| Simplenote | App de notes cross-platform |
| Pocket Casts | Podcast player cross-device |
| P2 (o2) | Communication interne asynchrone chez Automattic |
| WordPress Playground | Test instantané dans le navigateur (WASM) |
| Zendesk / Happiness | Outil interne de ticketing Automattic |

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
- Test de restauration : vérifier que le backup fonctionne réellement
- Rétention : garder 7 jours, supprimer les anciens automatiquement

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

**Livrable :** Guide de performance WordPress + résultats de benchmarks chiffrés

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

### PROJET WC-01 — woocommerce-setup ✅
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

### PROJET WC-02 — woocommerce-products ✅
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

### PROJET WC-03 — woocommerce-orders ✅
> Cycle de vie d'une commande WooCommerce — test complet

- Exporter les commandes WooCommerce en CSV (via WP-CLI)
- Exporter les produits et les clients
- Sauvegarder les clés API et configurations WooCommerce
- Script de backup dédié WooCommerce avec rétention
- Restauration : importer les données depuis les exports

**Livrable :** Script `wc-backup.sh` qui sauvegarde les données business critiques

---

### PROJET WC-04 — woocommerce-coupons ✅
> Créer et tester les types de coupons WooCommerce

- Coupon réduction fixe (BIROUE20 — 20 MAD)
- Coupon pourcentage (BIROUE10 — 10%)
- Coupon livraison gratuite (FREESHIP)
- Test en conditions réelles : application au panier
- Vérification WP-CLI : `wp post list --post_type=shop_coupon`

**Livrable :** 3 coupons fonctionnels, blog post publié

---

### PROJET WC-05 — woocommerce-troubleshooting ✅
> Diagnostiquer et résoudre les problèmes WooCommerce courants

Scénarios réels à reproduire et résoudre :
1. Checkout qui ne se soumet pas (conflit JavaScript)
2. Emails de commande qui n'arrivent pas (configuration SMTP)
3. Stock qui ne se décrémente pas
4. Page shop qui retourne 404 après migration
5. Lenteur sur la page checkout
6. Erreur 500 après mise à jour de plugin
7. Paiement Stripe échoue en production mais fonctionne en test
8. Client ne reçoit pas son produit téléchargeable
9. TVA calculée incorrectement selon la localisation
10. Abonnement pas renouvelé automatiquement (wp-cron désactivé)

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

## PHASE 6 — Écosystème Automattic Core

### PROJET A-01 — wordpress-com-explorer ⬜
> Maîtriser WordPress.com — la plateforme principale d'Automattic

- Créer un compte WordPress.com et configurer un site complet
- Explorer toutes les fonctionnalités : éditeur, thèmes, domaines, stats
- Documenter les différences entre WordPress.com et self-hosted
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

### PROJET A-04 — jetpack-overview ⬜
> Vue d'ensemble de Jetpack — tous les modules

- Installer Jetpack et connecter au compte WordPress.com
- Activer/désactiver des modules individuels
- Comprendre l'architecture : Jetpack Free vs Jetpack complet
- Tester les fonctionnalités principales : Backup, Security, Performance, Social, Stats
- Documenter ce que chaque module fait et quand le recommander

**Livrable :** Rapport documenté de chaque module Jetpack testé

---

### PROJET A-05 — akismet-spam ⬜
> Comprendre et configurer Akismet — protection anti-spam d'Automattic

- Installer Akismet et obtenir une clé API WordPress.com
- Comprendre le scoring spam : comment Akismet décide qu'un commentaire est spam
- Tester avec de faux commentaires spam
- Configurer les seuils : tenir en attente vs rejeter automatiquement
- Analyser les faux positifs : récupérer un commentaire légitime marqué spam
- API Akismet : tester un commentaire manuellement via l'API

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
- Comprendre les webhooks : signature, validation, rejeu

**Livrable :** Boutique avec 3 passerelles de paiement + runbook troubleshooting paiements

---

### PROJET A-07 — woocommerce-subscriptions ⬜
> Produits récurrents — abonnements mensuels et annuels

- Installer WooCommerce Subscriptions
- Créer des produits avec abonnement mensuel et annuel
- Gérer le cycle de vie : activation → renouvellement → annulation → réactivation
- Tester les échecs de renouvellement automatique
- Emails automatiques : rappel de renouvellement, confirmation d'annulation
- Rapports : MRR, ARR, churn rate

**Livrable :** Boutique avec 3 produits en abonnement + documentation du cycle de vie

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

**Livrable :** Repo GitHub avec scripts de reproduction + solutions documentées

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

- Créer un environnement staging sur le même serveur (sous-domaine)
- Synchroniser staging → production : fichiers + base de données
- WP-CLI search-replace pour les URLs
- Plugin WP Staging : automatiser la création de staging
- Workflow : développer en staging, tester, pousser en production
- Protéger le staging avec authentification HTTP de base

**Livrable :** Script de déploiement staging → production + documentation du workflow

---

## PHASE 9 — WordPress.com Platform Deep Dive

### PROJET WPC-01 — wordpress-com-plans ⬜
> Maîtriser les plans WordPress.com et leurs limitations

Un Happiness Engineer reçoit des dizaines de tickets par jour sur les plans.
Tu dois connaître par cœur ce qui est inclus dans chaque plan.

- Créer et explorer chaque plan : Free, Starter, Explorer, Creator, Entrepreneur
- Documenter précisément ce qui est inclus/exclu dans chaque plan :
  - Plugins (Business requis pour plugins tiers)
  - Thèmes premium (payants vs gratuits)
  - Domaines custom (inclus ou non selon le plan)
  - Stockage : de 1 GB (Free) à illimité
  - Accès SSH/SFTP/WP-CLI (Business+)
  - Support : communauté vs email vs live chat
- Simuler les upgrades : Free → Starter → Business
- Simuler les downgrades et expliquer l'impact sur le contenu
- Billing : mensuel vs annuel, remboursement 30 jours
- Comprendre les crédits de domaine inclus dans les plans payants

**Scénarios de support courants :**
1. "Je peux plus installer mes plugins" → plan downgrade ou plan insuffisant
2. "Je veux un remboursement" → politique 30 jours Automattic
3. "Mon domaine custom ne fonctionne plus" → plan expiré
4. "Mon site est passé en mode lecture seule" → paiement échoué

**Livrable :** Tableau comparatif complet des plans + guide FAQ plans pour le support

---

### PROJET WPC-02 — wordpress-com-domains ⬜
> Maîtriser la gestion des domaines sur WordPress.com

Les problèmes de domaine représentent ~25% des tickets d'un Happiness Engineer.

- Enregistrer un domaine via WordPress.com (interface et processus)
- Configurer manuellement les DNS : A, CNAME, MX, TXT, SRV records
- Pointer un domaine externe (Namecheap, GoDaddy, OVH) vers WordPress.com
  - Méthode A record : `@` → IPs WordPress.com
  - Méthode CNAME : `www` → `yoursite.wordpress.com`
- Transférer un domaine depuis un registrar externe vers WordPress.com
  - Unlock le domaine, obtenir l'auth code (EPP code)
  - Initier le transfert, attendre la confirmation
  - Transfert refusé : conditions (moins de 60 jours depuis création)
- Mapping vs Transfert : différences, quand recommander l'un vs l'autre
- Configurer les emails sur le domaine (Titan Email)
- Comprendre la propagation DNS : TTL, outils de vérification (dig, dnschecker.org)
- HTTPS sur domaine custom WordPress.com : Let's Encrypt automatique mais...
  - Pourquoi ça échoue : DNS pas encore propagé, CNAME vs A record, proxy Cloudflare

**Scénarios critiques à maîtriser :**
1. "Mon domaine ne pointe plus vers mon site" → vérifier A records, TTL, propagation
2. "Je veux transférer mon domaine vers un autre registrar" → unlock + auth code + délai
3. "Mon email ne fonctionne plus depuis que j'ai changé mes DNS" → MX records perdus
4. "HTTPS ne fonctionne pas sur mon domaine custom" → CNAME vs A record conflit
5. "Mon domaine a expiré — je l'ai perdu ?" → période de grâce, redemption period
6. "J'ai supprimé mes DNS records par erreur" → restauration depuis les defaults
7. "Cloudflare est activé — mon SSL ne fonctionne pas" → mode Full vs Flexible SSL
8. "Mon sous-domaine pointe vers le mauvais site" → conflit CNAME/A record

**Livrable :** Rapport de gestion DNS complet + arbre de décision troubleshooting domaines

---

### PROJET WPC-03 — wordpress-com-email ⬜
> Titan Email — le service email intégré WordPress.com

- Architecture Titan Email : différence avec Gmail/Outlook (serveur mutualisé)
- Créer une boîte email, configurer des aliases, des groupes/listes de diffusion
- Configurer un client mail externe :
  - Outlook (IMAP : mail.titan.email:993 / SMTP : smtp.titan.email:587)
  - Apple Mail
  - Thunderbird
  - Gmail (récupérer les emails Titan dans Gmail)
- Webmail : utiliser l'interface Titan Email webmail
- Comprendre les records DNS nécessaires : MX, SPF, DKIM, DMARC
  - SPF : `v=spf1 include:spf.titan.email ~all`
  - DKIM : clé fournie par Titan, ajouter en record TXT
  - DMARC : `v=DMARC1; p=quarantine; rua=mailto:admin@tondomaine.com`
- Vérifier la délivrabilité : mail-tester.com, MXToolbox
- Troubleshooting : bounce, spam, blacklist IP Titan

**Scénarios de support :**
1. "Mes emails partent en spam chez Gmail" → SPF/DKIM/DMARC incomplets
2. "Je ne reçois plus mes emails depuis 2 jours" → MX records manquants
3. "Mon email Titan ne se configure pas dans Outlook" → paramètres IMAP/SMTP
4. "J'ai changé mes DNS et perdu mes emails" → MX records à restaurer
5. "Quelqu'un usurpe mon email" → DMARC à configurer

**Livrable :** Guide complet setup Titan Email + checklist délivrabilité + runbook troubleshooting email

---

### PROJET WPC-04 — wordpress-com-themes ⬜
> Thèmes WordPress.com — personnalisation complète

- Explorer le catalogue de thèmes WordPress.com : Free vs Premium (payants)
- Thèmes classiques vs thèmes blocs (FSE) : différences importantes pour le support
- Personnalisation avec le Customizer (thèmes classiques) :
  - Couleurs, typographies, en-tête, pied de page
  - CSS additionnel
  - Widgets et menus
- Full Site Editing sur WordPress.com (thèmes blocs) :
  - Éditer header, footer, templates de pages
  - Stylebook : système de design global du thème
  - Différences FSE WordPress.com vs self-hosted (certaines fonctions limitées)
- CSS additionnel : limites sur les plans Free/Personal
- Créer un child theme sur WordPress.com (Business plan requis)
- Migrer un thème classique vers un thème bloc : points de friction
- Restaurer un thème cassé : étapes de récupération

**Scénarios de support :**
1. "Mon CSS additionnel a disparu après une mise à jour" → plan requis, où le remettre
2. "Mon thème n'est plus disponible dans le catalogue" → thème retiré, alternatives
3. "Certaines parties de mon site ont disparu" → migration Classic → FSE (widgets → blocs)
4. "Mon site mobile est cassé" → CSS responsive custom mal écrit
5. "Je veux revenir à l'ancien thème" → changer le thème, pas de rollback automatique

**Livrable :** Site WordPress.com avec thème bloc personnalisé + guide migration Classic → FSE

---

### PROJET WPC-05 — wordpress-com-reader ⬜
> WordPress.com Reader et abonnements email

Le Reader est souvent méconnu mais central dans l'expérience WordPress.com.

- Maîtriser le Reader : suivre des sites WordPress.com, des tags, des newsletters
- Comprendre l'algorithme du Reader : ordre chronologique vs recommandations
- Jetpack Subscriptions : formulaire d'abonnement email sur self-hosted
- WordPress.com Newsletter : transformer un blog en newsletter (sans MailChimp)
  - Créer des "newsletters" (catégories envoyées par email automatiquement)
  - Gérer les abonnés : import, export, désabonnement
  - Personnaliser l'email de newsletter
- Troubleshooting Reader : post qui n'apparaît pas, site "fantôme" dans le Reader
- Notifications WordPress.com : likes, commentaires, mentions

**Scénarios de support :**
1. "Mon site n'apparaît plus dans le Reader" → statut du site, visibilité
2. "Mes abonnés ne reçoivent plus mes newsletters" → problème d'envoi, spam
3. "Je veux exporter ma liste d'abonnés" → export depuis Jetpack Subscriptions
4. "Un abonné veut se désabonner mais le lien ne fonctionne pas" → procédure manuelle

**Livrable :** Site avec newsletter configurée + rapport sur le Reader et les abonnements

---

### PROJET WPC-06 — wordpress-com-migrations ⬜
> Migrer vers et depuis WordPress.com

La migration est parmi les 5 raisons les plus courantes d'appeler le support.

- Importer depuis WordPress self-hosted vers WordPress.com :
  - Exporter un fichier WXR (.xml) depuis le site source
  - Importer via l'outil d'import WordPress.com
  - Gérer les médias manquants (import media depuis URLs externes)
  - Résoudre les conflits de slug/permalink
- Importer depuis Blogger, Wix, Squarespace :
  - Processus différent pour chaque plateforme
  - Limitations de l'import (médias, plugins, code custom)
- Exporter de WordPress.com vers self-hosted :
  - Export complet au format WXR
  - Migrer avec Jetpack Migrate (outil officiel) — recommandé
  - Migrer manuellement avec All-in-One WP Migration
- Troubleshooting post-migration :
  - Images manquantes : régénérer les thumbnails, re-importer les médias
  - URLs cassées : search-replace avec WP-CLI
  - Plugins qui ne fonctionnent plus : vérifier la compatibilité de version
  - Thème non disponible dans WordPress.com : trouver une alternative

**Scénarios :**
1. Client quitte Wix pour WordPress.com → import complet avec médias
2. Client veut passer de WordPress.com à self-hosted → export + configure + search-replace
3. Migration WordPress self-hosted → WordPress.com : 2000 images perdues → solution
4. "Mon site migré a des URLs qui pointent vers l'ancien domaine" → search-replace

**Livrable :** Guide migration complet avec toutes les combinaisons source/destination + troubleshooting

---

## PHASE 10 — Jetpack Deep Dive

### PROJET J-01 — jetpack-connection-mastery ⬜
> Comprendre et déboguer la connexion Jetpack

La connexion Jetpack est la source #1 des problèmes Jetpack.
Impossible de faire du support Jetpack sans maîtriser ça.

**Architecture :**
- Comment Jetpack connecte un site self-hosted à WordPress.com
- Flux de connexion : site → XML-RPC ou REST API → serveurs WordPress.com
- Deux types de connexion :
  - Full Connection : site + admin user connectés à WordPress.com
  - Site-Only Connection : site connecté sans compte utilisateur WP.com

**Pratique :**
- Connecter Jetpack via l'interface web
- Connecter Jetpack via WP-CLI : `wp jetpack connect`
- Tester la connexion : `wp jetpack test-connection`
- Diagnostiquer : `wp jetpack status`
- Déconnecter proprement : `wp jetpack disconnect`
- Reconnecter après migration/changement de domaine

**Scénarios critiques :**
1. "Jetpack est déconnecté après migration" → reconnexion via WP-CLI, mise à jour URL
2. "Jetpack bloque XML-RPC sur mon site" → différencier Jetpack du problème
3. "Mon site Jetpack est connecté au mauvais compte WordPress.com" → reset connexion
4. "Jetpack ne se connecte pas — erreur de pare-feu" → IPs Automattic à whitelister
5. "Error 403 lors de la connexion Jetpack" → htaccess, plugin sécurité qui bloque
6. "La connexion Jetpack explose après changement de domaine" → procédure officielle
7. "Jetpack dit que le site est connecté mais les fonctionnalités ne marchent pas" → token corrompu

**Livrable :** Runbook complet connexion/déconnexion + 7 scénarios de troubleshooting résolus

---

### PROJET J-02 — jetpack-backup-mastery ⬜
> Jetpack Backup (anciennement VaultPress) — sauvegardes en temps réel

**Comprendre l'architecture :**
- Jetpack Backup Daily vs Real-time : différences critiques pour le support
- Que sauvegarde Jetpack : fichiers WordPress + base de données (pas le serveur complet)
- Stockage dans le cloud Automattic : isolé du serveur

**Pratique :**
- Déclencher un backup manuel depuis l'interface
- Vérifier le statut du backup : succès, en cours, erreur
- Voir l'historique des backups : points de restauration disponibles
- Restauration complète : choisir un point dans le temps
- Restauration sélective :
  - Fichiers uniquement (ex : thème corrompu)
  - Base de données uniquement (ex : contenu supprimé par erreur)
  - Quelques fichiers spécifiques
- Télécharger une archive de backup localement
- Utiliser le backup pour migrer un site

**Scénarios de support :**
1. "Mon site a été piraté hier à 14h, je veux revenir à 13h" → restore sélectif temporel
2. "Mon backup est bloqué à 50% depuis 2 jours" → causes : timeout, gros fichiers
3. "J'ai supprimé 500 articles par erreur" → restore DB sélective
4. "Je veux migrer mon site avec Jetpack Backup" → download + restore sur autre serveur
5. "Jetpack Backup dit 'insufficient storage'" → nettoyage ancien backups

**Livrable :** Scénario de disaster recovery documenté en détail avec captures + temps de restore mesuré

---

### PROJET J-03 — jetpack-security-waf ⬜
> Jetpack Security — WAF, scan malware, brute force, 2FA

**Modules de sécurité Jetpack :**
- Jetpack Protect : scanner les vulnérabilités connues (CVE) dans plugins/thèmes
- WAF (Web Application Firewall) :
  - Mode automatique vs règles manuelles
  - Journal des attaques bloquées
  - Whitelist d'IPs et d'URLs
  - Comprendre les règles : SQLi, XSS, path traversal bloqués
- Scan malware :
  - Déclencher un scan manuel
  - Interpréter les résultats : niveau de sévérité, localisation du fichier suspect
  - Nettoyer un fichier infecté identifié par Jetpack
  - Faux positifs : rapporter, exclure
- Protection brute force :
  - Visualiser les IPs bloquées
  - Whitelist une IP légitime bloquée par erreur
  - CAPTCHA sur la page de login
- 2FA via WordPress.com :
  - Activer pour un utilisateur admin
  - Activer pour tous les admins en force
  - Que faire si un admin perd son 2FA

**Scénarios :**
1. "Le WAF bloque mes clients quand ils essaient de commander" → ajuster les règles WAF
2. "Jetpack a trouvé du malware — que faire ?" → procédure de nettoyage complète
3. "Mon site a été compromis, 200 faux admins créés" → nettoyage + renforcement
4. "Je suis bloqué sur ma propre page de login" → whitelist mon IP
5. "Jetpack Protect dit que Rank Math a une vulnérabilité critique" → mise à jour d'urgence

**Livrable :** Rapport de sécurité avant/après hardening avec Jetpack + procédure de nettoyage post-hack

---

### PROJET J-04 — jetpack-performance-cdn ⬜
> Jetpack Performance — CDN, Boost, VideoPress, optimisation images

**Jetpack CDN (anciennement Photon) :**
- Activer le CDN pour images et médias
- Comprendre comment les images sont servies depuis les serveurs WordPress.com
- Formats modernes : WebP automatique via le CDN Jetpack
- Désactiver le CDN pour certaines images (cas particuliers)

**Jetpack Boost :**
- Critical CSS : générer et appliquer le CSS critique (above-the-fold)
- Defer non-essential JavaScript : éviter les scripts qui bloquent le rendu
- Lazy loading des images
- Minification CSS/JS
- Comprendre les conflits Jetpack Boost + plugin de cache (WP Rocket, W3 Total Cache)

**VideoPress :**
- Uploader une vidéo via VideoPress
- Configurer le lecteur : autoplay, contrôles, privacy
- Intégrer dans un post Gutenberg
- Comprendre les limites de stockage vidéo par plan

**Mesurer :**
- GTMetrix avant/après Jetpack Boost
- PageSpeed Insights avant/après CDN activé
- Waterfall chart : identifier ce que le CDN améliore réellement

**Scénarios :**
1. "Mon site est plus lent depuis que Jetpack Boost est activé" → conflit avec cache plugin
2. "Mes images ne s'affichent plus après activation du CDN" → SSL mixte, chemin relatif vs absolu
3. "VideoPress ne lit pas mes vidéos sur mobile" → format vidéo non supporté, codec
4. "Jetpack Boost Critical CSS est cassé sur la page d'accueil" → régénérer le CSS critique

**Livrable :** Rapport de performance avant/après avec métriques GTMetrix + PageSpeed

---

### PROJET J-05 — jetpack-social-subscriptions ⬜
> Jetpack Social, Stats, et Abonnements email

**Jetpack Social :**
- Connecter les réseaux sociaux : Facebook Page, Twitter/X, LinkedIn, Instagram, Mastodon
- Autopublication : configurer les messages automatiques à la publication d'un article
- Personnaliser le message par réseau social
- Republier un ancien article manuellement
- Gérer les tokens expirés : reconnexion automatique vs manuelle

**Jetpack Stats :**
- Analyser le trafic : visiteurs uniques, vues, pages populaires, sources de trafic
- Comprendre la différence Jetpack Stats vs Google Analytics :
  - Jetpack Stats : côté serveur, pas de JS tracker, plus fiable pour les adblocks
  - GA4 : plus de détails, comportement utilisateur, conversion
- Referrers : d'où viennent tes visiteurs
- Clicks : sur quels liens cliquent tes visiteurs
- Pays : géolocalisation des visiteurs

**Jetpack Subscriptions (Newsletter) :**
- Configurer le formulaire d'abonnement email
- Gérer les abonnés : voir, exporter, désabonner manuellement
- Envoyer une notification email quand un article est publié
- Personnaliser l'email de notification

**Scénarios :**
1. "Mon partage social ne fonctionne plus" → token expiré, reconnecter le réseau
2. "Mes stats Jetpack montrent 0 depuis 3 jours" → module Stats désactivé, conflit plugin
3. "Un abonné reçoit mes emails en spam" → vérifier SPF/DKIM du domaine
4. "Je veux importer une liste d'abonnés depuis Mailchimp" → Jetpack Subscriptions limitations

**Livrable :** Site avec partage social automatique configuré + rapport analyse trafic mensuel

---

### PROJET J-06 — jetpack-crm-search ⬜
> Jetpack CRM et Jetpack Search

**Jetpack Search :**
- Remplacer la recherche WordPress native (souvent lente, basique)
- Instant Search : résultats en temps réel sans rechargement de page
- Configurer les filtres : catégories, tags, auteurs, dates, types de post
- Personnaliser l'apparence des résultats
- Comprendre l'indexation : quand Jetpack indexe le contenu
- Troubleshooting : résultats qui n'apparaissent pas, index désynchronisé

**Jetpack CRM (anciennement Zero BS CRM) :**
- Architecture : contacts, entreprises, devis, factures, transactions, événements
- Importer des contacts depuis un CSV
- Connecter WooCommerce : sync automatique des clients WooCommerce dans le CRM
- Créer un devis et l'envoyer par email
- Segmentation : filtrer les contacts par tag, statut, montant d'achat
- Comprendre quand recommander Jetpack CRM vs HubSpot/Salesforce/Pipedrive

**Livrable :** Site avec Jetpack Search configuré + démonstration CRM avec 20 contacts importés

---

## PHASE 11 — Tumblr & Autres Produits Automattic

### PROJET TBL-01 — tumblr-fundamentals ⬜
> Maîtriser Tumblr comme un Happiness Engineer

Automattic a acquis Tumblr en 2019. Les Happiness Engineers supportent Tumblr.

**Architecture et fonctionnement :**
- Dashboard Tumblr : flux, recommandations, trending
- Profils : primary blog vs secondary blogs (un compte peut avoir plusieurs blogs)
- Types de posts : text, photo, quote, link, chat, audio, video
- Reblog : mécanique de partage Tumblr, notes, likes
- Tags et recherche : différence avec les hashtags Instagram/Twitter
- Tumblr.com vs domaine custom : configurer un domaine custom

**Fonctionnalités avancées :**
- Queue : programmer des posts (fréquence, heure d'envoi)
- Draft : sauvegarder pour plus tard
- Schedule : publier à une date/heure précise
- Submission : permettre aux abonnés de soumettre du contenu
- Ask/messages : activer les questions anonymes

**Monétisation Tumblr :**
- Post+ : contenu payant pour abonnés
- Tumblr Live : streaming en direct
- Creator Rewards : programme de rémunération pour les créateurs
- Tip Jar : pourboires depuis les lecteurs

**Troubleshooting Tumblr fréquent :**
1. "Mon blog n'apparaît plus dans les recherches Tumblr" → shadowban, Safe Mode, tags NSFW
2. "Je ne peux plus me connecter à mon compte Tumblr" → email, 2FA, compte désactivé
3. "Mon domaine custom ne fonctionne plus sur Tumblr" → CNAME vers `domains.tumblr.com`
4. "Mes posts ont disparu" → contenu supprimé (Community Guidelines), corbeille
5. "Mon thème est cassé après une mise à jour de Tumblr" → JavaScript custom incompatible
6. "Je reçois des messages harcelants" → blocage, signalement, Safe Mode
7. "Mon compte Tumblr a été piraté" → récupération, sécurisation, révocation sessions

**Livrable :** Blog Tumblr public avec contenu varié + guide de troubleshooting Tumblr documenté

---

### PROJET TBL-02 — tumblr-themes-dev ⬜
> Développement de thèmes Tumblr

Comprendre les thèmes Tumblr permet de déboguer les problèmes de personnalisation.

**Variables Tumblr :**
- Méta-variables : `{Title}`, `{Description}`, `{MetaDescription}`, `{RSS}`, `{Favicon}`
- Variables de post : `{PostTitle}`, `{PostURL}`, `{Body}`, `{PostDate}`
- Variables par type : `{PhotoURL-500}`, `{Caption}`, `{AudioPlayerBlack}`, `{VideoEmbed}`
- Variables de navigation : `{PreviousPage}`, `{NextPage}`, `{CurrentPage}`
- Variables de personnalisation : `{color:Fond}`, `{font:Titre}`, `{image:Bannière}`

**Créer un thème de zéro :**
- Structure HTML minimale d'un thème Tumblr
- Boucle de posts : `{block:Posts}...{/block:Posts}`
- Gérer chaque type de post différemment (photo vs text vs quote)
- CSS responsive : mobile-first design
- JavaScript : attention aux interactions avec l'interface Tumblr

**Déployer et tester :**
- Uploader le thème dans Customize → Edit HTML
- Tester avec différents types de posts
- Intégrer Google Analytics dans le thème
- Intégrer Disqus pour les commentaires

**Scénarios de support :**
1. "Mon thème custom ne s'affiche pas correctement sur mobile" → CSS responsive manquant
2. "Mon thème Tumblr a une zone de texte cassée" → mauvaise variable pour le type de post
3. "Je veux ajouter un formulaire de contact dans mon thème" → Formspree ou Netlify Forms

**Livrable :** Thème Tumblr custom publié + repo GitHub avec le code source commenté

---

### PROJET GRV-01 — gravatar-mastery ⬜
> Gravatar — avatar universel WordPress.com

Gravatar est utilisé dans tous les sites WordPress (commentaires, profil auteur).
Un Happiness Engineer doit maîtriser son fonctionnement.

**Comment Gravatar fonctionne :**
- L'email d'un utilisateur est hashé en MD5
- Le site WordPress fait une requête `https://www.gravatar.com/avatar/[HASH_MD5]`
- Gravatar retourne l'image associée à cet email (ou l'image par défaut)

**Pratique :**
- Créer un profil Gravatar complet : nom, bio, liens sociaux, plusieurs photos
- Système de rating : G (tous), PG (adolescents), R (adultes), X (adultes seulement)
  - Impact : si le site WordPress est configuré pour G uniquement, un Gravatar R ne s'affiche pas
- API Gravatar :
  - Récupérer un avatar via l'API (hash MD5 de l'email)
  - Paramètres : `?s=200` (taille), `?d=mp` (défaut), `?r=pg` (rating max)
  - Script Bash : `echo -n "email@example.com" | md5sum`

**Troubleshooting :**
1. "Mon avatar ne s'affiche pas dans les commentaires" → email du compte WordPress ≠ email Gravatar
2. "Mon avatar est une image grise/mystère" → Gravatar non configuré, email pas associé
3. "Mon avatar ne se met pas à jour" → cache navigateur, cache Gravatar (24h)
4. "Mon avatar est incorrect sur un site WordPress.com" → email du profil utilisateur

**Livrable :** Script qui affiche l'avatar Gravatar de n'importe quel email via l'API + documentation

---

### PROJET SNOTE-01 — simplenote-mastery ⬜
> Simplenote — prise de notes cross-platform Automattic

**Fonctionnalités à maîtriser :**
- Interface : listes de notes, tri par date/alphabétique, épinglage
- Markdown : Simplenote supporte le Markdown (activer dans les paramètres)
- Tags : organiser les notes par catégorie
- Collaboration : partager une note avec quelqu'un (co-édition en temps réel)
- Publish : publier une note publiquement (lien unique)
- Versioning : historique complet des modifications, restaurer une version antérieure

**Cross-platform :**
- Web : app.simplenote.com
- iOS, Android, Mac, Windows, Linux : mêmes fonctionnalités, sync instantanée
- Comprendre la synchronisation : comment Simplenote gère les conflits de sync

**Export et récupération :**
- Exporter toutes les notes en JSON ou ZIP (fichiers .txt)
- Récupérer une note supprimée via la corbeille
- Restaurer une version antérieure via l'historique

**Troubleshooting :**
1. "Mes notes ne se synchronisent pas entre mes appareils" → connexion, compte, forcer sync
2. "J'ai supprimé une note importante" → corbeille Simplenote
3. "Je ne peux plus accéder à mon compte Simplenote" → récupération par email

**Livrable :** Guide utilisateur Simplenote + cheat sheet troubleshooting

---

### PROJET PC-01 — pocketcasts-mastery ⬜
> Pocket Casts — podcast player d'Automattic (acquis en 2021)

**Fonctionnalités à maîtriser :**
- S'abonner à des podcasts (recherche, RSS direct, OPML import)
- Écouter : contrôles (vitesse x0.5 à x3, trim silence, volume boost)
- Up Next : file de lecture, drag-and-drop, marquer comme lu
- Chapitres : navigation dans les épisodes avec chapitres
- Chapitres et notes de show : affichés pendant l'écoute
- Mode nuit : interface sombre

**Cross-platform :**
- Web player : play.pocketcasts.com (aucune installation requise)
- iOS et Android : fonctionnalités identiques
- Sync : "Up Next" synchronisé entre tous les appareils

**Pocket Casts Plus (fonctionnalités premium) :**
- Bookmarks : marquer un moment dans un épisode
- Watch app (Apple Watch / Wear OS)
- Desktop apps (Mac, Windows, Linux)
- Cloud Storage : uploader ses propres fichiers MP3

**Troubleshooting :**
1. "L'épisode ne se télécharge pas" → réseau, espace de stockage, problème RSS du podcast
2. "Ma sync ne fonctionne pas entre iPhone et web" → connexion au même compte
3. "Un podcast ne se met pas à jour" → RSS corrompu ou serveur du podcast down
4. "J'ai perdu ma liste Up Next" → sync cloud, récupération impossible si offline only

**Livrable :** Guide complet Pocket Casts + troubleshooting documenté

---

### PROJET P2-01 — p2-culture-automattic ⬜
> P2 (o2) — comprendre la communication interne d'Automattic

Automattic est 100% remote depuis sa création.
P2 est au cœur de leur culture. Comprendre P2 = comprendre Automattic.

**Qu'est-ce que P2 :**
- Un thème WordPress transformé en outil de communication asynchrone
- Remplace les meetings synchrones par des posts écrits
- Chaque équipe Automattic a son P2 (des centaines de P2 internes)
- o2 : version interne et optimisée de P2 utilisée par Automattic

**Installer et utiliser P2 :**
- Installer le thème P2 sur un WordPress self-hosted
- Publier un post P2 : format, mentions @utilisateur, réactions
- Commentaires en-ligne : répondre à un paragraphe spécifique
- Fils de discussion imbriqués
- Suivi de décisions : marquer un commentaire comme "résolution"

**Philosophie de communication d'Automattic :**
- "Write everything down" — l'écriture asynchrone est la norme
- Pas de "quick syncs" inutiles — préférer un post P2 bien rédigé
- Ouverture : la plupart des communications sont visibles par toute l'entreprise
- Différence avec Slack : Slack pour l'urgence, P2 pour la réflexion et les décisions

**Pourquoi c'est critique pour ton application :**
- L'entretien Automattic se fait souvent de manière asynchrone (test écrit, essai)
- Ils attendent que tu communiques clairement par écrit
- Comprendre P2 montre que tu comprends leur culture unique

**Livrable :** Post P2 public sur un blog self-hosted expliquant la communication asynchrone chez Automattic

---

### PROJET PLAY-01 — wordpress-playground ⬜
> WordPress Playground — tester n'importe quel scénario sans installer

WordPress Playground est révolutionnaire pour le support.
Un Happiness Engineer peut l'utiliser pour reproduire un bug sans risquer son serveur.

**Comprendre WordPress Playground :**
- WordPress entier qui tourne dans le navigateur (WebAssembly = WASM)
- Zéro installation requise : fonctionne sur n'importe quel appareil
- Isolé : chaque onglet = une instance WordPress fraîche
- Limites : pas de vrai serveur, données perdues au rafraîchissement

**Utiliser Playground pour le support :**
- Accéder : wordpress.org/playground
- Reproduire un bug : installer le plugin incriminé, reproduire l'erreur
- Tester la compatibilité entre deux plugins avant de les installer en production
- Envoyer un lien Playground à un utilisateur pour lui montrer quelque chose
- Tester une version spécifique de WordPress (7.X, 8.X)

**Blueprints — configuration automatique :**
```json
{
  "steps": [
    {
      "step": "installPlugin",
      "pluginZipFile": {
        "resource": "wordpress.org/plugins",
        "slug": "woocommerce"
      }
    },
    {
      "step": "login",
      "username": "admin",
      "password": "password"
    }
  ]
}
```
- Créer un Blueprint qui pré-installe WooCommerce + un thème + des données de test
- Partager ce Blueprint comme lien URL

**Scénarios d'usage :**
1. Utilisateur dit "mon plugin Rank Math casse ma page" → reproduire dans Playground
2. Montrer à un utilisateur comment configurer WooCommerce étape par étape
3. Tester si un bug est lié à WordPress core ou au plugin
4. Tester une mise à jour risquée avant de l'appliquer en production

**Livrable :** 5 Blueprints Playground pour scénarios de support courants + guide d'utilisation

---

## PHASE 12 — Happiness Engineer Simulations

### PROJET HE-01 — ticket-simulation-wordpress-com ⬜
> Simuler et résoudre 15 tickets WordPress.com réels

Format : symptôme → étapes de diagnostic → solution → réponse au client (ton empathique).

1. **Site en maintenance** — client a activé mode maintenance, ne sait pas comment désactiver
   → Supprimer `.maintenance` via FTP ou désactiver le plugin maintenance

2. **WSOD après mise à jour** — plugin incompatible sur Business plan
   → Désactiver les plugins via SFTP, puis par bisection

3. **Erreur 403 Forbidden** — permissions ou plugin sécurité bloque le client
   → Vérifier les logs, le plugin de sécurité, les htaccess rules

4. **Erreur 429 Too Many Requests** — rate limiting WordPress.com
   → Expliquer le rate limiting, optimiser les requêtes, CDN

5. **CSS custom disparu** — mise à jour thème a écrasé les customisations
   → Récupérer depuis les révisions Customizer, créer un child theme

6. **Google n'indexe plus mon site** — "Décourager les moteurs de recherche" coché
   → Paramètres → Lecture → décocher l'option

7. **Spam comments explosion** — Akismet mal configuré ou désactivé
   → Réactiver Akismet, purger le spam, activer les modérations

8. **Impossible de supprimer un utilisateur** — auteur avec du contenu assigné
   → Réassigner le contenu à un autre auteur avant suppression

9. **Widget disparu après mise à jour** — migration vers FSE a cassé les widgets
   → Expliquer la migration Classic → Bloc, recréer avec des blocs

10. **Boucle de redirection infinie** — siteurl/home mal configuré en HTTPS
    → Corriger via WP-CLI ou en DB directement

11. **Import XML échoue** — limite d'upload ou format incorrect
    → Augmenter upload_max_filesize, diviser le fichier XML

12. **Contenu disparu** — articles dans la corbeille ou révisions
    → Vider la corbeille, restaurer depuis révision

13. **Vitesse lente sur mobile** — diagnostiquer avec les outils WordPress
    → Query Monitor, GTMetrix mobile, désactiver plugins inutiles

14. **Commentaires désactivés sur tous les articles** — paramètre global WordPress
    → Paramètres → Discussion → vérifier les options

15. **Compte WordPress.com verrouillé** — 2FA perdu, email inaccessible
    → Procédure de récupération de compte Automattic, vérification identité

**Livrable :** Repo GitHub avec 15 fiches de résolution — symptôme + diagnostic + solution + réponse client

---

### PROJET HE-02 — ticket-simulation-jetpack ⬜
> Simuler et résoudre 10 tickets Jetpack réels

1. **Jetpack déconnecté sans raison** → causes (migration, changement domaine, plugin conflit), reconnexion
2. **Backup bloqué à 60% depuis 48h** → timeout, fichier trop grand, wp-cron désactivé
3. **Faux positif WAF — client légitime bloqué** → identifier la règle, whitelist l'IP
4. **Stats Jetpack à 0 depuis une semaine** → module désactivé, conflit cache plugin
5. **Partage social cesse de fonctionner** → token expiré (Facebook change ses API), reconnexion
6. **Scan malware — faux positif** → analyser le fichier, rapporter à Automattic
7. **Module Jetpack cause une erreur PHP** → désactiver individuellement via WP-CLI
8. **VideoPress — vidéo ne lit pas sur iOS** → format MP4/H264, codec, DRM
9. **Abonnés email reçoivent du spam** → serveur d'envoi Jetpack, SPF mal configuré
10. **Site redirige vers site inconnu après hack** → nettoyage htaccess, recherche code malveillant

**Format de chaque ticket :** symptôme → commandes de diagnostic → solution → prevention

**Livrable :** 10 fiches troubleshooting Jetpack + scripts WP-CLI de diagnostic automatique

---

### PROJET HE-03 — ticket-simulation-woocommerce ⬜
> Simuler et résoudre 10 tickets WooCommerce réels

1. **Checkout ne se soumet pas** — conflit JavaScript : désactiver plugins un par un, console JS
2. **Commande bloquée en "processing"** — webhook paiement Stripe manqué : logs Stripe, replay
3. **Stock ne se décrémente pas** — gestion de stock désactivée : activer par produit et global
4. **Emails de commande non reçus** — SMTP mal configuré : WP Mail SMTP + test email
5. **Remboursement impossible** — délai dépassé côté Stripe (120 jours max) : remboursement manuel
6. **Prix affiché en mauvaise devise** — géolocalisation WooCommerce : configurer ou désactiver
7. **Page shop retourne 404** — permalink WooCommerce non assigné : Paramètres → WooCommerce → Pages
8. **Erreur Stripe "invalid_request_error"** — clés API test vs production mélangées
9. **TVA calculée incorrectement** — adresse de facturation vs adresse de livraison : config taxes
10. **Abonnement pas renouvelé** — wp-cron désactivé : activer ou configurer cron système

**Livrable :** Runbook WooCommerce avec 10 scénarios + commandes WP-CLI pour chaque diagnostic

---

### PROJET HE-04 — ticket-simulation-domains-dns ⬜
> Simuler et résoudre 10 tickets domaines/DNS

1. **Domaine ne pointe pas vers WordPress.com** → vérifier A records (dig, dnschecker), TTL
2. **HTTPS ne fonctionne pas sur domaine custom** → CNAME au lieu de A, proxy Cloudflare
3. **Email ne fonctionne plus après changement DNS** → MX records perdus ou écrasés
4. **Domaine expiré** → période de grâce (30 jours), redemption period (30 jours après), procédure
5. **Transfert de domaine bloqué** → unlock requis, auth code (EPP code), WHOIS privacy à désactiver
6. **Sous-domaine ne pointe pas correctement** → CNAME vs A record, wildcard DNS
7. **Site accessible depuis certains endroits mais pas d'autres** → propagation DNS, TTL court
8. **Redirection de domaine cassée** → redirect vs mapping dans WordPress.com, boucle infinie
9. **Google Workspace MX + WordPress.com** → conflit MX records, priorité, vérification Google
10. **DNSSEC activé cause des problèmes SSL** → désactiver DNSSEC chez le registrar

**Livrable :** Guide DNS pour le support WordPress.com + arbre de décision par problème

---

### PROJET HE-05 — ticket-simulation-account-security ⬜
> Tickets de sécurité et récupération de compte

Ces tickets sont parmi les plus sensibles — ils impliquent l'identité et la confiance du client.

1. **Compte WordPress.com hacké** — sessions actives, changer mot de passe, activer 2FA, audit
2. **2FA perdu — plus accès à l'app authenticator** — codes de secours, SMS backup, procédure support
3. **Email du compte inaccessible** — vérification identité alternative, procédure officielle Automattic
4. **Spam envoyé depuis le site WordPress** — audit plugins, supprimer backdoors, changer tous les mdp
5. **Contenu supprimé par WordPress.com** — politique Community Guidelines, procédure d'appel
6. **Faux DMCA — quelqu'un a signalé mon contenu** — DMCA counter-notice, procédure légale
7. **Compte suspendu** — identifier la raison (spam, payment, ToS), procédure de réintégration
8. **Phishing imitant WordPress.com** — comment distinguer les vrais emails Automattic
9. **Accès admin perdu après changement email** — récupération via WP-CLI, reset mdp en DB
10. **Équipe partage un compte admin** — mauvaise pratique, recommander les rôles WordPress

**Livrable :** Guide de sécurité de compte WordPress.com + modèles de réponses pour chaque scénario

---

### PROJET HE-06 — soft-skills-support ⬜
> Communication, empathie, et rédaction dans le support technique

Un Happiness Engineer chez Automattic doit être un excellent communicant.
Les compétences techniques ne suffisent pas — la façon de les communiquer est tout aussi importante.

**Rédaction de réponses claires :**
- Éviter le jargon technique avec un client non-technicien
- Structure d'une bonne réponse : empathie → diagnostic → solution → prévention
- Adapter le niveau de langage : client débutant vs développeur
- Reformuler sans paraphraser (ne pas répéter le problème mot pour mot)

**Exercices pratiques :**
1. Réécrire 5 réponses techniques en langage simple (sans jargon)
2. Simuler 3 conversations avec un client très frustré (répondre avec calme et empathie)
3. Écrire 3 articles de base de connaissance (style WordPress.com Support — docs.wordpress.com)
4. Rédiger un post-mortem d'incident en style Automattic (factuel, sans blâme)
5. Créer un arbre de décision de troubleshooting pour un problème courant

**Gérer les clients difficiles :**
- Client qui pense que c'est la faute d'Automattic (alors que c'est un plugin tiers)
- Client qui a perdu des données (empathie maximale, pas d'excuses si pas ta faute)
- Client qui menace de partir vers un concurrent
- Client qui répète 10 fois le même problème sans essayer les solutions proposées

**Escalade intelligente :**
- Quand escalader un ticket vs le résoudre soi-même
- Comment rédiger une escalade utile : contexte, étapes déjà tentées, hypothèse actuelle
- Documentation pour la base de connaissance interne

**Livrable :** Portfolio de 5 exemples de réponses + 3 articles de support + 2 arbres de décision

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
| WC-01 | woocommerce-setup | WooCommerce | ✅ |
| WC-02 | woocommerce-products | WooCommerce | ✅ |
| WC-03 | woocommerce-orders | WooCommerce | ✅ |
| WC-04 | woocommerce-coupons | WooCommerce | ✅ |
| WC-05 | woocommerce-troubleshooting | WooCommerce | ✅ |
| WP-08 | wordpress-monitoring | Production | ⬜ |
| WP-09 | wordpress-docker | Production | ⬜ |
| WP-10 | wordpress-migration | Production | ⬜ |
| A-01 | wordpress-com-explorer | Automattic Core | ⬜ |
| A-02 | wordpress-rest-api | Automattic Core | ⬜ |
| A-03 | gutenberg-blocks | Automattic Core | ⬜ |
| A-04 | jetpack-overview | Automattic Core | ⬜ |
| A-05 | akismet-spam | Automattic Core | ⬜ |
| A-06 | woocommerce-payments | WooCommerce Avancé | ⬜ |
| A-07 | woocommerce-subscriptions | WooCommerce Avancé | ⬜ |
| A-08 | woocommerce-multisite | WooCommerce Avancé | ⬜ |
| A-09 | wordpress-debug | Debugging | ⬜ |
| A-10 | wordpress-errors | Debugging | ⬜ |
| A-11 | wordpress-email | Debugging | ⬜ |
| A-12 | wordpress-staging | Debugging | ⬜ |
| WPC-01 | wordpress-com-plans | WordPress.com Deep Dive | ⬜ |
| WPC-02 | wordpress-com-domains | WordPress.com Deep Dive | ⬜ |
| WPC-03 | wordpress-com-email | WordPress.com Deep Dive | ⬜ |
| WPC-04 | wordpress-com-themes | WordPress.com Deep Dive | ⬜ |
| WPC-05 | wordpress-com-reader | WordPress.com Deep Dive | ⬜ |
| WPC-06 | wordpress-com-migrations | WordPress.com Deep Dive | ⬜ |
| J-01 | jetpack-connection-mastery | Jetpack Deep Dive | ⬜ |
| J-02 | jetpack-backup-mastery | Jetpack Deep Dive | ⬜ |
| J-03 | jetpack-security-waf | Jetpack Deep Dive | ⬜ |
| J-04 | jetpack-performance-cdn | Jetpack Deep Dive | ⬜ |
| J-05 | jetpack-social-subscriptions | Jetpack Deep Dive | ⬜ |
| J-06 | jetpack-crm-search | Jetpack Deep Dive | ⬜ |
| TBL-01 | tumblr-fundamentals | Produits Automattic | ⬜ |
| TBL-02 | tumblr-themes-dev | Produits Automattic | ⬜ |
| GRV-01 | gravatar-mastery | Produits Automattic | ⬜ |
| SNOTE-01 | simplenote-mastery | Produits Automattic | ⬜ |
| PC-01 | pocketcasts-mastery | Produits Automattic | ⬜ |
| P2-01 | p2-culture-automattic | Produits Automattic | ⬜ |
| PLAY-01 | wordpress-playground | Produits Automattic | ⬜ |
| HE-01 | ticket-simulation-wordpress-com | HE Simulations | ⬜ |
| HE-02 | ticket-simulation-jetpack | HE Simulations | ⬜ |
| HE-03 | ticket-simulation-woocommerce | HE Simulations | ⬜ |
| HE-04 | ticket-simulation-domains-dns | HE Simulations | ⬜ |
| HE-05 | ticket-simulation-account-security | HE Simulations | ⬜ |
| HE-06 | soft-skills-support | HE Simulations | ⬜ |
| HE-WC-01 | paiements-stripe-paypal (7 scénarios) | WooCommerce HE | ⬜ |
| HE-WC-02 | gestion-commandes (6 scénarios) | WooCommerce HE | ⬜ |
| HE-WC-03 | produits-catalogue (5 scénarios) | WooCommerce HE | ⬜ |
| HE-WC-04 | livraison-taxes (5 scénarios) | WooCommerce HE | ⬜ |
| HE-WC-05 | checkout-panier (5 scénarios) | WooCommerce HE | ⬜ |
| HE-WC-06 | comptes-clients (3 scénarios) | WooCommerce HE | ⬜ |
| HE-WC-07 | abonnements (3 scénarios) | WooCommerce HE | ⬜ |
| HE-WC-08 | performance-technique (4 scénarios) | WooCommerce HE | ⬜ |
| HE-WC-09 | integrations-extensions (5 scénarios) | WooCommerce HE | ⬜ |
| HE-WC-10 | wordpress-com-ecommerce (5 scénarios) | WooCommerce HE | ⬜ |

**62 projets · 13 phases · 50 scénarios HE WooCommerce · De zéro à Happiness Engineer Automattic**

---

## PHASE 13 — WooCommerce HE Scenarios (Tickets réels)

> Ces scénarios couvrent les situations qu'un Happiness Engineer rencontre au quotidien sur WooCommerce.
> Format : **Symptôme → Diagnostic → Solution → Réponse client**

---

### PROJET HE-WC-01 — Paiements & Passerelles de paiement ⬜

#### Stripe

**Scénario 1 — Paiement refusé alors que la carte est valide**
- Symptôme : client dit "ma carte est correcte mais elle est refusée"
- Diagnostic : vérifier les logs Stripe → Dashboard Stripe → Events & logs
- Causes possibles :
  - Carte non supportée dans le pays du marchand
  - 3D Secure requis mais non configuré
  - Stripe Radar a bloqué la transaction (règles anti-fraude)
- Solution : vérifier l'event dans le Dashboard Stripe, lire le `decline_code` (`insufficient_funds`, `card_not_supported`, `authentication_required`)
- Réponse client : "La carte a été refusée par votre banque. Le code d'erreur est [X]. Veuillez contacter votre banque ou essayer une autre carte."

**Scénario 2 — Paiement visible dans Stripe mais commande absente de WooCommerce**
- Symptôme : client a été débité, mais aucune commande dans WooCommerce
- Diagnostic : webhook Stripe non reçu par WooCommerce
- Vérifier : WooCommerce → Status → Logs → woocommerce-gateway-stripe
- Vérifier les webhooks : Dashboard Stripe → Developers → Webhooks → voir les erreurs
- Solution : réenregistrer le webhook depuis WooCommerce → Settings → Payments → Stripe → Configure
- Si le paiement est réel sans commande : créer manuellement la commande et noter le PaymentIntent ID

**Scénario 3 — Double facturation client**
- Symptôme : client facturé deux fois pour une seule commande
- Diagnostic : vérifier si deux commandes existent dans WooCommerce
- Causes : client a cliqué deux fois sur "Place order", bug frontend avec JS
- Solution : rembourser la commande en double depuis Stripe Dashboard ou WooCommerce → Order → Refund
- Prévention : activer la protection anti-double-clic Stripe (idempotency key — automatique dans le plugin)

**Scénario 4 — Webhooks Stripe ne fonctionnent pas**
```bash
# Vérifier les logs WooCommerce
sudo /usr/local/bin/wp option get woocommerce_stripe_settings --allow-root --path=/var/www/monsite
# Chercher l'URL du webhook dans les logs Stripe
# Tester le webhook manuellement depuis Stripe Dashboard → Send test webhook
```

**Scénario 5 — Apple Pay / Google Pay n'apparaît pas au checkout**
- Cause 1 : site sans HTTPS (requis obligatoirement)
- Cause 2 : navigateur non compatible (Chrome pour Google Pay, Safari pour Apple Pay)
- Cause 3 : domaine non enregistré dans Stripe (Apple Pay domain verification)
- Solution : vérifier le fichier de vérification Apple Pay sur le serveur : `/.well-known/apple-developer-merchantid-domain-association`

**Scénario 6 — Erreur "Your card was declined" en mode production avec Stripe**
- Différencier : clés test vs production mélangées
```bash
sudo /usr/local/bin/wp option get woocommerce_stripe_settings --allow-root --path=/var/www/monsite | grep -i "testmode\|publishable_key"
```
- Si `testmode = yes` avec clés live → corriger dans WooCommerce → Settings → Payments → Stripe

**Scénario 7 — 3D Secure échoue et bloque la transaction**
- Cause : plugin de sécurité bloque l'iframe 3DS (Content Security Policy trop stricte)
- Solution : ajuster le header CSP dans Nginx pour autoriser `js.stripe.com` et `hooks.stripe.com`
```nginx
add_header Content-Security-Policy "frame-src 'self' https://js.stripe.com https://hooks.stripe.com;";
```

#### PayPal

**Scénario 8 — Commande PayPal bloquée en "Pending"**
- Cause : paiement PayPal en attente de confirmation (eCheck, litige ouvert)
- Diagnostic : se connecter au compte PayPal Sandbox/Production → voir le statut du paiement
- Solution : si eCheck → attendre la compensation (3-5 jours ouvrés). Expliquer au client.

**Scénario 9 — IPN PayPal ne met pas à jour le statut de commande**
- Cause : IPN (Instant Payment Notification) bloqué par le firewall ou URL mal configurée
- Solution : vérifier l'URL IPN dans PayPal → Account Settings → Notifications

---

### PROJET HE-WC-02 — Gestion des commandes ⬜

**Scénario 10 — Commande bloquée en "Pending" depuis des heures**
- Cause 1 : client a abandonné le checkout sans payer
- Cause 2 : webhook de paiement manqué → commande jamais mise à jour
- Diagnostic :
```bash
mysql -u monsite_user -p'WordPress2025!' -e "
  SELECT id, status, date_created_gmt, total_amount
  FROM monsite_db.wp_wc_orders
  WHERE status = 'wc-pending'
  ORDER BY date_created_gmt DESC LIMIT 10;"
```
- Solution : si le paiement est confirmé dans Stripe, mettre la commande en "Processing" manuellement

**Scénario 11 — Client dit avoir commandé mais aucune commande trouvée**
- Causes : commande en "Failed" (paiement refusé), commande sous un autre email, multisite (mauvais site)
- Diagnostic : chercher par email dans WooCommerce → Orders → Search ou en DB :
```bash
mysql -u monsite_user -p'WordPress2025!' -e "
  SELECT id, status, billing_email, total_amount
  FROM monsite_db.wp_wc_orders
  WHERE billing_email = 'client@example.com';"
```

**Scénario 12 — Emails de commande non reçus par le client**
- Diagnostic rapide : WooCommerce → Settings → Emails → vérifier les emails actifs
- Tester l'envoi : WooCommerce → Orders → [commande] → Resend email
- Si l'email ne part pas : configurer WP Mail SMTP
- Si l'email part mais va en spam : vérifier SPF/DKIM/DMARC

**Scénario 13 — Client reçoit l'email admin au lieu de l'email client**
- Cause : adresse email admin = adresse email client (compte test)
- Solution : changer l'email admin WordPress (Settings → General → Admin Email)

**Scénario 14 — Remboursement impossible via WooCommerce**
- Cause 1 : délai Stripe dépassé (120 jours max pour un remboursement via API)
- Cause 2 : fonds insuffisants sur le compte Stripe
- Solution : rembourser directement depuis le Dashboard Stripe → Payments → [paiement] → Refund

**Scénario 15 — Client veut annuler une commande déjà expédiée**
- Politique : pas de remboursement automatique si déjà expédié
- Procédure : créer un remboursement manuel dans WooCommerce → Order → Refund
- Ne pas marquer "Restock" si le produit ne revient pas physiquement

---

### PROJET HE-WC-03 — Produits & Catalogue ⬜

**Scénario 16 — Produit en rupture de stock alors que le stock a été rechargé**
- Cause : cache WooCommerce ou transient périmé
```bash
sudo /usr/local/bin/wp wc tool run clear_transients --user=1 --allow-root --path=/var/www/monsite
sudo /usr/local/bin/wp cache flush --allow-root --path=/var/www/monsite
```
- Vérifier le stock en DB :
```bash
mysql -u monsite_user -p'WordPress2025!' -e "
  SELECT post_id, meta_key, meta_value
  FROM monsite_db.wp_postmeta
  WHERE post_id = 13 AND meta_key IN ('_stock', '_stock_status', '_manage_stock');"
```

**Scénario 17 — Prix de variation ne s'affiche pas**
- Cause : aucun prix défini sur les variations
- Diagnostic : WooCommerce → Products → [produit variable] → Variations → vérifier que chaque variation a un prix
- Fix WP-CLI : vérifier les métadonnées de variation en DB

**Scénario 18 — Image de produit ne s'affiche pas après migration**
- Cause : URLs des images pointent vers l'ancien domaine
```bash
sudo /usr/local/bin/wp media regenerate --allow-root --path=/var/www/monsite
sudo /usr/local/bin/wp search-replace 'http://ancien-domaine.com' 'http://nouveau-domaine.com' --allow-root --path=/var/www/monsite
```

**Scénario 19 — Prix promotionnel non appliqué**
- Cause : date de fin de promotion dépassée, coupon mal configuré, prix en solde non sauvegardé
- Vérifier en DB :
```bash
mysql -u monsite_user -p'WordPress2025!' -e "
  SELECT meta_key, meta_value FROM monsite_db.wp_postmeta
  WHERE post_id = 13 AND meta_key IN ('_sale_price', '_regular_price', '_sale_price_dates_from', '_sale_price_dates_to');"
```

**Scénario 20 — Produit téléchargeable : lien de téléchargement expiré**
- Cause : limite de téléchargements atteinte ou délai d'expiration dépassé
- Solution : WooCommerce → Orders → [commande] → réinitialiser le lien de téléchargement
- Ou étendre la limite via le profil client : WooCommerce → Customers → [client] → Downloads

---

### PROJET HE-WC-04 — Livraison & Taxes ⬜

**Scénario 21 — Aucune méthode de livraison au checkout**
- Causes : aucune zone de livraison configurée pour le pays du client, adresse de livraison manquante
- Diagnostic : WooCommerce → Settings → Shipping → Shipping zones
- Solution : créer une zone "Reste du monde" avec tarif flat rate comme fallback

**Scénario 22 — Livraison gratuite ne se déclenche pas**
- Cause : coupon "free shipping" mal configuré ou montant minimum non atteint
- Vérifier : WooCommerce → Settings → Shipping → [zone] → Free Shipping → Minimum order amount

**Scénario 23 — Frais de port calculés incorrectement**
- Cause : poids/dimensions produit mal configurés ou unités incorrectes (g vs kg)
- Vérifier : WooCommerce → Settings → Products → Measurements units

**Scénario 24 — TVA calculée de façon incorrecte**
- Causes : taux de taxe mal configuré, mauvaise classe de taxe, adresse de facturation vs livraison
- Vérifier : WooCommerce → Settings → Tax
- Pour EU VAT : vérifier que les règles sont configurées par pays (destination-based)

**Scénario 25 — Client professionnel facturé avec TVA (devrait être exonéré)**
- Solution : installer un plugin de validation de numéro TVA intracommunautaire
- Ou créer un rôle utilisateur "Professional" sans taxe

---

### PROJET HE-WC-05 — Checkout & Panier ⬜

**Scénario 26 — Checkout ne se soumet pas (bouton "Place Order" inactif)**
- Cause : conflit JavaScript entre plugins
- Diagnostic : Console JavaScript du navigateur (F12) → chercher les erreurs JS
- Méthode bisection : désactiver les plugins un par un pour isoler le conflit
```bash
sudo /usr/local/bin/wp plugin deactivate --all --allow-root --path=/var/www/monsite
# Réactiver un par un pour isoler
sudo /usr/local/bin/wp plugin activate woocommerce --allow-root --path=/var/www/monsite
```

**Scénario 27 — Coupon de réduction non accepté**
- Causes : coupon expiré, nombre d'utilisations épuisé, restrictions (email, produit, catégorie)
- Vérifier en DB :
```bash
mysql -u monsite_user -p'WordPress2025!' -e "
  SELECT p.post_title, pm.meta_key, pm.meta_value
  FROM monsite_db.wp_posts p
  JOIN monsite_db.wp_postmeta pm ON p.ID = pm.post_id
  WHERE p.post_type = 'shop_coupon'
  AND pm.meta_key IN ('discount_type', 'coupon_amount', 'usage_count', 'usage_limit', 'date_expires');"
```

**Scénario 28 — Panier vide après redirection vers PayPal**
- Cause : cookie de session WooCommerce non maintenu (conflit HTTPS/HTTP, SameSite cookie)
- Solution : activer HTTPS partout, vérifier les paramètres du cookie de session WordPress

**Scénario 29 — Page checkout retourne 404**
- Cause : page WooCommerce "Checkout" supprimée ou slug modifié
- Solution : WooCommerce → Settings → Advanced → vérifier les pages WooCommerce
```bash
sudo /usr/local/bin/wp option get woocommerce_checkout_page_id --allow-root --path=/var/www/monsite
```

**Scénario 30 — Client ne peut pas modifier la quantité dans le panier**
- Cause : thème ou plugin personnalisé a désactivé les champs de quantité
- Solution : vérifier les hooks WooCommerce `woocommerce_cart_item_quantity`

---

### PROJET HE-WC-06 — Comptes clients & My Account ⬜

**Scénario 31 — Client ne peut pas se connecter à "My Account"**
- Cause 1 : email utilisé ≠ email du compte WooCommerce
- Cause 2 : mot de passe oublié
- Cause 3 : compte WooCommerce désactivé (role incorrect)
- Diagnostic :
```bash
sudo /usr/local/bin/wp user get client@example.com --allow-root --path=/var/www/monsite
```

**Scénario 32 — Client ne voit pas ses commandes dans "My Account"**
- Cause : commande passée en tant que guest (non connecté), email différent
- Solution : associer la commande au compte :
```bash
sudo /usr/local/bin/wp post meta update [ORDER_ID] _customer_user [USER_ID] --allow-root --path=/var/www/monsite
```

**Scénario 33 — Email de réinitialisation de mot de passe non reçu**
- Cause 1 : SMTP mal configuré
- Cause 2 : email dans les spams
- Solution temporaire : réinitialiser via WP-CLI
```bash
sudo /usr/local/bin/wp user update client@example.com --user_pass="TempPass123!" --allow-root --path=/var/www/monsite
```

---

### PROJET HE-WC-07 — Abonnements WooCommerce ⬜

**Scénario 34 — Abonnement pas renouvelé automatiquement**
- Cause principale : wp-cron désactivé ou ne se déclenche pas
- Diagnostic :
```bash
# Vérifier le cron système
sudo crontab -l
# Vérifier que wp-cron est activé
grep -i "DISABLE_WP_CRON" /var/www/monsite/wp-config.php
# Déclencher manuellement
sudo /usr/local/bin/wp cron event run --due-now --allow-root --path=/var/www/monsite
```
- Solution : configurer un cron système au lieu de wp-cron
```bash
# Ajouter au crontab
*/5 * * * * curl -s http://192.168.11.103/wp-cron.php?doing_wp_cron > /dev/null 2>&1
```

**Scénario 35 — Client annule son abonnement et veut un remboursement prorata**
- WooCommerce Subscriptions supporte les remboursements au prorata
- Calculer : (jours restants / jours totaux) × montant payé
- Créer le remboursement manuellement via WooCommerce → Subscriptions → [abonnement] → Refund

**Scénario 36 — Paiement de renouvellement échoué (carte expirée)**
- WooCommerce Subscriptions envoie des emails de rappel automatiques
- Configurer la politique de réessai : Settings → Subscriptions → Retry Rules
- Donner au client X jours pour mettre à jour sa carte

---

### PROJET HE-WC-08 — Performance & Technique avancée ⬜

**Scénario 37 — Page checkout très lente (5+ secondes)**
- Diagnostic avec Query Monitor : combien de requêtes SQL sur la page checkout ?
- Causes fréquentes :
  - Trop de plugins actifs
  - Requêtes WooCommerce non optimisées (sessions orphelines en DB)
- Nettoyer les sessions WooCommerce :
```bash
sudo /usr/local/bin/wp wc tool run cleanup_sessions --user=1 --allow-root --path=/var/www/monsite
```
- Vérifier la taille de la table des sessions :
```bash
mysql -u monsite_user -p'WordPress2025!' -e "
  SELECT COUNT(*) as sessions, SUM(LENGTH(session_value))/1024/1024 as size_mb
  FROM monsite_db.wp_woocommerce_sessions;"
```

**Scénario 38 — Erreur 500 après mise à jour WooCommerce**
- Activer le debug :
```bash
sudo grep -n "WP_DEBUG" /var/www/monsite/wp-config.php
# Si absent, ajouter :
sudo /usr/local/bin/wp config set WP_DEBUG true --raw --allow-root --path=/var/www/monsite
sudo /usr/local/bin/wp config set WP_DEBUG_LOG true --raw --allow-root --path=/var/www/monsite
```
- Lire le log :
```bash
sudo tail -f /var/www/monsite/wp-content/debug.log
```
- Méthode : désactiver tous les plugins sauf WooCommerce, puis réactiver un par un

**Scénario 39 — HPOS : migration des données de commandes**
- WooCommerce 8+ stocke les commandes dans `wp_wc_orders` (HPOS) au lieu de `wp_posts`
- Vérifier le statut de la migration HPOS :
```bash
sudo /usr/local/bin/wp wc hpos --allow-root --path=/var/www/monsite
```
- Si erreur de migration : WooCommerce → Status → Tools → Orders Migration

**Scénario 40 — Base de données WooCommerce trop grosse**
- Identifier les plus grosses tables :
```bash
mysql -u monsite_user -p'WordPress2025!' -e "
  SELECT table_name, ROUND(((data_length + index_length) / 1024 / 1024), 2) AS 'Size (MB)'
  FROM information_schema.TABLES
  WHERE table_schema = 'monsite_db'
  ORDER BY (data_length + index_length) DESC LIMIT 10;"
```
- Nettoyer les données obsolètes :
```bash
sudo /usr/local/bin/wp wc tool run delete_orphaned_variations --user=1 --allow-root --path=/var/www/monsite
sudo /usr/local/bin/wp wc tool run clear_expired_transients --user=1 --allow-root --path=/var/www/monsite
```

---

### PROJET HE-WC-09 — Intégrations & Extensions ⬜

**Scénario 41 — WooCommerce Payments (Woo's own gateway) ne s'active pas**
- Problème : WooCommerce Payments requiert une connexion à Woo.com/WordPress.com
- Solution : connecter Jetpack en premier, puis activer WooCommerce Payments

**Scénario 42 — Extension premium WooCommerce — licence expirée**
- Symptôme : les mises à jour ne s'installent plus, avertissement "licence invalide"
- Solution : renouveler la licence sur woo.com, entrer la nouvelle clé dans WooCommerce → Extensions

**Scénario 43 — Conflit entre WooCommerce et un plugin de cache**
- Symptôme : panier vide, prix incorrect, stock non mis à jour pour certains clients
- Cause : le plugin de cache sert une version cachée de la page panier/checkout
- Solution : exclure les pages WooCommerce du cache (cart, checkout, my-account)
```nginx
# Dans Nginx — exclure le cache WooCommerce
if ($request_uri ~* "(/cart/|/checkout/|/my-account/|/wc-api/)") {
    set $skip_cache 1;
}
```

**Scénario 44 — WooCommerce REST API — permission refusée**
- Diagnostic : tester l'API
```bash
curl -u consumer_key:consumer_secret https://192.168.11.103/wp-json/wc/v3/orders
```
- Causes : clé API WooCommerce avec permissions "Read" seulement, permaliens non rechargés
- Solution : WooCommerce → Settings → Advanced → REST API → créer une nouvelle clé avec permissions "Read/Write"

**Scénario 45 — Intégration comptable (QuickBooks, Xero) ne sync pas les commandes**
- Cause : webhook WooCommerce mal configuré pour l'outil comptable
- Vérifier : WooCommerce → Settings → Advanced → Webhooks
- Tester le webhook manuellement et vérifier les logs de livraison

---

### PROJET HE-WC-10 — Scénarios WordPress.com eCommerce Plan ⬜

Le plan **WordPress.com eCommerce** est WooCommerce hébergé sur WordPress.com.
Les HE de WordPress.com supportent aussi ce plan.

**Scénario 46 — Boutique WordPress.com eCommerce — produit ne s'affiche pas**
- Même diagnostic qu'en self-hosted mais sans accès SSH
- Utiliser WP-CLI via le terminal WordPress.com (Business plan+)
- Vérifier la visibilité catalogue depuis WooCommerce → Products → [produit] → Catalog Visibility

**Scénario 47 — Frais de transaction sur WordPress.com eCommerce**
- Le plan eCommerce a 0% de frais de transaction (avantage vs Business)
- Expliquer la différence au client : Business = 0% mais pas de WooCommerce natif, eCommerce = WooCommerce intégré

**Scénario 48 — Migration boutique vers WordPress.com eCommerce**
- Exporter les produits depuis l'ancien site en CSV
- Importer via WooCommerce → Products → Import
- Exporter/importer les commandes via WooCommerce → Orders → Export
- Les médias : utiliser l'outil d'import médias WordPress.com

**Scénario 49 — Limites du plan WordPress.com eCommerce vs VIP**
- eCommerce : WooCommerce complet, plugins approuvés uniquement
- VIP : pas de WooCommerce natif, architecture custom, pour les grandes entreprises
- Savoir quand recommander VIP au lieu d'eCommerce

**Scénario 50 — Client veut installer un plugin WooCommerce non disponible sur WordPress.com**
- Problème : WordPress.com eCommerce limite les plugins aux extensions approuvées
- Solution : recommander self-hosted (passer par Jetpack) ou trouver une alternative approuvée

---

## Ce que ce roadmap prouve à Automattic

| Compétence demandée | Projets qui le prouvent |
|--------------------|------------------------|
| WordPress.com hands-on (plateforme principale) | A-01, WPC-01 à WPC-06 |
| WordPress self-hosted (fondations) | WP-01 à WP-10 |
| Jetpack — tous les modules | A-04, J-01 à J-06 |
| WooCommerce complet | WC-01 à WC-05, A-06 à A-08 |
| Tumblr (produit Automattic) | TBL-01, TBL-02 |
| Akismet (produit Automattic) | A-05 |
| Gravatar (produit Automattic) | GRV-01 |
| Simplenote (produit Automattic) | SNOTE-01 |
| Pocket Casts (produit Automattic) | PC-01 |
| P2 et culture Automattic | P2-01 |
| WordPress Playground | PLAY-01 |
| Domaines & DNS | WPC-02, HE-04 |
| Email & délivrabilité | WPC-03, A-11 |
| Jetpack connection troubleshooting | J-01, HE-02 |
| Jetpack Backup & restore | J-02 |
| Jetpack Security & WAF | J-03 |
| Tickets WordPress.com simulation | HE-01 |
| Tickets WooCommerce simulation | HE-03 |
| Tickets sécurité de compte | HE-05 |
| Communication et soft skills | HE-06 |
| REST API WordPress | A-02 |
| Gutenberg / Full Site Editing | A-03, WPC-04 |
| Performance & optimisation | WP-06, WP-07, J-04, WC-04 |
| Backup & disaster recovery | WP-05, J-02, WC-03, A-04 |
| Migration (vers/depuis WordPress.com) | WP-10, WPC-06, A-12 |
| WP-CLI & automatisation | WP-02 |
| Infrastructure Linux | WP-01, WP-07, WP-09 |
| Monitoring | WP-08 |
| Debugging avancé | A-09, A-10 |
