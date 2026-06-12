# auditd — Traçabilité des modifications système

## Objectif

Enregistrer qui modifie quoi dans les fichiers critiques du système, avec horodatage et identité réelle de l'utilisateur — même à travers sudo.

---

## Différence auditd vs journald

| | journald | auditd |
|---|----------|--------|
| Ce qu'il capture | Logs applicatifs et services | Appels système noyau |
| Niveau | Userspace | Kernel |
| Qui a fait quoi | Dépend du service | `auid` = identité réelle garantie |
| Usage | Débogage, monitoring | Conformité, investigation forensique |

auditd est le sous-système d'audit du noyau Linux. Il voit tout ce qui passe par les syscalls, avant même que l'application ait la main.

---

## Règles de surveillance

```bash
# Surveiller les modifications de sudoers
sudo auditctl -w /etc/sudoers -p wa -k sudoers_changes

# Surveiller les modifications de la base utilisateurs
sudo auditctl -w /etc/passwd -p wa -k user_changes

# Surveiller les modifications des mots de passe
sudo auditctl -w /etc/shadow -p wa -k shadow_changes
```

| Paramètre | Signification |
|-----------|--------------|
| `-w /chemin` | Watch — surveiller ce fichier |
| `-p wa` | Permissions : w=write, a=append |
| `-k label` | Clé de recherche pour ausearch |

---

## Rendre les règles permanentes

Les règles `auditctl` sont perdues au reboot. Pour les rendre permanentes :

```bash
sudo tee /etc/audit/rules.d/audit.rules << 'EOF'
# Modifications des fichiers sensibles
-w /etc/sudoers -p wa -k sudoers_changes
-w /etc/passwd -p wa -k user_changes
-w /etc/shadow -p wa -k shadow_changes
EOF

sudo augenrules --load
```

`augenrules` compile tous les fichiers de `/etc/audit/rules.d/` et les charge. Si les règles sont déjà en mémoire, l'erreur "Rule exists" est normale — les règles sont actives, le fichier est écrit, tout est correct.

---

## Interroger les logs — ausearch

```bash
# Tous les événements liés à sudoers aujourd'hui
sudo ausearch -k sudoers_changes --start today

# Événements récents (dernières minutes)
sudo ausearch -k user_changes --start recent

# Filtrer par type d'événement
sudo ausearch -m SYSCALL --start today
```

---

## Lire un événement auditd

Exemple réel — modification de `/etc/sudoers` via `visudo` :

```
time->Fri Jun 12 03:03:50 2026
type=SYSCALL msg=audit(...): syscall=257 comm="visudo" exe="/usr/sbin/visudo"
  auid=1000 uid=0 key="sudoers_changes"
type=PATH ... name="/etc/sudoers" nametype=NORMAL

time->Fri Jun 12 03:04:13 2026
type=SYSCALL msg=audit(...): syscall=82 comm="visudo" exe="/usr/sbin/visudo"
  auid=1000 uid=0 key="sudoers_changes"
type=PATH ... name="/etc/sudoers" nametype=CREATE
type=PATH ... name="/etc/sudoers" nametype=DELETE
type=PATH ... name="/etc/sudoers.tmp" nametype=DELETE
```

### Décomposition

| Champ | Valeur | Signification |
|-------|--------|--------------|
| `auid=1000` | biroue | Utilisateur réel connecté — **ne peut pas être falsifié** |
| `uid=0` | root | Identité effective au moment du syscall (après sudo) |
| `syscall=257` | openat | visudo a ouvert le fichier en lecture |
| `syscall=82` | rename | L'écriture réelle — visudo écrit dans .tmp puis renomme atomiquement |
| `key` | sudoers_changes | Correspond à la règle `-k` |

### Pourquoi `auid` est crucial

Même si quelqu'un fait `sudo su -` et modifie sudoers en tant que root (`uid=0`), `auid` conserve l'identité de l'utilisateur initialement connecté. C'est la garantie de traçabilité en investigation forensique.

### Le pattern rename de visudo

visudo ne modifie pas `/etc/sudoers` directement. Il :
1. Valide la syntaxe dans un fichier temporaire (`sudoers.tmp`)
2. Renomme atomiquement `sudoers.tmp` → `sudoers`

C'est pourquoi l'événement d'écriture montre `syscall=82` (rename) et non une simple écriture dans le fichier.

---

## Vérifier les règles actives

```bash
sudo auditctl -l
```

Sortie attendue :
```
-w /etc/sudoers -p wa -k sudoers_changes
-w /etc/passwd -p wa -k user_changes
-w /etc/shadow -p wa -k shadow_changes
```

---

## Ce que j'ai appris

- `auid` est l'identité réelle — elle traverse sudo et ne peut pas être masquée
- auditd opère au niveau noyau, pas applicatif — il voit tout
- `visudo` utilise un rename atomique pour garantir la cohérence du fichier sudoers
- Les règles `auditctl` sont en mémoire uniquement — les rendre permanentes via `/etc/audit/rules.d/`
- "Rule exists" lors du chargement = la règle était déjà active, ce n'est pas une erreur
- `-k` (key) est le champ de recherche dans `ausearch` — toujours nommer les règles
