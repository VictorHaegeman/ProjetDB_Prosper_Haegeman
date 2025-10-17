-- ======================================================
-- Fichier : 2_contraintes.sql
-- Mini-Projet Porsche - Contraintes de validation
-- Groupe : Victor Haegeman & Léo Prosper
-- ======================================================

USE porsche_db;

-- ======================================================
-- Table CLIENT
-- ======================================================
ALTER TABLE Client
  ADD CONSTRAINT chk_client_num_permis_pos
  CHECK (client_num_permis > 0);

-- ======================================================
-- Table COORDONNEES
-- ======================================================
ALTER TABLE Coordonnees
  ADD CONSTRAINT chk_mail_format
  CHECK (mail LIKE '%_@__%.__%'),
  ADD CONSTRAINT chk_num_tel_portable
  CHECK (telephone_portable BETWEEN 600000000 AND 799999999);

-- ======================================================
-- Table ADRESSE
-- ======================================================
ALTER TABLE Adresse
  ADD CONSTRAINT chk_code_postal_format
  CHECK (code_postal BETWEEN 1000 AND 99999),
  ADD CONSTRAINT chk_num_rue_positif
  CHECK (n_rue > 0);

-- ======================================================
-- Table STATUT_COMMANDE
-- ======================================================
ALTER TABLE Statut_commande
  ADD CONSTRAINT chk_statut_com_libelle
  CHECK (statut_com_libelle IN ('En attente', 'Validée', 'En production', 'Livrée', 'Annulée'));

-- ======================================================
-- Table FACTURE
-- ======================================================
ALTER TABLE Facture
  ADD CONSTRAINT chk_montant_facture_positif
  CHECK (montant_HT >= 0 AND montant_TTC >= 0),
  ADD CONSTRAINT chk_tva_non_negative
  CHECK (TVA >= 0),
  ADD CONSTRAINT chk_ttc_superieur_ht
  CHECK (montant_TTC >= montant_HT);

-- ======================================================
-- Table CONFIGURATION
-- ======================================================
ALTER TABLE Configuration
  ADD CONSTRAINT chk_config_energie
  CHECK (config_energie IN ('Essence', 'Diesel', 'Hybride', 'Electrique')),
  ADD CONSTRAINT chk_config_transmission
  CHECK (config_transmission IN ('Manuelle', 'Automatique'));

-- ======================================================
-- Table REPRISE
-- ======================================================
ALTER TABLE Reprise
  ADD CONSTRAINT chk_prix_reprise
  CHECK (rep_estimation_prix >= 0),
  ADD CONSTRAINT chk_rep_vin_positif
  CHECK (rep_VIN > 0),
  ADD CONSTRAINT chk_rep_etat_vehicule
  CHECK (rep_etat_vehicule IN ('Excellent', 'Bon', 'Moyen', 'Mauvais'));

-- ======================================================
-- Table OPTION
-- ======================================================
ALTER TABLE OptionVehicule
  ADD CONSTRAINT chk_option_libelle
  CHECK (option_libelle <> '');

-- ======================================================
-- Table GARANTIE
-- ======================================================
ALTER TABLE Garantie
  ADD CONSTRAINT chk_dates_garantie
  CHECK (garantie_date_fin > garantie_date_debut);

-- ======================================================
-- Table COMMANDE
-- ======================================================
ALTER TABLE Commande
  ADD CONSTRAINT chk_accompte_boolean
  CHECK (accompte IN (0,1)),
  ADD CONSTRAINT chk_commande_statut
  CHECK (commande_statut IN ('En attente', 'Confirmée', 'Annulée', 'Livrée')),
  ADD CONSTRAINT chk_mode_financement
  CHECK (mode_financement IN ('Comptant', 'Crédit', 'Leasing'));

-- ======================================================
-- Table VEHICULE
-- ======================================================
ALTER TABLE Vehicule
  ADD CONSTRAINT chk_kilometrage_non_negatif
  CHECK (vehicule_kilometrage >= 0),
  ADD CONSTRAINT chk_code_pays_format
  CHECK (vehicule_code_pays BETWEEN 0 AND 999),
  ADD CONSTRAINT chk_statut_vehicule
  CHECK (vehicule_statut IN ('Disponible', 'Vendu', 'Réservé'));

-- ======================================================
-- Table LIVRAISON
-- ======================================================
ALTER TABLE Livraison
  ADD CONSTRAINT chk_livraison_checks_docs
  CHECK (livraison_checks_docs IN ('Oui', 'Non')),
  ADD CONSTRAINT chk_livraison_date_non_nulle
  CHECK (livraison_date IS NOT NULL);

-- ======================================================
-- Table CHOIX
-- ======================================================
ALTER TABLE Choix
  ADD CONSTRAINT chk_option_unique_par_config
  CHECK (option_ID IN (0,1));

