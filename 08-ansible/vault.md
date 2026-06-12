# Ansible Vault — Chiffrement des secrets

## Objectif

Ne jamais stocker un mot de passe, une clé API ou un token en clair dans le dépôt Git. Ansible Vault chiffre les fichiers de variables sensibles — ils peuvent être commités en toute sécurité.

---

## Pourquoi pas defaults/main.yml ?

```yaml
# ❌ Ne jamais faire ça
# roles/mariadb/defaults/main.yml
mariadb_root_password: SecurePass123!   # visible par tout le monde sur GitHub
```

Tout ce qui est dans `defaults/` ou `vars/` en clair est lisible dans le dépôt. Pour les secrets, on utilise un fichier chiffré dans `vars/`.

---

## Structure

```
roles/mariadb/
├── defaults/
│   └── main.yml          # variables non-sensibles (package, service...)
├── vars/
│   └── main.yml          # secrets chiffrés avec Vault ← nouveau
├── tasks/main.yml
└── handlers/main.yml
```

---

## Créer un fichier Vault

```bash
mkdir -p roles/mariadb/vars
ansible-vault create roles/mariadb/vars/main.yml
```

Ansible demande un mot de passe vault, puis ouvre un éditeur. Écrire dedans :

```yaml
---
mariadb_root_password: SecurePass123!
```

Sauvegarder et quitter. Le fichier stocké sur disque est chiffré :

```
$ANSIBLE_VAULT;1.1;AES256
63663737626334383438656433316236366630336438313438623835666163613032333230393639
...
```

Ce fichier peut être commité sur GitHub — sans le mot de passe vault, il est illisible.

---

## Opérations vault courantes

```bash
# Voir le contenu déchiffré
ansible-vault view roles/mariadb/vars/main.yml

# Modifier le contenu
ansible-vault edit roles/mariadb/vars/main.yml

# Rechiffrer avec un nouveau mot de passe
ansible-vault rekey roles/mariadb/vars/main.yml

# Chiffrer un fichier existant en clair
ansible-vault encrypt roles/mariadb/vars/main.yml

# Déchiffrer un fichier (redevient clair — à éviter en production)
ansible-vault decrypt roles/mariadb/vars/main.yml
```

---

## Utiliser les variables vault dans les tasks

Les variables vault s'utilisent exactement comme les variables normales — Ansible déchiffre automatiquement au runtime :

```yaml
- name: Set MariaDB root password
  mysql_user:
    name: root
    password: "{{ mariadb_root_password }}"
    login_unix_socket: /var/lib/mysql/mysql.sock
    login_user: root
    login_password: "{{ mariadb_root_password }}"
```

---

## Lancer le playbook avec Vault

```bash
ansible-playbook -i inventory/hosts playbook.yml --ask-become-pass --ask-vault-pass
```

Ansible demande deux mots de passe :
1. `BECOME password` — sudo sur le serveur
2. `Vault password` — pour déchiffrer `vars/main.yml`

---

## Problèmes rencontrés

### mariadb_root_password is undefined
Le répertoire `vars/` n'avait pas été créé avant `ansible-vault create`. Résolution :
```bash
mkdir -p roles/mariadb/vars
ansible-vault create roles/mariadb/vars/main.yml
```

### Access denied for user 'root' (using password: NO)
Le premier run avait déjà défini le mot de passe root. Les runs suivants doivent s'authentifier avec ce mot de passe pour pouvoir le modifier. Résolution : ajouter `login_user` et `login_password` à la task `mysql_user`.

### mariadb.service échoue au redémarrage
Le script `mariadb-check-socket` lit tous les fichiers de config dans `/etc/my.cnf.d/`. Le fichier `mariadb-slave.cnf` (Module 07) définissait `port=3307` et `socket=/var/lib/mysql-slave/mysql-slave.sock`, qui surchargeaient les valeurs du master. Résolutions :
- Renommer `mariadb-slave.cnf` → `00-mariadb-slave.cnf` pour qu'il soit lu avant `mariadb-server.cnf`
- Ajouter `port = 3306` explicitement dans `mariadb-server.cnf` pour écraser le 3307 du slave

---

## Ce que j'ai appris

- `defaults/main.yml` = valeurs par défaut, jamais de secrets
- `vars/main.yml` chiffré avec Vault = la bonne place pour les credentials
- Le fichier chiffré est safe à commiter — sans le mot de passe vault, c'est du bruit
- `ansible-vault edit` permet de modifier un fichier vault sans le déchiffrer sur disque
- Quand un mot de passe MariaDB est déjà défini, `mysql_user` doit s'authentifier avec `login_password` avant de pouvoir le changer
- `my_print_defaults` lit tous les fichiers de config dans `/etc/my.cnf.d/` et prend la dernière valeur — l'ordre alphabétique des fichiers a un impact sur quelle config gagne
