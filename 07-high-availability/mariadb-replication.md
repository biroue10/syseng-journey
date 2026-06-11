# Réplication MariaDB Master/Slave

## Objectif

Maintenir une copie synchronisée de la base de données sur un second serveur pour éliminer le SPOF et assurer la continuité de service.

---

## Architecture

```
Master (port 3306)          Slave (port 3307)
      │                           │
      │  binlog ──► IO Thread ──► relay log
      │                           │
      │              SQL Thread ◄─┘
      │                  │
      │            rejoue les opérations
```

### Cycle de réplication

1. Une opération (INSERT/UPDATE/CREATE) se produit sur le **master**
2. Le master l'enregistre dans le **binlog** (`mysql-bin.000001`)
3. Le **IO thread** du slave lit le binlog et le copie dans un **relay log**
4. Le **SQL thread** lit le relay log et rejoue l'opération sur le slave
5. Le slave est synchronisé

---

## Configuration du Master

### Activer le binlog — `/etc/my.cnf.d/mariadb-server.cnf`

```ini
[mysqld]
server-id = 1
log-bin = mysql-bin
```

### Redémarrer et vérifier

```bash
sudo systemctl restart mariadb
sudo mysql -u root -e "SHOW MASTER STATUS;"
```

Résultat attendu :
```
+------------------+----------+
| File             | Position |
+------------------+----------+
| mysql-bin.000001 | 328      |
+------------------+----------+
```

Noter le **File** et la **Position** — le slave en aura besoin.

### Créer l'utilisateur de réplication

```sql
CREATE USER 'replicator'@'%' IDENTIFIED BY 'ReplicaPass123!';
GRANT REPLICATION SLAVE ON *.* TO 'replicator'@'%';
FLUSH PRIVILEGES;
```

---

## Configuration du Slave (2ème instance sur port 3307)

### Créer le répertoire de données

```bash
sudo mkdir -p /var/lib/mysql-slave
sudo chown mysql:mysql /var/lib/mysql-slave
sudo mysql_install_db --user=mysql --datadir=/var/lib/mysql-slave
```

### Corriger le contexte SELinux

```bash
sudo semanage fcontext -a -t mysqld_db_t "/var/lib/mysql-slave(/.*)?"
sudo restorecon -Rv /var/lib/mysql-slave/
sudo semanage port -a -t mysqld_port_t -p tcp 3307
```

### Fichier de config — `/etc/my.cnf.d/mariadb-slave.cnf`

```ini
[mysqld]
server-id = 2
port = 3307
datadir=/var/lib/mysql-slave
socket=/var/lib/mysql-slave/mysql-slave.sock
log-error=/var/log/mariadb/mariadb-slave.log
pid-file=/run/mariadb/mariadb-slave.pid
```

### Service systemd — `/etc/systemd/system/mariadb-slave.service`

Copié depuis le service master, avec `ExecStart` modifié :

```ini
ExecStart=/usr/libexec/mariadbd --defaults-file=/etc/my.cnf.d/mariadb-slave.cnf --basedir=/usr $MYSQLD_OPTS $_WSREP_NEW_CLUSTER $_WSREP_START_POSITION
```

**Important :** `--defaults-file` doit être le premier argument — MariaDB refuse de démarrer sinon.

```bash
sudo systemctl daemon-reload
sudo systemctl start mariadb-slave
```

---

## Configurer la réplication

Se connecter au slave :

```bash
sudo mysql -u root -P 3307 -S /var/lib/mysql-slave/mysql-slave.sock
```

Pointer le slave vers le master :

```sql
CHANGE MASTER TO
  MASTER_HOST='127.0.0.1',
  MASTER_PORT=3306,
  MASTER_USER='replicator',
  MASTER_PASSWORD='ReplicaPass123!',
  MASTER_LOG_FILE='mysql-bin.000001',
  MASTER_LOG_POS=328;

START SLAVE;
```

---

## Vérification

```sql
SHOW SLAVE STATUS\G
```

Les deux lignes critiques :

```
Slave_IO_Running: Yes       ← connecté au master, lit le binlog
Slave_SQL_Running: Yes      ← rejoue les opérations
Seconds_Behind_Master: 0    ← slave synchronisé
```

### Test de réplication

```sql
-- Sur le master
CREATE DATABASE test_replication;

-- Sur le slave — doit apparaître automatiquement
SHOW DATABASES;
```

---

## Problèmes rencontrés et solutions

| Problème | Cause | Solution |
|----------|-------|---------|
| `Permission denied` sur `/var/lib/mysql-slave` | Contexte SELinux `var_lib_t` | `semanage fcontext` + `restorecon` |
| `Bind on TCP/IP port: Permission denied` (port 3307) | Port non autorisé par SELinux | `semanage port -a -t mysqld_port_t -p tcp 3307` |
| `unknown variable 'defaults-file'` | `--defaults-file` n'était pas en premier argument | Mettre `--defaults-file` avant `--basedir` |

---

## Ce que j'ai appris

- Le binlog est le journal de toutes les opérations d'écriture — c'est la source de vérité de la réplication
- Deux threads assurent la réplication : IO thread (copie le binlog) et SQL thread (rejoue les opérations)
- `Seconds_Behind_Master` mesure le lag de réplication — en production, une alerte se déclenche si ce chiffre monte
- `--defaults-file` doit être le premier argument de `mariadbd` — contrainte stricte de MariaDB
- SELinux bloque tout nouveau répertoire et port par défaut — `semanage` est la solution propre (pas `setsebool permissive`)
- Se connecter à une instance spécifique : `-P port -S /chemin/socket`
