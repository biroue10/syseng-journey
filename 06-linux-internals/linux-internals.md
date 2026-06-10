# Linux Internals

## Objectif

Comprendre ce qui se passe sous le capot : gestion des disques (LVM), mémoire, processus et tuning kernel.

---

## LVM — Logical Volume Manager

LVM ajoute une couche d'abstraction entre le disque physique et les partitions, permettant de redimensionner à chaud.

### Les 3 couches

| Couche | Nom | Commande |
|--------|-----|----------|
| Disque physique | Physical Volume (PV) | `pvs` |
| Groupe de disques | Volume Group (VG) | `vgs` |
| Partition flexible | Logical Volume (LV) | `lvs` |

### Structure du serveur

```
/dev/sda (476 GB)
└── /dev/sda3 → PV → VG rhel
        ├── LV root  70 GB  → /
        ├── LV home  398 GB → /home
        └── LV swap  7.8 GB → [SWAP]
```

### Commandes utiles

```bash
pvs          # liste les physical volumes
vgs          # liste les volume groups
lvs          # liste les logical volumes
lsblk        # vue arborescente des disques
```

### Étendre un volume logique

```bash
lvextend -L +20G /dev/rhel/root
resize2fs /dev/rhel/root     # pour ext4
xfs_growfs /                 # pour xfs
```

---

## Mémoire — /proc/meminfo

```bash
cat /proc/meminfo | head -20
```

| Clé | Signification |
|-----|--------------|
| `MemTotal` | RAM physique totale |
| `MemFree` | RAM complètement vide |
| `MemAvailable` | RAM disponible (free + cache récupérable) |
| `Cached` | Fichiers en cache disque — libérables instantanément |
| `SwapFree` | Swap inutilisé — doit rester élevé |

**Règle :** `MemAvailable = MemFree + Cached` (approximatif). Toujours regarder `MemAvailable`, pas `MemFree`.

---

## Processus — ps aux

```bash
ps aux | grep nginx
```

| Colonne | Signification |
|---------|--------------|
| `PID` | ID unique du processus |
| `%CPU` / `%MEM` | consommation CPU et RAM |
| `RSS` | mémoire physique réellement utilisée |
| `VSZ` | mémoire virtuelle réservée (souvent trompeur) |
| `STAT` | état du processus |

### États des processus (STAT)

| Code | Signification |
|------|--------------|
| `S` | Sleeping — en attente (état normal) |
| `R` | Running — en cours d'exécution |
| `Z` | Zombie — terminé, parent pas encore notifié |
| `I` | Idle — thread kernel inactif |
| `s` | session leader |

### Architecture Nginx

- 1 **master process** (root) — ouvre les ports, gère les workers
- N **worker processes** (nginx) — traitent les requêtes HTTP
- N = nombre de cœurs CPU (`nproc`) — 1 worker par cœur

---

## Kernel — sysctl

`sysctl` permet de lire et modifier les paramètres kernel à chaud.

```bash
uname -r                        # version du kernel
sysctl -a | grep vm.swappiness  # lire un paramètre
sudo sysctl vm.swappiness=10    # modifier temporairement
```

### Rendre permanent

```bash
echo "vm.swappiness=10" | sudo tee /etc/sysctl.d/99-syseng.conf
sudo sysctl -p /etc/sysctl.d/99-syseng.conf
```

### vm.swappiness

| Valeur | Comportement |
|--------|-------------|
| `0` | swap uniquement en dernier recours |
| `10` | recommandé pour serveur web |
| `60` | valeur par défaut Linux |
| `100` | swap agressif |

**Appliqué sur ce serveur :** `vm.swappiness=10` — priorité à la RAM.

---

## Ce que j'ai appris

- LVM = flexibilité : redimensionner `/root` en prenant de l'espace sur `/home` sans toucher au matériel
- `MemAvailable` > `MemFree` car le cache disque est récupérable instantanément
- `RSS` est la vraie consommation mémoire — `VSZ` inclut la mémoire réservée mais non utilisée
- Nginx crée autant de workers que de cœurs CPU — parallélisme au niveau matériel
- `/etc/sysctl.d/` persiste les paramètres kernel au reboot
