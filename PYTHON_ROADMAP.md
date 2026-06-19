# Roadmap Python — Objectif SysAdmin & Happiness Engineer Automattic

Parcours pratique Python orienté vers deux objectifs concrets :
- **Automatisation SysAdmin** (RHCSA, scripts système, monitoring)
- **Écosystème Automattic** (WordPress REST API, WooCommerce, Jetpack, Akismet)

Chaque projet est public sur GitHub avec un livrable concret.

---

## Pourquoi Python pour ces objectifs ?

| Besoin | Python résout ça avec |
|--------|----------------------|
| Automatiser des tâches système | `os`, `subprocess`, `pathlib`, `cron` |
| Parser des logs Nginx/Apache | `re`, `json`, lecture de fichiers |
| Interagir avec l'API WordPress | `requests`, JSON, authentification |
| Gérer WooCommerce programmatiquement | WooCommerce REST API v3 |
| Envoyer des rapports par email | `smtplib`, `email` |
| Créer des outils CLI | `argparse`, `click` |
| Recevoir des webhooks WooCommerce/Stripe | `Flask` |

---

## PHASE 1 — Fondamentaux Python

### PROJET PY-01 — python-basics ⬜
> Variables, types, conditions, boucles — passer de Bash à Python

Si tu sais Bash, Python est naturel. Ce projet t'aide à faire la transition.

**Concepts :**
- Types de données : `str`, `int`, `float`, `bool`, `None`
- Conditions : `if / elif / else`
- Boucles : `for`, `while`, `range()`, `enumerate()`
- Input utilisateur : `input()`, conversion de types
- Différence Bash vs Python : syntaxe, indentation obligatoire, typage

**Exercices pratiques :**
1. Script qui demande ton nom et affiche un message de bienvenue
2. Script qui calcule si un nombre est pair ou impair
3. Script qui affiche les nombres de 1 à 100, mais "Fizz" si divisible par 3, "Buzz" par 5
4. Script qui convertit des températures Celsius → Fahrenheit
5. Script qui demande un mot de passe et vérifie s'il est assez fort (8+ chars, majuscule, chiffre)

**Livrable :** Repo `python-basics` avec les 5 scripts commentés

---

### PROJET PY-02 — python-functions ⬜
> Fonctions, modules, imports

**Concepts :**
- Définir des fonctions : `def`, paramètres, valeurs par défaut, `return`
- Portée des variables : locale vs globale
- Modules standard : `math`, `random`, `datetime`, `sys`
- Créer ses propres modules : séparer le code en fichiers
- `if __name__ == "__main__"` : comprendre ce pattern essentiel

**Exercices pratiques :**
1. Fonction `calculer_tva(prix, taux=20)` → retourne le prix TTC
2. Fonction `generer_mot_de_passe(longueur=12)` → mot de passe aléatoire sécurisé
3. Fonction `formater_date(timestamp)` → retourne "19 juin 2026 à 14h30"
4. Module `utils.py` avec 3 fonctions utilitaires importé depuis un script principal
5. Script avec `argparse` qui accepte `--nom` et `--age` en arguments CLI

**Livrable :** Repo `python-functions` avec module utils + script CLI

---

### PROJET PY-03 — python-data-structures ⬜
> Listes, dictionnaires, ensembles, tuples

Ce sont les structures les plus utilisées en Python — incontournables.

**Concepts :**
- Listes : `append()`, `remove()`, `sort()`, `slice`, compréhensions
- Dictionnaires : `keys()`, `values()`, `items()`, `get()`, nested dicts
- Ensembles (sets) : unicité, union, intersection, différence
- Tuples : immuabilité, unpacking
- JSON : lien direct avec les dicts Python

**Exercices pratiques :**
1. Gérer une liste de plugins WordPress : ajouter, supprimer, trier, filtrer les actifs
2. Dictionnaire d'un utilisateur WordPress : nom, email, rôle, date d'inscription
3. Compter les occurrences d'erreurs dans une liste de logs
4. Lire un fichier JSON de configuration et accéder à ses valeurs
5. Trouver les plugins en commun entre deux sites WordPress (set intersection)

**Livrable :** Repo `python-data-structures` avec 5 exercices documentés

---

### PROJET PY-04 — python-files-json ⬜
> Manipulation de fichiers et JSON

