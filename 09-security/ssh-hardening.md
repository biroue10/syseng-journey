# SSH Hardening

## Objectif

Sécuriser l'accès SSH en désactivant l'authentification par mot de passe, interdisant la connexion root directe, et limitant les tentatives de connexion.

---

## Règle d'or avant toute modification

Ne jamais fermer la session SSH existante avant d'avoir vérifié que la nouvelle config fonctionne. Utiliser `reload` au lieu de `restart` — reload relit la config sans couper les sessions actives.

```
1. Session SSH actuelle → rester ouverte
2. Modifier /etc/ssh/sshd_config
3. sudo systemctl reload sshd
4. Ouvrir une NOUVELLE session SSH pour tester
5. Si ça marche → ok. Sinon → corriger depuis la session existante.
```

---

## Prérequis — Auth par clé

Avant de désactiver l'auth par mot de passe, s'assurer qu'une clé SSH est configurée :

```bash
cat ~/.ssh/authorized_keys
```

Si le fichier est absent ou vide → configurer la clé d'abord, sinon on se lock out.

---

## Directives appliquées

```bash
sudo bash -c 'cat >> /etc/ssh/sshd_config << EOF

# Security hardening
PasswordAuthentication no
PermitRootLogin no
MaxAuthTries 3
ClientAliveInterval 300
EOF'
```

| Directive | Valeur | Pourquoi |
|-----------|--------|----------|
| `PasswordAuthentication no` | `no` | Forcer l'auth par clé — un mot de passe peut être bruteforcé, une clé ed25519 non |
| `PermitRootLogin no` | `no` | Interdire la connexion directe en root — toujours passer par un user normal puis sudo |
| `MaxAuthTries 3` | `3` | Max 3 tentatives par connexion avant déconnexion |
| `ClientAliveInterval 300` | `300` | Déconnecter les sessions inactives après 5 minutes |

---

## Vérification

```bash
# Vérifier que les directives sont actives
sudo grep -E "PasswordAuthentication|PermitRootLogin|MaxAuthTries|ClientAliveInterval" /etc/ssh/sshd_config

# Recharger sans couper les sessions
sudo systemctl reload sshd

# Tester depuis un nouveau terminal
ssh biroue@<ip>       # doit marcher (clé)
ssh root@<ip>         # doit être refusé
```

Résultat attendu pour root :
```
root@192.168.x.x: Permission denied (publickey,gssapi-keyex,gssapi-with-mic)
```

---

## Ce que j'ai appris

- Les directives commentées dans `sshd_config` sont ignorées — SSH utilise ses valeurs par défaut
- Ajouter les directives actives à la fin du fichier écrase les valeurs par défaut
- `reload` relit la config sans tuer les sessions existantes — toujours utiliser reload pour SSH
- Une clé ed25519 est mathématiquement impossible à bruteforcer — un mot de passe non
- `PermitRootLogin prohibit-password` est la valeur par défaut sur RHEL — root peut se connecter par clé mais pas par mot de passe
