# Load Balancing avec Nginx

## Objectif

Distribuer le trafic entre plusieurs backends pour éliminer le SPOF (Single Point of Failure) et assurer la continuité de service en cas de panne.

---

## Concepts fondamentaux

### SPOF — Single Point of Failure
Un seul composant dont la panne met tout le système hors ligne.

**Sans HA :**
```
Utilisateur → Serveur unique → SPOF
```

**Avec load balancer :**
```
Utilisateur → Load Balancer → Backend 1
                           → Backend 2
```

### RTO et RPO

| Terme | Définition | Exemple |
|-------|-----------|---------|
| **RTO** (Recovery Time Objective) | Temps maximum acceptable avant que le service reprenne | "max 5 minutes down" |
| **RPO** (Recovery Point Objective) | Quantité maximale de données qu'on peut se permettre de perdre | "max 1 heure de données" |

---

## Configuration Nginx Load Balancer

### Structure du fichier `/etc/nginx/conf.d/loadbalancer.conf`

```nginx
upstream nom_groupe {
    server 127.0.0.1:8081;
    server 127.0.0.1:8082;
}

server {
    listen 80;
    listen [::]:80;
    server_name _;
    location / {
        proxy_pass http://nom_groupe;
    }
}
```

**Points importants :**
- Le bloc `upstream` définit le groupe de backends
- `proxy_pass` envoie le trafic vers ce groupe
- Utiliser `127.0.0.1` et non `localhost` — `localhost` peut résoudre en IPv6 et causer des erreurs de connexion
- Écouter sur `listen 80` ET `listen [::]:80` pour IPv4 et IPv6

---

## Algorithmes de load balancing

| Algorithme | Syntaxe | Quand l'utiliser |
|------------|---------|-----------------|
| **Round-robin** | (défaut) | Backends identiques, applications stateless |
| **Least connections** | `least_conn;` | Backends avec temps de réponse différents |
| **IP Hash** | `ip_hash;` | Applications avec sessions en mémoire (sticky sessions) |

### Exemple avec least_conn

```nginx
upstream nom_groupe {
    least_conn;
    server 127.0.0.1:8081;
    server 127.0.0.1:8082;
}
```

---

## Health check passif

Nginx détecte automatiquement un backend défaillant et arrête de lui envoyer du trafic. Dès que le backend répond à nouveau, Nginx le réintègre.

**Test pratique :**
```bash
# Tuer un backend
kill $(pgrep -f "http.server 8081")

# Nginx envoie tout le trafic sur Backend 2 automatiquement
curl http://localhost  # → Backend 2
```

---

## Sticky Sessions

Problème : si les sessions sont stockées en mémoire sur chaque backend, un utilisateur redirigé vers un autre backend perd sa session.

| Solution | Mécanisme | Inconvénient |
|----------|-----------|-------------|
| `ip_hash` | Même IP → même backend | Si backend tombe, sessions perdues |
| Sessions centralisées (Redis/DB) | Tous les backends partagent les sessions | Meilleure solution en production |

**Règle :** Si les sessions sont en base de données → `round-robin` ou `least_conn`. Si en mémoire → `ip_hash` ou Redis.

---

## Problèmes rencontrés et solutions

### SELinux bloque Nginx → backends
```
avc: denied { name_connect } for comm="nginx" dest=8081
scontext=httpd_t  tcontext=transproxy_port_t
```

**Diagnostic :**
```bash
sudo ausearch -m avc -ts recent | audit2allow -m nginx_proxy
```

**Solution :**
```bash
sudo setsebool -P httpd_can_network_connect=on
```

### Conflit server_name "_" sur le port 80
Nginx a un bloc server par défaut dans `nginx.conf` qui entre en conflit avec `loadbalancer.conf`. Solution : supprimer le bloc server par défaut dans `nginx.conf`.

### localhost vs 127.0.0.1 dans upstream
`localhost` peut résoudre en `::1` (IPv6) si les backends n'écoutent qu'en IPv4. Toujours utiliser `127.0.0.1` explicitement dans le bloc upstream.

---

## Ce que j'ai appris

- Un SPOF est n'importe quel composant dont la panne seule met tout le système hors ligne
- Le load balancer lui-même peut être un SPOF — en production on utilise Keepalived avec une VIP flottante
- Nginx marque un backend comme indisponible après des échecs répétés — il faut redémarrer Nginx pour réinitialiser
- `localhost` ≠ `127.0.0.1` en IPv6 — toujours être explicite avec les adresses IP dans les configs
- SELinux bloque les connexions proxy par défaut — `httpd_can_network_connect` est le boolean à activer
- Les sessions centralisées (Redis) sont meilleures que `ip_hash` car elles survivent aux pannes de backends
