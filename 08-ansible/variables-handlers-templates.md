# Ansible — Variables, Handlers, Templates

## Objectif

Éviter le hardcoding dans les roles Ansible en utilisant des variables, déclencher des redémarrages de services uniquement quand nécessaire avec les handlers, et générer des fichiers de configuration dynamiques avec les templates Jinja2.

---

## Variables

### Problème sans variables

```yaml
- name: Install Nginx
  dnf:
    name: nginx  # hardcodé — impossible à réutiliser
```

### Solution : defaults/main.yml

Chaque role a un répertoire `defaults/` contenant les valeurs par défaut :

```
roles/nginx/
├── defaults/
│   └── main.yml    ← variables ici
├── tasks/
│   └── main.yml
```

```yaml
# roles/nginx/defaults/main.yml
nginx_package: nginx
nginx_service: nginx
nginx_worker_processes: auto
```

### Utilisation dans les tasks

Les variables Jinja2 s'écrivent entre doubles accolades. Quand la valeur **commence** par `{{`, elle doit être entre guillemets :

```yaml
- name: Install Nginx
  dnf:
    name: "{{ nginx_package }}"
    state: present

- name: Start nginx
  service:
    name: "{{ nginx_service }}"
    state: started
    enabled: true
```

**Règle :** Ne jamais utiliser de tiret dans un nom de variable Ansible — utiliser des underscores.

```yaml
# ❌ incorrect
php-fpm_service: php-fpm

# ✅ correct
php_fpm_service: php-fpm
```

---

## Handlers

### Problème sans handler

Redémarrer nginx à chaque run du playbook — même quand la config n'a pas changé — coupe les connexions actives inutilement.

### Solution : handlers/main.yml

Un handler est une task qui ne s'exécute que si elle est **notifiée** par une autre task ayant reporté `changed`.

```
roles/nginx/
├── defaults/main.yml
├── handlers/
│   └── main.yml    ← handler ici
├── tasks/main.yml
```

```yaml
# roles/nginx/handlers/main.yml
- name: restart nginx
  service:
    name: "{{ nginx_service }}"
    state: restarted
```

### Notifier le handler depuis une task

```yaml
- name: Copy nginx config
  template:
    src: nginx.conf.j2
    dest: /etc/nginx/nginx.conf
  notify: restart nginx   # ← doit correspondre exactement au name du handler
```

### Comportement

```
Config inchangée → copy task : ok  → handler non déclenché → pas de restart
Config modifiée  → copy task : changed → handler déclenché → nginx redémarre
```

---

## Templates Jinja2

### Problème avec le module copy

Le module `copy` copie un fichier statique — identique sur tous les serveurs. Avec 50 serveurs ayant des configs différentes, il faudrait 50 fichiers.

### Solution : module template

Le module `template` traite le fichier source avec Jinja2 avant de le copier — les variables sont remplacées par leurs valeurs au moment du déploiement.

```
roles/nginx/
├── defaults/main.yml
├── files/          ← fichiers statiques (copy)
├── handlers/main.yml
├── tasks/main.yml
├── templates/
│   └── nginx.conf.j2   ← template Jinja2 ici
```

### Créer un template

```bash
cp /etc/nginx/nginx.conf roles/nginx/templates/nginx.conf.j2
```

Remplacer les valeurs hardcodées par des variables :

```nginx
# nginx.conf.j2
worker_processes {{ nginx_worker_processes }};
```

### Utiliser le module template dans les tasks

```yaml
- name: Deploy nginx config
  template:
    src: nginx.conf.j2          # dans roles/nginx/templates/
    dest: /etc/nginx/nginx.conf
  notify: restart nginx
```

### Vérification

Changer `nginx_worker_processes: auto` en `nginx_worker_processes: 2` dans `defaults/main.yml` puis relancer le playbook :

```
TASK [nginx : Copy nginx config] → changed
RUNNING HANDLER [nginx : restart nginx] → changed
```

```bash
grep worker_processes /etc/nginx/nginx.conf
# worker_processes 2;
```

---

## Structure finale du role nginx

```
roles/nginx/
├── defaults/
│   └── main.yml          # nginx_package, nginx_service, nginx_worker_processes
├── files/
│   └── nginx.conf        # fichier statique de référence
├── handlers/
│   └── main.yml          # restart nginx
├── tasks/
│   └── main.yml          # install, start, deploy config
└── templates/
    └── nginx.conf.j2     # template avec variables Jinja2
```

---

## Ce que j'ai appris

- `defaults/main.yml` centralise les valeurs — une seule modification impacte tout le role
- Les variables avec tiret (`php-fpm_service`) causent des erreurs — toujours utiliser des underscores
- Un handler ne s'exécute jamais si la task qui le notifie ne reporte pas `changed` — idempotence garantie
- La source de vérité est le repo, pas le serveur — toujours modifier le template, jamais `/etc/nginx/nginx.conf` directement
- `template` > `copy` dès qu'une valeur peut varier selon le serveur ou l'environnement
