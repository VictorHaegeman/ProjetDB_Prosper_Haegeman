MINI-PROJET MERISE — PARTIE 1 (Configuration & Achat)

Centre Porsche — Rapport

	1.	Objectif
Concevoir le système d’information d’un Centre Porsche, limité à la configuration et à l’achat d’un véhicule : commande et options codées, suivi des statuts, attribution du VIN, livraison, financement, reprise, facturation. Le SAV (atelier, pièces, entretiens) est hors périmètre pour cette partie.

	2.	Périmètre
IN : configuration véhicule, commande, codes options, statuts (allocation / production / transit / livré), VIN et livraison, financement (comptant / crédit / LOA / LLD), reprise, facture de vente.
OUT : après-vente/SAV, services connectés, gestion de stock de pièces.

	3.	Méthode (IAG)
Nous avons rédigé un prompt précis pour obtenir :
– des règles de gestion en langage métier (non technique) ;
– un dictionnaire de données brutes (25–35 éléments : signification, type, taille).
À partir de ces éléments, le MCD est réalisé avec un outil de modélisation (image à insérer à la fin du README ; fichier source déposé dans le dépôt).

	4.	Prompt partie 1 (à l’identique)
Tu travailles dans le domaine de l’automobile premium, spécialisé Porsche.
Ton entreprise a comme activité de Centre Porsche franchisé en France : configuration et achat de véhicules (neufs et d’occasion labellisés Porsche Approved), suivi de commande et de production, livraison, gestion des reprises et facturation. (Hors périmètre : après-vente/atelier/entretien.)
C’est une entreprise comme Centre Porsche Paris, Centre Porsche Lyon, Centre Porsche Bordeaux (réseau officiel Porsche).
Informations utiles à mettre dans la base : identification des clients et prospects, commandes configurées (numéro de commission usine, modèle, type interne Porsche 992/971/9Y0…, énergie, transmission, couleurs), liste codifiée d’options (codes usine) liée à chaque configuration, suivi des statuts de la commande (allocation, production, transit, livré), attribution du véhicule physique par VIN (17 caractères) puis enregistrement de la livraison (lieu/date/documents), modalités de financement (comptant/crédit/LOA/LLD), reprise éventuelle d’un véhicule, et facturation finale.
Inspire-toi du site web suivant : pages officielles Porsche France (Garantie véhicule neuf, Porsche Approved) et référentiels publics de codes d’options Porsche.

Ton entreprise veut appliquer MERISE pour concevoir un système d’information. Tu es chargé de la partie analyse, c’est-à-dire de collecter les besoins auprès de l’entreprise. Elle a fait appel à un étudiant en ingénierie informatique pour réaliser ce projet, tu dois lui fournir les informations nécessaires pour qu’il applique ensuite lui-même les étapes suivantes de conception et développement de la base de données.

D’abord, établis les règles de gestions des données de ton entreprise, sous la forme d’une liste à puce. Elle doit correspondre aux informations que fournit quelqu’un qui connaît le fonctionnement de l’entreprise, mais pas comment se construit un système d’informations.

Ensuite, à partir de ces règles, fournis un dictionnaire de données brutes avec les colonnes suivantes, regroupées dans un tableau : signification de la donnée, type, taille en nombre de caractères ou de chiffres. Il doit y avoir entre 25 et 35 données. Il sert à fournir des informations supplémentaires sur chaque données (taille et type) mais sans a priori sur comment les données vont être modélisées ensuite.

Fournis donc les règles de gestion et le dictionnaire de données.

Sortie — Règles de gestion (métier)

– Un client est identifié par un identifiant interne ; un même client peut passer plusieurs commandes.

– Chaque commande est associée à un et un seul client et porte une configuration figée (modèle, type interne, énergie, transmission, teintes).

– Les options d’une configuration sont codifiées via des codes usine Porsche ; une configuration peut comporter plusieurs options.

– Le numéro de commission (usine) identifie la commande côté production ; l’évolution de la commande est suivie par statuts (allocation, production, transit, livré) avec date et commentaire.

– L’attribution du véhicule physique à une commande se fait par le VIN (17 caractères), unique ; sans VIN attribué, la commande ne peut pas être livrée.

– La livraison enregistre la date, le lieu et la complétude des documents remis au client.

– Le financement est saisi (comptant, crédit, LOA, LLD) ; un acompte peut être enregistré ; le prix total TTC = prix de base + options.

– Une reprise (trade-in) peut être liée à la commande avec indication d’une estimation de valeur.

– La facturation de vente est émise à la livraison avec le montant TTC.

