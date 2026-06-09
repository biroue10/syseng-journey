# MariaDB — Manipulation de données SQL

## Objectif

Créer une table, insérer des données, les interroger et filtrer — compétences de diagnostic en production.

## Commandes SQL essentielles

```sql
-- Sélectionner une base
USE monsite_db;

-- Créer une table
CREATE TABLE utilisateurs (
    id    INT AUTO_INCREMENT PRIMARY KEY,
    nom   VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE
);

-- Insérer des données
INSERT INTO utilisateurs (nom, email) VALUES
    ('Alice Martin', 'alice.martin@gmail.com'),
    ('Biroue Isaac', 'biroue.isaac@gmail.com');

-- Lire toutes les données
SELECT * FROM utilisateurs;

-- Filtrer avec WHERE
SELECT * FROM utilisateurs WHERE nom = 'Biroue Isaac';

-- Inspecter la structure d'une table
DESCRIBE utilisateurs;
```

## Contraintes utiles

| Contrainte | Effet |
|---|---|
| `NOT NULL` | le champ est obligatoire |
| `UNIQUE` | deux lignes ne peuvent pas avoir la même valeur |
| `AUTO_INCREMENT` | MariaDB numérote automatiquement |
| `PRIMARY KEY` | identifiant unique de chaque ligne |

## Ce que j'ai appris

- Toujours terminer une commande SQL par `;`
- `DESCRIBE` affiche le schéma d'une table — utile pour inspecter une base inconnue
- `WHERE` filtre les résultats — indispensable pour le diagnostic
- Les contraintes (`NOT NULL`, `UNIQUE`) protègent l'intégrité des données