**Concepts :**
- Lire et écrire des fichiers texte : `open()`, `read()`, `write()`, `with`
- Fichiers CSV : module `csv`, lecture et écriture
- Fichiers JSON : `json.load()`, `json.dump()`, `json.loads()`, `json.dumps()`
- Chemins de fichiers : `pathlib.Path` — méthode moderne
- Gestion des erreurs fichiers : `FileNotFoundError`, `PermissionError`

**Exercices pratiques :**
1. Lire un fichier de logs Nginx et compter les codes HTTP (200, 404, 500)
2. Écrire les résultats dans un fichier CSV rapport
3. Lire un export JSON de l'API WordPress et afficher les titres des articles
4. Script qui trouve tous les fichiers `.log` dans `/var/log` et leur taille
5. Convertir un CSV de produits WooCommerce en JSON formaté

**Livrable :** Repo `python-files-json` avec parseur de logs Nginx + convertisseur CSV→JSON

---

### PROJET PY-05 — python-errors-regex ⬜
> Gestion d'erreurs et expressions régulières

**Concepts :**
- Exceptions : `try / except / finally / else`
- Exceptions courantes : `ValueError`, `KeyError`, `TypeError`, `ConnectionError`
- Lever ses propres exceptions : `raise`
- Regex avec `re` : `re.search()`, `re.findall()`, `re.sub()`, groupes capturants
- Patterns utiles : emails, IPs, URLs, dates, codes HTTP

**Exercices pratiques :**
1. Valider qu'une adresse email est correcte avec une regex
2. Extraire toutes les IPs d'un fichier de logs Nginx
3. Trouver tous les codes d'erreur 5XX dans un log Apache
4. Script qui valide une clé API WordPress (format attendu)
5. Parser une URL WordPress et extraire : domaine, slug, paramètres

**Livrable :** Repo `python-errors-regex` avec bibliothèque de patterns regex WordPress/Nginx

---

## PHASE 2 — Python pour SysAdmin

### PROJET PY-06 — python-sysadmin-basics ⬜
> Interagir avec le système : `os`, `subprocess`, `pathlib`

**Concepts :**
- `os` : variables d'environnement, `getcwd()`, `listdir()`, `path.exists()`
- `pathlib.Path` : manipulation moderne des chemins
- `subprocess.run()` : exécuter des commandes shell depuis Python
- `shutil` : copier, déplacer, supprimer des fichiers/dossiers
- `glob` : trouver des fichiers par pattern

**Exercices pratiques :**
1. Script qui liste tous les fichiers modifiés dans les dernières 24h dans `/var/www`
2. Script qui exécute `systemctl status nginx` et affiche si le service est actif
3. Script qui vérifie l'espace disque et affiche une alerte si > 80%
4. Script qui copie les fichiers `.log` vers un dossier d'archive
5. Script qui lit les variables d'environnement et génère un rapport

**Livrable :** Repo `python-sysadmin-basics` avec toolkit de vérification système

---

### PROJET PY-07 — python-log-parser ⬜
> Parser des logs Nginx, Apache, PHP — outil de support réel

Un Happiness Engineer a souvent besoin d'analyser des logs rapidement.

**Ce qu'on construit :**
- Parser de logs Nginx : extraire IP, date, méthode, URL, code HTTP, taille
- Statistiques : top 10 IPs, top 10 URLs, distribution des codes HTTP
- Filtrer par code d'erreur : `--errors 500` affiche uniquement les 500
- Filtrer par date : `--date 2026-06-19` affiche les logs du jour
- Exporter en CSV ou JSON

**Commandes du script :**
```bash
python log-parser.py /var/log/nginx/access.log --errors 500
python log-parser.py /var/log/nginx/access.log --top-ips 10
python log-parser.py /var/log/nginx/access.log --date today --export rapport.csv
```

**Livrable :** Script `log-parser.py` avec CLI argparse complet + exemples de logs de test

---

### PROJET PY-08 — python-backup-automation ⬜
> Script de backup WordPress automatisé en Python

Remplace le script Bash de WP-05 par une version Python plus robuste.

**Fonctionnalités :**
- Backup `wp-content` avec `tarfile`
- Export MySQL avec `subprocess` (mysqldump)
- Nom d'archive avec timestamp : `wordpress-2026-06-19-14h30.tar.gz`
- Rétention : supprimer les backups de plus de 7 jours
- Rapport par email : succès/échec, taille du backup
- Logging : chaque action loggée dans `/var/log/wp-backup.log`
- Dry-run mode : `--dry-run` simule sans agir

**Livrable :** Script `wp-backup.py` avec logging, email, rétention et mode dry-run

---