– Contraintes de qualité : VIN unique (17 caractères), codes options conformes au référentiel, cohérence des montants, chronologie des dates (statuts, livraison).

Sortie — Dictionnaire de données brutes (35 éléments)
(Colonne 1 : Signification — Colonne 2 : Type — Colonne 3 : Taille)

1.	Client_ID — Numérique entier — 9 chiffres
2.	Client_Nom — Texte — 50
3.	Client_Prenom — Texte — 50
4.	Client_Email — Texte (email) — 100
5.	Client_Telephone — Texte (numéro) — 15
6.	Client_Adresse — Texte (voie + CP + ville) — 180
7.	Client_ConsentementMarketing — Enum (oui/non) — 5
8.	Commande_ID — Numérique entier — 9 chiffres
9.	Commande_Date — Date — —
10.	Commande_NumCommission — Texte — 12
11.	Commande_ModeFinancement — Enum (comptant/credit/LOA/LLD) — 10
12.	Commande_Acompte — Décimal — 10,2
13.	Commande_PrixBaseTTC — Décimal — 12,2
14.	Commande_PrixTotalTTC — Décimal — 12,2
15.	Configuration_ID — Numérique entier — 9 chiffres
16.	Modele_Commercial — Texte — 60
17.	Type_Interne — Texte — 6
18.	Energie — Enum (essence/hybride/électrique) — 12
19.	Transmission — Enum (BVM/PDK/AT) — 12
20.	CouleurExt_Code — Texte — 8
21.	CouleurInt_Code — Texte — 8
22.	Option_Code — Texte (code usine) — 6
23.	Option_Libelle — Texte — 100
24.	ConfigOption_Quantite — Numérique entier — 2 chiffres
25.	ConfigOption_PrixUnitaireTTC — Décimal — 10,2
26.	Vehicule_VIN — Texte (numéro de série) — 17
27.	Livraison_ID — Numérique entier — 9 chiffres
28.	Livraison_Date — Date — —
29.	Livraison_Lieu — Texte — 60
30.	Statut_Libelle — Texte — 20
31.	Statut_Date — Date — —
32.	Statut_Commentaire — Texte — 200
33.	Facture_ID — Numérique entier — 9 chiffres
34.	Facture_MontantTTC — Décimal — 12,2
35.	Reprise_Estimation — Décimal — 12,2

Notes d’application
– VIN : 17 caractères, unicité forte ; ne pas tronquer.

– Les codes d’option sont conservés tels quels (ex. “0Q”, “1N3”, “G1D”).

– Les statuts sont historisés via un couple (Statut_Libelle, Statut_Date) ; Statut_Commentaire est facultatif.

– Les montants sont en euros ; 2 décimales.

– Les tailles ci-dessus guident la saisie sans présumer des clés ou de la structure finale (modélisation à l’étape MCD/MLD).

	5.	MCD
L’image du MCD correspondant (entités/associations/cardinalités) sera ajoutée ici. Le fichier source du MCD (outil de modélisation) est déposé dans le dépôt.
![MSD](MCD.jpg)

	6. Prompt partie 2

Tu travailles dans le domaine de l’automobile premium, au sein d’un Centre Porsche franchisé en France.
Ton entreprise a pour activité la configuration, la vente et la livraison de véhicules neufs et d’occasion labellisés Porsche Approved, ainsi que la gestion des reprises, des financements et de la facturation.
(Hors périmètre : atelier, entretien, après-vente.)

C’est une entreprise comme Centre Porsche Paris, Centre Porsche Lyon, ou Centre Porsche Bordeaux, qui fait partie du réseau officiel Porsche France.
Elle gère l’ensemble du processus de vente : du client au véhicule livré, en passant par la commande, la configuration, le suivi de production, la facturation et la garantie.

Objectif :
Tu dois générer automatiquement des données d’insertion SQL réalistes et cohérentes, destinées à remplir la base de données Porsche utilisée pour la gestion des commandes et livraisons.
Ces données doivent correspondre au Modèle Logique de Données (MLD) suivant :

Client(client_ID, client_num_permis, client_nom, client_prenom)

