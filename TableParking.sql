CREATE TYPE nbRoues AS enum ('2','4','8');
CREATE TYPE typePlace AS enum ('couvert' , 'dehors');
CREATE TYPE typePersonne AS enum ('personne', 'societe');
CREATE TYPE moyenP AS enum ('carte', 'monnaie');
create type typeTransac as enum ('ticket', 'abonnement');


CREATE TABLE Zone ( 
        nom_zone varchar (50) PRIMARY KEY, 
        prix_h_zone int , 
        prix_m_zone int 
);

-- CREATION DES BASES UTILISATEUR, ROLE ET PAGE POUR LA CONNEXION
CREATE TABLE Role (
	type_role varchar(50) PRIMARY KEY
);

create table Client(
	login varchar(25) primary key,
	nom varchar(25) NOT NULL,
	typeP typePersonne NOT NULL,
	mot_de_passe varchar(25) NOT NULL,
	role_client varchar(50) NOT NULL,
	abonne boolean,
	FOREIGN KEY (role_client) REFERENCES Role(type_role) ON DELETE CASCADE ON UPDATE CASCADE
);

create table compte (
        numero_de_compte SERIAL PRIMARY KEY,
        taux_de_reduction double precision,
        loginC character varying(25) UNIQUE NOT NULL,
        FOREIGN KEY (loginC) REFERENCES client (login) ON DELETE CASCADE ON UPDATE CASCADE
);

create table Administrateur(
	login varchar(25) primary key,
	nom varchar(25) NOT NULL,
	mot_de_passe varchar(25) NOT NULL,
	role_admin varchar(50) NOT NULL,
	FOREIGN KEY (role_admin) REFERENCES Role(type_role) ON DELETE CASCADE ON UPDATE CASCADE
);



create table Type_vehicule(
	nb_roues nbRoues primary key
);

create table Vehicule(
	immatriculation varchar(25) primary key,
	date_fabrication integer,
	marque varchar(25),
	proprietaire varchar(25) NOT NULL,
	type_veh nbRoues NOT NULL,
	FOREIGN KEY (type_veh) REFERENCES Type_vehicule(nb_roues) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (proprietaire) REFERENCES Client(login) ON DELETE CASCADE ON UPDATE CASCADE
);

create table Parking(
	nom_park varchar(50) PRIMARY KEY, 
	zone_park varchar (50), 
	nbplaces_park int NOT NULL, 
	free_places int, 
	FOREIGN KEY (zone_park) REFERENCES Zone(nom_zone)
);

CREATE TABLE Autorise ( 
	parking varchar (50), 
	type_veh_a nbRoues, 
	PRIMARY KEY(parking, type_veh_a),
	FOREIGN KEY (parking) REFERENCES Parking (nom_park) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (type_veh_a) REFERENCES Type_vehicule(nb_roues) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Place (
	num_place int, 
	park_place varchar (50),  
	type_place typePlace, 
	type_veh nbRoues, 
	PRIMARY KEY(num_place, park_place), 
	FOREIGN KEY (park_place) REFERENCES Parking(nom_park) ON DELETE CASCADE ON UPDATE CASCADE, 
	FOREIGN KEY (type_veh) REFERENCES Type_vehicule(nb_roues) ON DELETE CASCADE ON UPDATE CASCADE	
);

CREATE TABLE Occupe (
	immatriculation varchar(25), 
	nom_park varchar (50), 
	numero int, 
	date_debut timestamp with time zone NOT NULL, 
	date_fin timestamp with time zone NOT NULL, 
	PRIMARY KEY(immatriculation, nom_park, numero),
	FOREIGN KEY (immatriculation) REFERENCES Vehicule(immatriculation) ON DELETE CASCADE ON UPDATE CASCADE, 
	FOREIGN KEY (nom_park, numero) REFERENCES Place(park_place, num_place) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Transac (
	numero_transac SERIAL PRIMARY KEY,
	date_achat timestamp with time zone NOT NULL,
	date_debut timestamp with time zone NOT NULL,
	date_fin timestamp with time zone NOT NULL,
	prix float NOT NULL,
	type_t typeTransac NOT NULL,
	numero_paiement integer,
	moyen_p moyenP NOT NULL,
	client varchar(25) REFERENCES Client(login) ON DELETE CASCADE ON UPDATE CASCADE,
	nom_park varchar(50),
	numero_place integer,
	FOREIGN KEY (nom_park, numero_place) REFERENCES Place(park_place, num_place) ON DELETE CASCADE ON UPDATE CASCADE
);



/*Useless*/
/*create table utilisateur (
	pseudo varchar(50) PRIMARY KEY NOT NULL,
	mot_de_passe varchar(50),
	type_user varchar(50) REFERENCES Role(type_role) ON DELETE CASCADE ON UPDATE CASCADE
);*/

CREATE TABLE Page (
	ID_page SERIAL PRIMARY KEY,
	nom_page varchar(50) NOT NULL
);
CREATE TABLE RolePage (
	numero_page int REFERENCES Page(ID_page) ON DELETE CASCADE ON UPDATE CASCADE,
	role_page varchar(50) REFERENCES Role(type_role) ON DELETE CASCADE ON UPDATE CASCADE
);
