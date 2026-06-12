# SELinux avancé — Lire et résoudre les refus

## Objectif

Diagnostiquer et corriger les blocages SELinux sans désactiver SELinux ni passer en mode permissif.

---

## État SELinux

```bash
$ getenforce
Enforcing

$ sestatus | head -5
SELinux status:                 enabled
SELinuxfs mount:                /sys/fs/selinux
SELinux root directory:         /etc/selinux
Loaded policy name:             targeted
Current mode:                   enforcing
```

`Enforcing` = SELinux actif et bloquant. C'est la configuration correcte en production.

---

## Lire un refus AVC

```bash
sudo ausearch -m avc -ts today --raw | head -5
```

Exemple de refus réel :

```
type=AVC msg=audit(1781221701.223:5239): avc: denied { open } for
pid=124286 comm="rhsmcertd-worke"
path="/etc/yum.repos.d/gh-cli.repo"
scontext=system_u:system_r:rhsmcertd_t:s0
tcontext=unconfined_u:object_r:user_tmp_t:s0
tclass=file permissive=0
```

### Décomposition

| Champ | Valeur | Signification |
|-------|--------|--------------|
| `denied { open }` | open | Action bloquée |
| `tclass=file` | file | Type d'objet concerné |
| `comm` | rhsmcertd-worke | Processus bloqué |
| `path` | /etc/yum.repos.d/gh-cli.repo | Fichier concerné |
| `scontext` | rhsmcertd_t | Contexte du processus |
| `tcontext` | user_tmp_t | Contexte du fichier — **le problème** |

Le fichier avait le contexte `user_tmp_t` (fichier temporaire utilisateur) au lieu de `system_conf_t` (fichier de configuration système). SELinux a bloqué l'accès car les contextes ne correspondent pas.

---

## Workflow de résolution

```
ausearch -m avc    →  identifier le problème
         ↓
lire scontext / tcontext  →  comprendre qui bloque quoi
         ↓
restorecon         →  contexte de fichier incorrect (cas le plus fréquent)
semanage fcontext  →  répertoire non standard
semanage port      →  port non standard
setsebool          →  comportement réseau / accès couvert par un boolean
audit2allow        →  dernier recours — cas custom non couvert par la politique
```

### Outils et leur rôle

| Commande | Quand l'utiliser |
|----------|-----------------|
| `restorecon -Rv /chemin` | Contexte de fichier incorrect — le plus fréquent |
| `semanage fcontext` | Répertoire non standard hors de la politique par défaut |
| `semanage port` | Port non standard pour un service |
| `setsebool -P` | Comportement réseau ou accès couvert par un boolean existant |
| `audit2allow` | Cas vraiment custom, aucun boolean ni fcontext ne couvre le cas |

**`audit2allow` en dernier** — il crée des exceptions à la politique. À utiliser avec précaution, pas comme raccourci pour éviter de comprendre le problème.

---

## Correction appliquée

```bash
$ sudo restorecon -Rv /etc/yum.repos.d/
Relabeled /etc/yum.repos.d/tailscale.repo from unconfined_u:object_r:user_tmp_t:s0 to unconfined_u:object_r:system_conf_t:s0
Relabeled /etc/yum.repos.d/gh-cli.repo from unconfined_u:object_r:user_tmp_t:s0 to unconfined_u:object_r:system_conf_t:s0
```

Les fichiers `.repo` sont passés de `user_tmp_t` à `system_conf_t` — `rhsmcertd` peut maintenant les lire.

---

## Commandes de référence

```bash
# Voir les refus du jour
sudo ausearch -m avc -ts today

# Voir les refus récents (dernières minutes)
sudo ausearch -m avc -ts recent

# Générer une suggestion de correction
sudo ausearch -m avc -ts recent | audit2allow -m mon_module

# Vérifier le contexte d'un fichier
ls -Z /etc/yum.repos.d/

# Vérifier les booleans disponibles pour un service
getsebool -a | grep httpd
```

---

## Ce que j'ai appris

- Ne jamais mettre SELinux en mode permissif ou disabled pour résoudre un blocage — comprendre et corriger la cause
- `restorecon` résout la majorité des blocages liés aux fichiers copiés ou créés hors du contexte normal
- Les fichiers créés par des outils tiers (gh CLI, Tailscale) peuvent hériter d'un mauvais contexte
- `audit2allow` crée des exceptions — c'est le dernier recours, pas le premier réflexe
- Lire `scontext` et `tcontext` dans un AVC permet de comprendre immédiatement qui bloque quoi