### PROJET PY-09 — python-monitoring ⬜
> Monitoring système avec Python et alertes email

**Ce qu'on monitore :**
- CPU : alerte si > 80% pendant 5 minutes
- RAM : alerte si > 90%
- Disque : alerte si > 85%
- Services : nginx, mariadb, php-fpm — alerte si down
- URL : HTTP check toutes les 5 minutes, alerte si != 200

**Bibliothèques :**
- `psutil` : CPU, RAM, disque, processus
- `requests` : HTTP checks
- `smtplib` : alertes email
- `schedule` : exécuter des tâches à intervalles

**Livrable :** Script `monitor.py` qui tourne en daemon + alertes email configurables

---

### PROJET PY-10 — python-ssh-automation ⬜
> Automatiser des tâches sur des serveurs distants via SSH

**Bibliothèque :** `paramiko`

**Ce qu'on automatise :**
- Connexion SSH avec clé ou mot de passe
- Exécuter des commandes à distance et récupérer la sortie
- Transférer des fichiers (SFTP)
- Script qui déploie une mise à jour WordPress sur plusieurs serveurs
- Script qui vérifie le statut de nginx sur 5 serveurs simultanément

**Livrable :** Script `deploy.py` qui met à jour WordPress sur N serveurs en parallèle

---

## PHASE 3 — Python pour WordPress & Automattic

### PROJET PY-11 — wordpress-api-client ⬜
> Client Python complet pour l'API REST WordPress

C'est le projet clé pour Automattic — maîtriser l'API WordPress en Python.

**Authentication :**
- Application Passwords (WordPress 5.6+)
- Basic Auth avec `requests.auth.HTTPBasicAuth`
- JWT Token (plugin requis)

**Opérations CRUD :**
```python
# Lire tous les posts
GET /wp-json/wp/v2/posts

# Créer un article
POST /wp-json/wp/v2/posts
{"title": "Mon article", "content": "...", "status": "publish"}

# Modifier un utilisateur
PUT /wp-json/wp/v2/users/1
{"name": "Nouveau nom"}

# Supprimer une page
DELETE /wp-json/wp/v2/pages/5
```

**Ce qu'on construit :**
- Classe `WordPressClient` avec méthodes : `get_posts()`, `create_post()`, `update_post()`, `delete_post()`
- Même chose pour : pages, users, categories, tags, media
- Script d'import de contenu depuis un CSV → WordPress
- Script d'export de tous les articles en JSON
- Script qui met à jour le statut de 100 articles en masse

**Livrable :** Package Python `wp-client` avec documentation + exemples d'usage

---

### PROJET PY-12 — woocommerce-api-client ⬜
> Client Python pour l'API REST WooCommerce v3

**Authentication WooCommerce :**
- Consumer Key + Consumer Secret (généré dans WooCommerce → Paramètres → API)
- `woocommerce` package officiel ou `requests` direct

**Opérations :**
```python
from woocommerce import API

wcapi = API(url="http://monsite.com", consumer_key="ck_...", consumer_secret="cs_...")

# Lister les produits
wcapi.get("products").json()

# Créer un produit
wcapi.post("products", {"name": "T-shirt", "price": "29.99", "type": "simple"})

# Mettre à jour le stock
wcapi.put("products/42", {"stock_quantity": 100})

# Lister les commandes du jour
wcapi.get("orders", params={"after": "2026-06-19T00:00:00"}).json()
```

**Ce qu'on construit :**
- Classe `WooCommerceClient` complète
- Script d'import de 50 produits depuis un CSV
- Script de rapport quotidien : commandes, CA, produits les plus vendus
- Script qui identifie les commandes bloquées en "processing" depuis > 24h

**Livrable :** Package `wc-client` + script de rapport quotidien + script d'import

---

### PROJET PY-13 — wordpress-com-api ⬜
> Interagir avec l'API WordPress.com

WordPress.com a sa propre API différente de l'API self-hosted.

**Authentication :**
- OAuth2 : obtenir un access token depuis WordPress.com
- Ou Personal Access Token depuis developer.wordpress.com

**Endpoints WordPress.com :**
```python
# Stats du site
GET https://public-api.wordpress.com/rest/v1.1/sites/{site_id}/stats

# Posts
GET https://public-api.wordpress.com/rest/v1.1/sites/{site_id}/posts

# Followers
GET https://public-api.wordpress.com/rest/v1.1/sites/{site_id}/followers
```

