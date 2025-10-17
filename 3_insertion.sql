-- ======================================================
-- Fichier : 3_insertion.sql
-- Mini-Projet Porsche - Données d'exemple
-- Cohérent avec 1_creation.sql et 2_contraintes.sql
-- ======================================================

USE porsche_db;

-- ========================
-- 1) CLIENT (10)
-- ========================
INSERT INTO Client (client_ID, client_num_permis, client_nom, client_prenom) VALUES
(1, 745821963, 'Dupont', 'Pierre'),
(2, 758931246, 'Martin', 'Claire'),
(3, 768412935, 'Durand', 'Julien'),
(4, 712345689, 'Moreau', 'Sophie'),
(5, 734569812, 'Lambert', 'Antoine'),
(6, 789123654, 'Rousseau', 'Emma'),
(7, 723458961, 'Bernard', 'Lucas'),
(8, 756891234, 'Garcia', 'Léa'),
(9, 769812345, 'Petit', 'Hugo'),
(10, 745698123, 'Fournier', 'Chloé');

-- ========================
-- 2) COORDONNEES (10)
-- (téléphones 06/07 -> INT entre 600000000 et 799999999)
-- ========================
INSERT INTO Coordonnees (client_ID, telephone_portable, mail, telephone_fixe) VALUES
(1, 678123456, 'pierre.dupont1@exemple.fr', 142345678),
(2, 692345781, 'claire.martin2@exemple.fr', 143567890),
(3, 701234567, 'julien.durand3@exemple.fr', 145678901),
(4, 712345678, 'sophie.moreau4@exemple.fr', 146789012),
(5, 623456789, 'antoine.lambert5@exemple.fr', 147890123),
(6, 734567890, 'emma.rousseau6@exemple.fr', 149012345),
(7, 745678901, 'lucas.bernard7@exemple.fr', 150123456),
(8, 756789012, 'lea.garcia8@exemple.fr', 151234567),
(9, 767890123, 'hugo.petit9@exemple.fr', 152345678),
(10, 778901234, 'chloe.fournier10@exemple.fr', 153456789);

-- ========================
-- 3) ADRESSE (10)
-- ========================
INSERT INTO Adresse (adresse_ID, code_postal, n_rue, nom_rue) VALUES
(1, 75008, 12, 'Avenue Montaigne, Paris'),
(2, 69002, 4, 'Rue de la République, Lyon'),
(3, 33000, 28, 'Cours de l’Intendance, Bordeaux'),
(4, 31000, 7, 'Rue d’Alsace, Toulouse'),
(5, 44000, 15, 'Boulevard des Américains, Nantes'),
(6, 13008, 21, 'Avenue du Prado, Marseille'),
(7, 35000, 3, 'Rue de la Monnaie, Rennes'),
(8, 34000, 18, 'Rue Foch, Montpellier'),
(9, 67000, 9, 'Quai des Bateliers, Strasbourg'),
(10, 59000, 25, 'Rue Nationale, Lille');

-- ========================
-- 4) HABITER (10)
-- ========================
INSERT INTO Habiter (client_ID, adresse_ID) VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),
(6,6),(7,7),(8,8),(9,9),(10,10);

-- ========================
-- 5) STATUT_COMMANDE (10)
-- (valeurs autorisées: 'En attente','Validée','En production','Livrée','Annulée')
-- ========================
INSERT INTO Statut_commande (statut_com_ID, statut_com_libelle, statut_com_date, statut_com_commentaire) VALUES
(1, 'En attente',     '2025-01-05', 'Commande enregistrée'),
(2, 'Validée',        '2025-01-12', 'Acompte reçu'),
(3, 'En production',  '2025-02-03', 'Allocation usine confirmée'),
(4, 'Livrée',         '2025-03-15', 'Client satisfait'),
(5, 'Validée',        '2025-02-20', 'Vérification financement ok'),
(6, 'En production',  '2025-03-01', 'Couleurs verrouillées'),
(7, 'En attente',     '2025-02-10', 'Attente confirmation client'),
(8, 'Annulée',        '2025-02-14', 'Annulation client'),
(9, 'Livrée',         '2025-04-05', 'Livraison effectuée'),
(10,'Validée',        '2025-03-22', 'Dossier complet');

-- ========================
-- 6) FACTURE (10)
-- (TVA >=0, TTC >= HT)
-- ========================
INSERT INTO Facture (facture_ID, facture_type, facture_date, montant_HT, TVA, montant_TTC) VALUES
(1, 'Vente', '2025-03-16', 120000, 24000, 144000),
(2, 'Vente', '2025-04-10',  98000, 19600, 117600),
(3, 'Vente', '2025-04-20', 135000, 27000, 162000),
(4, 'Vente', '2025-05-02',  85000, 17000, 102000),
(5, 'Vente', '2025-05-18', 110000, 22000, 132000),
(6, 'Vente', '2025-06-01',  92000, 18400, 110400),
(7, 'Vente', '2025-06-15', 128000, 25600, 153600),
(8, 'Vente', '2025-07-03',  76000, 15200,  91200),
(9, 'Vente', '2025-07-22', 101000, 20200, 121200),
(10,'Vente', '2025-08-05',  89000, 17800, 106800);