Coordonnées(telephone_portable, mail, telephone_fixe, #client_ID)

Adresse(adresse_ID, code_postal, n_rue, nom_rue)

Statut_commande(statut_com_ID, statut_com_libelle, statut_com_date, statut_com_commentaire)

Facture(facture_ID, facture_type, facture_date, montant_HT, TVA, montant_TTC)

Configuration(config_ID, config_modele, config_interieur, config_energie, config_transmission, config_code_couleur)

Reprise(rep_ID, rep_marque, rep_modele, rep_VIN, rep_immat, rep_estimation_prix, rep_etat_vehicule)

Option(option_ID, option_libelle)

Garantie(garantie_ID, garantie_type, garantie_date_debut, garantie_date_fin)

Commande(commande_ID, commande_date, n_commission_usine, commande_statut, mode_financement, accompte, #rep_ID, #facture_ID, #statut_com_ID, #config_ID)

Vehicule(VIN, vehicule_annee, vehicule_code_pays, vehicule_kilometrage, vehicule_statut, #garantie_ID, #commande_ID)

Livraison(livraison_ID, livraison_date, livraison_lieu, livraison_checks_docs, #commande_ID)

Habiter(#client_ID, #adresse_ID)

Passer(#client_ID, #commande_ID)

Choix(#config_ID, #option_ID)

Règles de cohérence à respecter :

Relations de clé étrangère : toutes les clés marquées par # doivent exister avant d’être référencées.
Exemple : un client_ID doit être créé avant sa commande, un commande_ID avant sa livraison.

Nombres de lignes : génère entre 10 et 20 enregistrements par table.

Valeurs réalistes et variées :

Noms et prénoms français plausibles.

Emails valides, téléphones français (06/07).

Adresses cohérentes (n° + rue + code postal + ville).

Véhicules Porsche actuels (911, Taycan, Cayenne, Panamera, Macan, 718).

Codes d’options conformes aux formats usine (ex : "0Q", "1N3", "G1D").

VIN : 17 caractères uniques, mélange de lettres et chiffres.

Statuts de commande parmi : 'En attente', 'Confirmée', 'En production', 'Livrée'.

Modes de financement : 'Comptant', 'Crédit', 'LOA', 'LLD'.

Montants positifs, TVA réaliste (~20%), TTC ≥ HT.

Chronologie cohérente : commande < livraison < facture < garantie.

Types logiques :

accompte = 0 ou 1

livraison_checks_docs = 'Oui' ou 'Non'

vehicule_statut = 'Disponible', 'Vendu', 'Réservé'

Tâche :

Génère pour chaque table un bloc SQL d’insertion clair, sous la forme :

-- Insertion dans la table Client
INSERT INTO Client (client_ID, client_num_permis, client_nom, client_prenom)
VALUES (1, 457821963, 'Dupont', 'Pierre'),
       (2, 475893126, 'Martin', 'Claire'),
       (3, 468912754, 'Durand', 'Julien');


Respecte cet ordre logique (afin de préserver les clés étrangères) :
1. Client
2. Coordonnées
3. Adresse
4. Habiter
5. Statut_commande
6. Facture
7. Configuration
8. Option
9. Choix
10. Reprise
11. Commande
12. Vehicule
13. Livraison
14.  Garantie
15.  Passer

Les valeurs doivent être cohérentes entre tables (par ex. commande_ID 1 correspond au client_ID 1).

N’utilise aucune donnée fictive aléatoire qui violerait la cohérence du modèle (pas de dates inversées ou de montants négatifs).


	7. Contexte 
**Scénario d'utilisation :**

L'entreprise Porsche France dispose d'une base de données centralisant la gestion des commandes clients.

Un conseiller commercial utilise cette base de données pour suivre l'activité des ventes : il doit pouvoir identifier les clients actifs, les véhicules vendus, le chiffres d'affaire généré, les tendances par modèle et par type d'énergie, ainsi que les livraisons récentes.

**Rôle de la personne : Conseiller commercial :**

Mission principale : suivre et analyser les ventes et les commandes afin de piloter l'activité commerciale du concessionnare.

**Données à extraire :**

Le conseiller doit pouvoir consulter et analyser :

1. Les clients ayant passé une commande (nom, prénom, contact, numéro de permis).

2. Les commandes récentes, avec leur statut, leur mode de financement et la date.

3. Les véhicules vendus et leurs caractéristiques (modèle, énergie, transmission, kilométrage).

4. Le montant des ventes réalisées, avec les totaux TTC et le calcul du chiffre d’affaires global ou moyen.

5. Les livraisons récentes ou en attente, avec la date et le lieu.

6. Les options les plus choisies dans les configurations.

7. Les garanties associées aux véhicules livrés.

8. Les commandes annulées ou en attente de validation.

**Objectif du scénario :**

Grâce à ces données, le conseiller doit pouvoir :

1. suivre les ventes et livraisons,

2. identifier les clients les plus actifs,

3. repérer les modèles et énergies les plus demandés,

4. évaluer le chiffre d’affaires par période,

5. détecter les commandes en anomalie (non livrées, annulées…).
