-- ======================================================
-- Fichier : 4_interrogation.sql
-- Mini-Projet Porsche - Requêtes de test
-- ======================================================

USE porsche_concession_db;

-- Liste des clients ayant passé au moins une commande
SELECT DISTINCT c.client_nom, c.client_prenom, co.mail, co.telephone_portable
FROM Client c
JOIN Coordonnees co ON c.client_ID = co.client_ID
JOIN Passer p ON c.client_ID = p.client_ID
ORDER BY c.client_nom ASC;

-- Commandes validées ou livrées entre deux dates
SELECT commande_ID, commande_date, commande_statut, mode_financement
FROM Commande
WHERE commande_statut IN ('Validée', 'Livrée')
  AND commande_date BETWEEN '2024-01-01' AND '2024-12-31'
ORDER BY commande_date DESC;

-- Recherche de clients par motif de nom
SELECT client_nom, client_prenom
FROM Client
WHERE client_nom LIKE 'Du%';

-- Véhicules disponibles ou réservés (masque et tri)
SELECT VIN, vehicule_statut, vehicule_kilometrage
FROM Vehicule
WHERE vehicule_statut IN ('Disponible', 'Réservé')
ORDER BY vehicule_kilometrage ASC;

-- Commandes avec acompte versé
SELECT commande_ID, commande_date, accompte
FROM Commande
WHERE accompte = 1;

-- Nombre de commandes par statut
SELECT commande_statut, COUNT(*) AS nb_commandes
FROM Commande
GROUP BY commande_statut
HAVING COUNT(*) > 0;

-- Montant moyen TTC des factures par type de financement
SELECT mode_financement, AVG(f.montant_TTC) AS moyenne_TTC
FROM Commande cmd
JOIN Facture f ON cmd.facture_ID = f.facture_ID
GROUP BY mode_financement;

-- Total du chiffre d’affaires par année
SELECT YEAR(f.facture_date) AS Annee, SUM(f.montant_TTC) AS Chiffre_Affaires
FROM Facture f
GROUP BY YEAR(f.facture_date)
HAVING SUM(f.montant_TTC) > 0;

-- Nombre moyen d’options choisies par configuration
SELECT config_ID, COUNT(option_ID) AS nb_options
FROM Choix
GROUP BY config_ID
HAVING COUNT(option_ID) >= 1;

-- Nombre de véhicules par type d’énergie
SELECT config_energie, COUNT(*) AS nb_vehicules
FROM Configuration
GROUP BY config_energie;

-- Liste complète des commandes avec client, facture et véhicule
SELECT c.client_nom, c.client_prenom, cmd.commande_ID, cmd.commande_statut,
       f.montant_TTC, v.vehicule_statut
FROM Client c
JOIN Passer p ON c.client_ID = p.client_ID
JOIN Commande cmd ON p.commande_ID = cmd.commande_ID
LEFT JOIN Facture f ON cmd.facture_ID = f.facture_ID
LEFT JOIN Vehicule v ON cmd.commande_ID = v.commande_ID;

-- Détails de livraison avec client et lieu
SELECT c.client_nom, c.client_prenom, l.livraison_date, l.livraison_lieu
FROM Livraison l
INNER JOIN Commande cmd ON l.commande_ID = cmd.commande_ID
INNER JOIN Passer p ON cmd.commande_ID = p.commande_ID
INNER JOIN Client c ON p.client_ID = c.client_ID
ORDER BY l.livraison_date DESC;

-- Commandes sans livraison (jointure externe)
SELECT cmd.commande_ID, cmd.commande_statut, l.livraison_ID
FROM Commande cmd
LEFT JOIN Livraison l ON cmd.commande_ID = l.commande_ID
WHERE l.livraison_ID IS NULL;

-- Véhicules et garanties associées
SELECT v.VIN, g.garantie_type, g.garantie_date_fin
FROM Vehicule v
JOIN Garantie g ON v.garantie_ID = g.garantie_ID;

-- Options sélectionnées pour chaque configuration
SELECT conf.config_modele, ov.option_libelle
FROM Configuration conf
JOIN Choix ch ON conf.config_ID = ch.config_ID
JOIN OptionVehicule ov ON ch.option_ID = ov.option_ID;

-- Clients ayant commandé un véhicule déjà livré
SELECT client_nom, client_prenom
FROM Client
WHERE client_ID IN (
  SELECT p.client_ID
  FROM Passer p
  JOIN Commande cmd ON p.commande_ID = cmd.commande_ID
  WHERE cmd.commande_statut = 'Livrée'
);

-- Commandes dont le montant TTC dépasse la moyenne globale
SELECT f.facture_ID, f.montant_TTC
FROM Facture f
WHERE f.montant_TTC > ALL (
  SELECT AVG(montant_TTC) FROM Facture
);

-- Véhicules sans garantie
SELECT VIN
FROM Vehicule
WHERE garantie_ID NOT IN (SELECT garantie_ID FROM Garantie);

-- Clients sans commande (NOT EXISTS)
SELECT client_nom, client_prenom
FROM Client c
WHERE NOT EXISTS (
  SELECT 1 FROM Passer p WHERE p.client_ID = c.client_ID
);

-- Commandes dont le montant TTC est supérieur à au moins une autre facture
SELECT commande_ID
FROM Commande
WHERE facture_ID = ANY (
  SELECT facture_ID FROM Facture WHERE montant_TTC < 20000
);