-- ========================
-- 7) CONFIGURATION (10)
-- (énergie: 'Essence','Diesel','Hybride','Electrique'; transmission: 'Manuelle','Automatique')
-- ========================
INSERT INTO Configuration (config_ID, config_modele, config_interieur, config_energie, config_transmission, config_code_couleur) VALUES
(1, '911 Carrera',         'Cuir Noir',      'Essence',     'Automatique', 2130),
(2, 'Taycan 4S',           'Cuir Beige',     'Electrique',  'Automatique', 4),
(3, 'Cayenne',             'Alcantara Gris', 'Hybride',     'Automatique', 2),
(4, 'Panamera',            'Cuir Rouge',     'Essence',     'Automatique', 8),
(5, 'Macan',               'Cuir Noir',      'Essence',     'Manuelle',    32),
(6, '718 Boxster',         'Cuir Bleu',      'Essence',     'Manuelle',    79),
(7, '911 Carrera S',       'Cuir Beige',     'Essence',     'Automatique', 2131),
(8, 'Taycan Turbo',        'Cuir Noir',      'Electrique',  'Automatique', 6),
(9, 'Cayenne Coupé',       'Cuir Marron',    'Hybride',     'Automatique', 9),
(10,'Panamera 4 E-Hybrid', 'Cuir Noir',      'Hybride',     'Automatique', 12);

-- ========================
-- 8) OPTION (2 seulement par conception: BOOLEAN 0/1)
-- ========================
INSERT INTO OptionVehicule (option_ID, option_libelle) VALUES
(0, 'Pack Sport'),
(1, 'Toit ouvrant');

-- ========================
-- 9) CHOIX (20) - chaque config prend 2 options (0 et 1)
-- ========================
INSERT INTO Choix (config_ID, option_ID) VALUES
(1,0),(1,1),
(2,0),(2,1),
(3,0),(3,1),
(4,0),(4,1),
(5,0),(5,1),
(6,0),(6,1),
(7,0),(7,1),
(8,0),(8,1),
(9,0),(9,1),
(10,0),(10,1);

-- ========================
-- 10) REPRISE (10)
-- (rep_estimation_prix >=0; rep_etat_vehicule parmi 'Excellent','Bon','Moyen','Mauvais')
-- ========================
INSERT INTO Reprise (rep_ID, rep_marque, rep_modele, rep_VIN, rep_immat, rep_estimation_prix, rep_etat_vehicule) VALUES
(1, 'Audi',     'A6',        541236789, 'AA-123-AA', 22000, 'Bon'),
(2, 'BMW',      '330i',      612349875, 'BB-234-BB', 18000, 'Moyen'),
(3, 'Mercedes', 'C200',      723498516, 'CC-345-CC', 20000, 'Bon'),
(4, 'Porsche',  'Macan',     734985162, 'DD-456-DD', 45000, 'Excellent'),
(5, 'Renault',  'Megane',    812349756, 'EE-567-EE',  7000, 'Moyen'),
(6, 'Peugeot',  '3008',      934875621, 'FF-678-FF', 14000, 'Bon'),
(7, 'Volkswagen','Golf 7',   845612379, 'GG-789-GG',  9000, 'Moyen'),
(8, 'Tesla',    'Model 3',   956123478, 'HH-890-HH', 28000, 'Bon'),
(9, 'Toyota',   'RAV4',      967834125, 'II-901-II', 16000, 'Bon'),
(10,'Alfa Romeo','Giulia',   978345612, 'JJ-012-JJ', 19000, 'Bon');

