-- ======================================================
-- Fichier : 2_contraintes.sql (version corrigée MySQL 8)
-- Mini-Projet Porsche - Contraintes de validation
-- Groupe : Victor Haegeman & Léo Prosper
-- ======================================================

USE porsche_concession_db;

-- ======================================================
-- TABLE CLIENT
-- ======================================================
ALTER TABLE Client DROP CHECK chk_client_num_permis_pos;
ALTER TABLE Client
  ADD CONSTRAINT chk_client_num_permis_pos
  CHECK (client_num_permis > 0);

-- ======================================================
-- TABLE COORDONNEES
-- ======================================================
ALTER TABLE Coordonnees DROP CHECK chk_mail_format;
ALTER TABLE Coordonnees DROP CHECK chk_num_tel_portable;
ALTER TABLE Coordonnees
  ADD CONSTRAINT chk_mail_format
  CHECK (mail LIKE '%_@__%.__%'),
  ADD CONSTRAINT chk_num_tel_portable
  CHECK (telephone_portable BETWEEN 600000000 AND 799999999);

-- ======================================================
-- TABLE ADRESSE
-- ======================================================
ALTER TABLE Adresse DROP CHECK chk_code_postal_format;
ALTER TABLE Adresse DROP CHECK chk_num_rue_positif;
ALTER TABLE Adresse
  ADD CONSTRAINT chk_code_postal_format
  CHECK (code_postal BETWEEN 1000 AND 99999),
  ADD CONSTRAINT chk_num_rue_positif
  CHECK (n_rue > 0);

-- ======================================================
-- TABLE STATUT_COMMANDE
-- ======================================================
ALTER TABLE Statut_commande DROP CHECK chk_statut_com_libelle;
ALTER TABLE Statut_commande
  ADD CONSTRAINT chk_statut_com_libelle
  CHECK (statut_com_libelle IN ('En attente', 'Validée', 'En production', 'Livrée', 'Annulée'));

-- ======================================================
-- TABLE FACTURE
-- ======================================================
ALTER TABLE Facture DROP CHECK chk_montant_facture_positif;
ALTER TABLE Facture DROP CHECK chk_tva_non_negative;
ALTER TABLE Facture DROP CHECK chk_ttc_superieur_ht;
ALTER TABLE Facture
  ADD CONSTRAINT chk_montant_facture_positif
  CHECK (montant_HT >= 0 AND montant_TTC >= 0),
  ADD CONSTRAINT chk_tva_non_negative
  CHECK (TVA >= 0),
  ADD CONSTRAINT chk_ttc_superieur_ht
  CHECK (montant_TTC >= montant_HT);

-- ======================================================
-- TABLE CONFIGURATION
-- ======================================================
ALTER TABLE Configuration DROP CHECK chk_config_energie;
ALTER TABLE Configuration DROP CHECK chk_config_transmission;
ALTER TABLE Configuration
  ADD CONSTRAINT chk_config_energie
  CHECK (config_energie IN ('Essence', 'Diesel', 'Hybride', 'Electrique')),
  ADD CONSTRAINT chk_config_transmission
  CHECK (config_transmission IN ('Manuelle', 'Automatique'));

-- ======================================================
-- TABLE REPRISE
-- ======================================================
ALTER TABLE Reprise DROP CHECK chk_prix_reprise;
ALTER TABLE Reprise DROP CHECK chk_rep_vin_positif;
ALTER TABLE Reprise DROP CHECK chk_rep_etat_vehicule;
ALTER TABLE Reprise
  ADD CONSTRAINT chk_prix_reprise
  CHECK (rep_estimation_prix >= 0),
  ADD CONSTRAINT chk_rep_vin_positif
  CHECK (rep_VIN > 0),
  ADD CONSTRAINT chk_rep_etat_vehicule
  CHECK (rep_etat_vehicule IN ('Excellent', 'Bon', 'Moyen', 'Mauvais'));

-- ======================================================
-- TABLE OPTION VEHICULE
-- ======================================================
ALTER TABLE OptionVehicule DROP CHECK chk_option_libelle;
ALTER TABLE OptionVehicule
  ADD CONSTRAINT chk_option_libelle
  CHECK (option_libelle <> '');

-- ======================================================
-- TABLE GARANTIE
-- ======================================================
ALTER TABLE Garantie DROP CHECK chk_dates_garantie;
ALTER TABLE Garantie
  ADD CONSTRAINT chk_dates_garantie
  CHECK (garantie_date_fin > garantie_date_debut);

-- ======================================================
-- TABLE COMMANDE
-- ======================================================
ALTER TABLE Commande DROP CHECK chk_accompte_boolean;
ALTER TABLE Commande DROP CHECK chk_commande_statut;
ALTER TABLE Commande DROP CHECK chk_mode_financement;
ALTER TABLE Commande
  ADD CONSTRAINT chk_accompte_boolean
  CHECK (accompte IN (0,1)),
  ADD CONSTRAINT chk_commande_statut
  CHECK (commande_statut IN ('En attente', 'Confirmée', 'Annulée', 'Livrée')),
  ADD CONSTRAINT chk_mode_financement
  CHECK (mode_financement IN ('Comptant', 'Crédit', 'Leasing'));

-- ======================================================
-- TABLE VEHICULE
-- ======================================================
ALTER TABLE Vehicule DROP CHECK chk_kilometrage_non_negatif;
ALTER TABLE Vehicule DROP CHECK chk_code_pays_format;
ALTER TABLE Vehicule DROP CHECK chk_statut_vehicule;
ALTER TABLE Vehicule
  ADD CONSTRAINT chk_kilometrage_non_negatif
  CHECK (vehicule_kilometrage >= 0),
  ADD CONSTRAINT chk_code_pays_format
  CHECK (vehicule_code_pays BETWEEN 0 AND 999),
  ADD CONSTRAINT chk_statut_vehicule
  CHECK (vehicule_statut IN ('Disponible', 'Vendu', 'Réservé'));

-- ======================================================
-- TABLE LIVRAISON
-- ======================================================
ALTER TABLE Livraison DROP CHECK chk_livraison_checks_docs;
ALTER TABLE Livraison DROP CHECK chk_livraison_date_non_nulle;
ALTER TABLE Livraison
  ADD CONSTRAINT chk_livraison_checks_docs
  CHECK (livraison_checks_docs IN ('Oui', 'Non')),
  ADD CONSTRAINT chk_livraison_date_non_nulle
  CHECK (livraison_date IS NOT NULL);

-- ======================================================
-- TABLE CHOIX
-- ======================================================
-- ⚠️ Pas de contrainte CHECK sur option_ID : colonne utilisée comme clé étrangère.
-- Sa validité est déjà garantie par la FK vers OptionVehicule(option_ID).
