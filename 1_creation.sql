-- ======================================================
-- Fichier : 1_creation.sql
-- Mini-Projet Base de Données - PORSCHE
-- Groupe : Victor Haegeman & Léo Prosper
-- ======================================================

CREATE DATABASE IF NOT EXISTS porsche_db;
USE porsche_db;

-- ======================================================
-- TABLE CLIENT
-- ======================================================
CREATE TABLE Client (
    client_ID INT AUTO_INCREMENT PRIMARY KEY,
    client_num_permis INT NOT NULL UNIQUE,
    client_nom VARCHAR(50) NOT NULL,
    client_prenom VARCHAR(50) NOT NULL
);

-- ======================================================
-- TABLE COORDONNEES
-- ======================================================
CREATE TABLE Coordonnees (
    telephone_portable INT NOT NULL,
    mail VARCHAR(100) NOT NULL UNIQUE,
    telephone_fixe INT,
    client_ID INT NOT NULL,
    PRIMARY KEY (client_ID),
    FOREIGN KEY (client_ID) REFERENCES Client(client_ID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- ======================================================
-- TABLE ADRESSE
-- ======================================================
CREATE TABLE Adresse (
    adresse_ID INT AUTO_INCREMENT PRIMARY KEY,
    code_postal INT NOT NULL,
    n_rue INT NOT NULL,
    nom_rue VARCHAR(50) NOT NULL
);

-- ======================================================
-- TABLE HABITER (association entre Client et Adresse)
-- ======================================================
CREATE TABLE Habiter (
    client_ID INT NOT NULL,
    adresse_ID INT NOT NULL,
    PRIMARY KEY (client_ID, adresse_ID),
    FOREIGN KEY (client_ID) REFERENCES Client(client_ID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (adresse_ID) REFERENCES Adresse(adresse_ID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- ======================================================
-- TABLE STATUT_COMMANDE
-- ======================================================
CREATE TABLE Statut_commande (
    statut_com_ID INT AUTO_INCREMENT PRIMARY KEY,
    statut_com_libelle VARCHAR(50),
    statut_com_date DATE,
    statut_com_commentaire VARCHAR(50)
);

-- ======================================================
-- TABLE FACTURE
-- ======================================================
CREATE TABLE Facture (
    facture_ID INT AUTO_INCREMENT PRIMARY KEY,
    facture_type VARCHAR(50),
    facture_date DATE,
    montant_HT INT,
    TVA INT,
    montant_TTC INT
);

-- ======================================================
-- TABLE CONFIGURATION
-- ======================================================
CREATE TABLE Configuration (
    config_ID INT AUTO_INCREMENT PRIMARY KEY,
    config_modele VARCHAR(50),
    config_interieur VARCHAR(50),
    config_energie VARCHAR(50),
    config_transmission VARCHAR(50),
    config_code_couleur INT
);

-- ======================================================
-- TABLE REPRISE
-- ======================================================
CREATE TABLE Reprise (
    rep_ID INT AUTO_INCREMENT PRIMARY KEY,
    rep_marque VARCHAR(50),
    rep_modele VARCHAR(50),
    rep_VIN INT,
    rep_immat VARCHAR(50),
    rep_estimation_prix INT,
    rep_etat_vehicule VARCHAR(50)
);

-- ======================================================
-- TABLE OPTION
-- ======================================================
CREATE TABLE OptionVehicule (
    option_ID BOOLEAN PRIMARY KEY,
    option_libelle VARCHAR(50)
);

-- ======================================================
-- TABLE GARANTIE
-- ======================================================
CREATE TABLE Garantie (
    garantie_ID INT AUTO_INCREMENT PRIMARY KEY,
    garantie_type VARCHAR(50),
    garantie_date_debut DATE,
    garantie_date_fin DATE
);

-- ======================================================
-- TABLE COMMANDE
-- ======================================================
CREATE TABLE Commande (
    commande_ID INT AUTO_INCREMENT PRIMARY KEY,
    commande_date DATE,
    n_commission_usine INT,
    commande_statut VARCHAR(50),
    mode_financement VARCHAR(50),
    accompte BOOLEAN,
    rep_ID INT,
    facture_ID INT,
    statut_com_ID INT,
    config_ID INT,
    FOREIGN KEY (rep_ID) REFERENCES Reprise(rep_ID)
        ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (facture_ID) REFERENCES Facture(facture_ID)
        ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (statut_com_ID) REFERENCES Statut_commande(statut_com_ID)
        ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (config_ID) REFERENCES Configuration(config_ID)
        ON DELETE SET NULL ON UPDATE CASCADE
);

-- ======================================================
-- TABLE VEHICULE
-- ======================================================
CREATE TABLE Vehicule (
    VIN INT PRIMARY KEY,
    vehicule_annee DATE,
    vehicule_code_pays INT,
    vehicule_kilometrage INT,
    vehicule_statut VARCHAR(50),
    garantie_ID INT,
    commande_ID INT,
    FOREIGN KEY (garantie_ID) REFERENCES Garantie(garantie_ID)
        ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (commande_ID) REFERENCES Commande(commande_ID)
        ON DELETE SET NULL ON UPDATE CASCADE
);

-- ======================================================
-- TABLE LIVRAISON
-- ======================================================
CREATE TABLE Livraison (
    livraison_ID INT AUTO_INCREMENT PRIMARY KEY,
    livraison_date DATE,
    livraison_lieu VARCHAR(50),
    livraison_checks_docs VARCHAR(50),
    commande_ID INT,
    FOREIGN KEY (commande_ID) REFERENCES Commande(commande_ID)
        ON DELETE SET NULL ON UPDATE CASCADE
);

-- ======================================================
-- TABLE PASSER (association entre Client et Commande)
-- ======================================================
CREATE TABLE Passer (
    client_ID INT NOT NULL,
    commande_ID INT NOT NULL,
    PRIMARY KEY (client_ID, commande_ID),
    FOREIGN KEY (client_ID) REFERENCES Client(client_ID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (commande_ID) REFERENCES Commande(commande_ID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- ======================================================
-- TABLE CHOIX (association entre Configuration et Option)
-- ======================================================
CREATE TABLE Choix (
    config_ID INT NOT NULL,
    option_ID BOOLEAN NOT NULL,
    PRIMARY KEY (config_ID, option_ID),
    FOREIGN KEY (config_ID) REFERENCES Configuration(config_ID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (option_ID) REFERENCES OptionVehicule(option_ID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