**Ce qu'on construit :**
- Script qui récupère les stats WordPress.com d'un site
- Script qui compare les stats de plusieurs sites
- Script qui publie un article sur WordPress.com depuis Python

**Livrable :** Script `wpcom-stats.py` + rapport HTML généré automatiquement

---

### PROJET PY-14 — akismet-api-client ⬜
> Tester l'API Akismet en Python

**API Akismet :**
- Vérifier une clé API : `POST https://rest.akismet.com/1.1/verify-key`
- Tester un commentaire : `POST https://{api_key}.rest.akismet.com/1.1/comment-check`
- Signaler du spam : `POST https://{api_key}.rest.akismet.com/1.1/submit-spam`
- Signaler un faux positif : `POST https://{api_key}.rest.akismet.com/1.1/submit-ham`

**Ce qu'on construit :**
```python
def check_comment(api_key, blog, comment_content, comment_author, comment_author_email):
    """Retourne True si c'est du spam, False sinon"""
    ...
```

- Script qui teste 10 commentaires différents et affiche le score Akismet
- Comprendre les paramètres : `user_ip`, `user_agent`, `comment_type`

**Livrable :** Module `akismet_client.py` + script de démonstration avec vrais et faux spams

---

### PROJET PY-15 — gravatar-api-client ⬜
> Utiliser l'API Gravatar en Python

**API Gravatar :**
```python
import hashlib

def get_gravatar_url(email, size=200, default="mp"):
    email_hash = hashlib.md5(email.strip().lower().encode()).hexdigest()
    return f"https://www.gravatar.com/avatar/{email_hash}?s={size}&d={default}"

def get_gravatar_profile(email):
    email_hash = hashlib.md5(email.strip().lower().encode()).hexdigest()
    return requests.get(f"https://www.gravatar.com/{email_hash}.json").json()
```

**Ce qu'on construit :**
- Fonction `get_gravatar_url(email)` → URL de l'avatar
- Fonction `get_gravatar_profile(email)` → profil JSON complet
- Script qui prend un CSV d'emails et génère un rapport HTML avec avatars
- Comprendre le hash MD5 et pourquoi c'est une "privacy feature"

**Livrable :** Module `gravatar.py` + script de génération de rapport HTML avec avatars

---

### PROJET PY-16 — webhook-receiver ⬜
> Recevoir et traiter les webhooks WooCommerce et Stripe avec Flask

Les webhooks sont essentiels pour comprendre WooCommerce + Stripe.
Un Happiness Engineer doit savoir les déboguer.

**Ce qu'on construit :**
```python
from flask import Flask, request, jsonify
import hmac, hashlib

app = Flask(__name__)

@app.route("/webhook/woocommerce", methods=["POST"])
def woocommerce_webhook():
    # Vérifier la signature du webhook
    signature = request.headers.get("X-WC-Webhook-Signature")
    # Traiter l'événement
    event = request.json
    if event["action"] == "order.created":
        print(f"Nouvelle commande #{event['id']} — {event['total']} MAD")
    return jsonify({"status": "ok"})

@app.route("/webhook/stripe", methods=["POST"])
def stripe_webhook():
    # Vérifier la signature Stripe
    ...
```

**Événements à gérer :**
- WooCommerce : `order.created`, `order.updated`, `order.deleted`, `product.updated`
- Stripe : `payment_intent.succeeded`, `payment_intent.payment_failed`, `charge.refunded`

**Livrable :** App Flask `webhook-receiver` avec logs, vérification de signature, et replay d'événements

---

## PHASE 4 — Python Avancé pour le Support

### PROJET PY-17 — wordpress-health-checker ⬜
> Outil de diagnostic automatique d'un site WordPress

Ce script simule ce qu'un Happiness Engineer fait manuellement.

**Ce qu'on vérifie automatiquement :**
- Site accessible : HTTP check, code de réponse, temps de réponse
- HTTPS valide : certificat SSL, date d'expiration, chain of trust
- WordPress version : à jour ou non
- Plugins actifs : liste depuis l'API REST
- DNS : A record, MX records, SPF, DKIM
- Headers de sécurité : X-Frame-Options, CSP, HSTS
- Performance : taille de la page, nombre de requêtes
- Robots.txt : site en mode "no-index" ?

**Rapport généré :**
```
=== Rapport WordPress Health Check ===
Site : http://monsite.com
Date : 2026-06-19 14:30

✅ Site accessible (200 OK — 245ms)
✅ HTTPS valide (expire dans 89 jours)
⚠️  WordPress 6.4 — version 6.5 disponible
❌ Header X-Frame-Options manquant
✅ SPF record configuré
❌ DKIM non configuré
...
```