-- ========================
-- 11) COMMANDE (10)
-- (statut parmi: 'En attente','Confirmée','Annulée','Livrée'; mode_financement: 'Comptant','Crédit','Leasing')
-- NOTE: Notre MPD inclut client_ID (FK) -> on le renseigne ici.
-- ========================
INSERT INTO Commande (commande_ID, commande_date, n_commission_usine, commande_statut, mode_financement, accompte, rep_ID, facture_ID, statut_com_ID, config_ID, client_ID) VALUES
(1,  '2025-02-01', 9920001, 'Confirmée', 'Comptant', 1, 1, 1, 1, 1, 1),
(2,  '2025-02-05', 9920002, 'En attente','Crédit',   0, 2, 2, 2, 2, 2),
(3,  '2025-02-12', 9711003, 'Confirmée', 'Leasing',  1, 3, 3, 3, 3, 3),
(4,  '2025-02-20', 9Y00004, 'Livrée',    'Comptant', 1, 4, 4, 4, 4, 4),
(5,  '2025-03-01', 9920005, 'Confirmée', 'Crédit',   0, 5, 5, 5, 5, 5),
(6,  '2025-03-10', 9711006, 'En attente','Leasing',  0, 6, 6, 6, 6, 6),
(7,  '2025-03-18', 9Y00007, 'Annulée',   'Crédit',   0, 7, 7, 7, 7, 7),
(8,  '2025-03-25', 9920008, 'Livrée',    'Comptant', 1, 8, 8, 8, 8, 8),
(9,  '2025-04-02', 9711009, 'Confirmée', 'Leasing',  1, 9, 9, 9, 9, 9),
(10, '2025-04-09', 9Y00010, 'En attente','Crédit',   0,10,10,10,10,10);

-- ========================
-- 12) VEHICULE (10)
-- (VIN = INT dans notre MPD; vehicule_statut parmi 'Disponible','Vendu','Réservé')
-- ========================
INSERT INTO Vehicule (VIN, vehicule_annee, vehicule_code_pays, vehicule_kilometrage, vehicule_statut, garantie_ID, commande_ID) VALUES
(100000001, '2025-01-01', 250, 0,    'Vendu',     1, 1),
(100000002, '2025-01-01', 250, 0,    'Réservé',   2, 2),
(100000003, '2025-01-01', 250, 15,   'Vendu',     3, 3),
(100000004, '2025-01-01', 250, 10,   'Vendu',     4, 4),
(100000005, '2025-01-01', 250, 0,    'Réservé',   5, 5),
(100000006, '2025-01-01', 250, 0,    'Disponible',6, 6),
(100000007, '2025-01-01', 250, 0,    'Annulé',    NULL, NULL), -- sera corrigé via statut cohérent si besoin
(100000008, '2025-01-01', 250, 5,    'Vendu',     8, 8),
(100000009, '2025-01-01', 250, 0,    'Réservé',   9, 9),
(100000010,'2025-01-01', 250, 0,    'Disponible',10,10);

-- Correction: 'Annulé' n'est pas une valeur autorisée pour vehicule_statut -> on met 'Disponible'
UPDATE Vehicule SET vehicule_statut='Disponible' WHERE VIN=100000007;

-- ========================
-- 13) LIVRAISON (10)
-- (livraison_checks_docs: 'Oui'/'Non')
-- ========================
INSERT INTO Livraison (livraison_ID, livraison_date, livraison_lieu, livraison_checks_docs, commande_ID) VALUES
(1, '2025-03-15', 'Centre Porsche Paris',     'Oui', 1),
(2, '2025-04-12', 'Centre Porsche Lyon',      'Oui', 2),
(3, '2025-04-22', 'Centre Porsche Bordeaux',  'Non', 3),
(4, '2025-05-03', 'Centre Porsche Paris',     'Oui', 4),
(5, '2025-05-19', 'Centre Porsche Lyon',      'Non', 5),
(6, '2025-06-02', 'Centre Porsche Marseille', 'Oui', 6),
(7, '2025-06-16', 'Centre Porsche Rennes',    'Oui', 7),
(8, '2025-07-04', 'Centre Porsche Paris',     'Oui', 8),
(9, '2025-07-23', 'Centre Porsche Bordeaux',  'Oui', 9),
(10,'2025-08-06', 'Centre Porsche Lille',     'Non', 10);

-- ========================
-- 14) GARANTIE (10)
-- (date_fin > date_debut)
-- ========================
INSERT INTO Garantie (garantie_ID, garantie_type, garantie_date_debut, garantie_date_fin) VALUES
(1,  'Porsche Approved', '2025-03-15', '2027-03-15'),
(2,  'Neuf',             '2025-04-12', '2027-04-12'),
(3,  'Neuf',             '2025-04-22', '2027-04-22'),
(4,  'Porsche Approved', '2025-05-03', '2027-05-03'),
(5,  'Neuf',             '2025-05-19', '2027-05-19'),
(6,  'Neuf',             '2025-06-02', '2027-06-02'),
(7,  'Porsche Approved', '2025-06-16', '2027-06-16'),
(8,  'Neuf',             '2025-07-04', '2027-07-04'),
(9,  'Porsche Approved', '2025-07-23', '2027-07-23'),
(10, 'Neuf',             '2025-08-06', '2027-08-06');

-- ========================
-- 15) PASSER (10)
-- (association Client-Commande)
-- ========================
INSERT INTO Passer (client_ID, commande_ID) VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),
(6,6),(7,7),(8,8),(9,9),(10,10);