**Livrable :** Script `wp-health-check.py` avec rapport coloré en terminal + export HTML

---

### PROJET PY-18 — email-reporter ⬜
> Envoyer des rapports automatiques par email

**Bibliothèques :**
- `smtplib` : connexion SMTP
- `email.mime` : construire des emails HTML
- `jinja2` : templates HTML pour les rapports

**Ce qu'on construit :**
- Rapport quotidien WordPress : posts publiés, commentaires, backups
- Rapport WooCommerce : commandes du jour, CA, produits en rupture
- Alerte de monitoring : CPU > 80%, service down
- Template HTML professionnel avec Jinja2

**Livrable :** Module `email_reporter.py` + 3 templates HTML + script de rapport quotidien

---

### PROJET PY-19 — cli-support-toolkit ⬜
> Boîte à outils CLI pour le support WordPress

Regroupe tous les scripts précédents dans un seul outil CLI professionnel.

```bash
# Vérifier un site
wp-toolkit check http://monsite.com

# Analyser des logs
wp-toolkit logs /var/log/nginx/access.log --errors 500 --top 10

# Backup
wp-toolkit backup /var/www/monsite --db wordpress --output /var/backups/

# Rapport WooCommerce
wp-toolkit wc-report http://monsite.com --key ck_... --secret cs_...

# Tester un commentaire Akismet
wp-toolkit akismet-check "Ce commentaire est du spam" --email spam@spam.com
```

**Livrable :** Package Python installable `wp-toolkit` avec toutes les commandes

---

### PROJET PY-20 — wordpress-migration-tool ⬜
> Outil de migration WordPress automatisé en Python

**Ce qu'on automatise :**
- Export du site source via l'API REST WordPress
- Transfer SFTP des fichiers `wp-content`
- Export/import de la base de données
- Search-replace des URLs via l'API REST
- Vérification post-migration : liens, images, plugins

**Livrable :** Script `wp-migrate.py` avec rapport de migration complet

---

## Récapitulatif

| # | Projet | Phase | Statut |
|---|--------|-------|--------|
| PY-01 | python-basics | Fondamentaux | ⬜ |
| PY-02 | python-functions | Fondamentaux | ⬜ |
| PY-03 | python-data-structures | Fondamentaux | ⬜ |
| PY-04 | python-files-json | Fondamentaux | ⬜ |
| PY-05 | python-errors-regex | Fondamentaux | ⬜ |
| PY-06 | python-sysadmin-basics | SysAdmin | ⬜ |
| PY-07 | python-log-parser | SysAdmin | ⬜ |
| PY-08 | python-backup-automation | SysAdmin | ⬜ |
| PY-09 | python-monitoring | SysAdmin | ⬜ |
| PY-10 | python-ssh-automation | SysAdmin | ⬜ |
| PY-11 | wordpress-api-client | WordPress & Automattic | ⬜ |
| PY-12 | woocommerce-api-client | WordPress & Automattic | ⬜ |
| PY-13 | wordpress-com-api | WordPress & Automattic | ⬜ |
| PY-14 | akismet-api-client | WordPress & Automattic | ⬜ |
| PY-15 | gravatar-api-client | WordPress & Automattic | ⬜ |
| PY-16 | webhook-receiver | WordPress & Automattic | ⬜ |
| PY-17 | wordpress-health-checker | Avancé | ⬜ |
| PY-18 | email-reporter | Avancé | ⬜ |
| PY-19 | cli-support-toolkit | Avancé | ⬜ |
| PY-20 | wordpress-migration-tool | Avancé | ⬜ |

**20 projets · 4 phases · Python appliqué à WordPress, WooCommerce et SysAdmin**

---

## Ce que ce roadmap prouve

| Compétence | Projets |
|------------|---------|
| Python fondamentaux | PY-01 à PY-05 |
| Automatisation SysAdmin | PY-06 à PY-10 |
| WordPress REST API | PY-11, PY-17, PY-20 |
| WooCommerce REST API | PY-12, PY-16 |
| WordPress.com API | PY-13 |
| Akismet API | PY-14 |
| Gravatar API | PY-15 |
| Webhooks (WooCommerce + Stripe) | PY-16 |
| Outils CLI professionnels | PY-19 |
| Monitoring & alertes | PY-09, PY-17 |
| Email automation | PY-18 |
| SSH automation | PY-10 |
