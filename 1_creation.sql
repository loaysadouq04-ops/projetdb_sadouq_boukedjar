DROP TABLE IF EXISTS Participer;
DROP TABLE IF EXISTS Equipe;
DROP TABLE IF EXISTS Finance;
DROP TABLE IF EXISTS Contribue;
DROP TABLE IF EXISTS Concerner;
DROP TABLE IF EXISTS Inclue;
DROP TABLE IF EXISTS Responsable;
DROP TABLE IF EXISTS Cotisation;
DROP TABLE IF EXISTS Subvention;
DROP TABLE IF EXISTS Rapport;
DROP TABLE IF EXISTS Membre;
DROP TABLE IF EXISTS Projet;
DROP TABLE IF EXISTS Association;
DROP TABLE IF EXISTS Evenement;
DROP TABLE IF EXISTS Contrat;
DROP TABLE IF EXISTS Partenaire;
DROP TABLE IF EXISTS Sport;

CREATE TABLE Sport(
   Id_sport INT,
   Nom VARCHAR(50),
   Categorie VARCHAR(50),
   PRIMARY KEY(Id_sport)
); 

CREATE TABLE Partenaire(
   Id_part INT,
   Nom VARCHAR(100),
   Type VARCHAR(20),
   Coordonnes VARCHAR(100),
   PRIMARY KEY(Id_part)
);  

CREATE TABLE Contrat(
   Id_part INT,
   num_contrat VARCHAR(50),
   Montant DECIMAL(10,2),
   Duree TINYINT(3) UNSIGNED,
   PRIMARY KEY(Id_part, num_contrat),
   FOREIGN KEY(Id_part) REFERENCES Partenaire(Id_part)
);   

CREATE TABLE Evenement(
   Id_evenement INT,
   Nom VARCHAR(150),
   Date_ DATE,
   Lieu VARCHAR(100),
   Budget_preventiel DECIMAL(10,2),
   Budget_reel DECIMAL(10,2),
   PRIMARY KEY(Id_evenement)
);  

CREATE TABLE Association(
   Id_asso INT,
   Num_aggregation VARCHAR(20),
   Nom VARCHAR(100),
   Adresse VARCHAR(200),
   Discipline VARCHAR(50),
   PRIMARY KEY(Id_asso),
   UNIQUE(Num_aggregation)
);   

CREATE TABLE Subvention(
   Id_sub INT,
   Montant DECIMAL(10,2),
   Date_dattribution DATE,
   Id_asso INT NOT NULL,
   PRIMARY KEY(Id_sub),
   FOREIGN KEY(Id_asso) REFERENCES Association(Id_asso)
);   

CREATE TABLE Projet(
   Id_projet INT,
   Intitule VARCHAR(150),
   Duree TINYINT(3) UNSIGNED,
   Budget DECIMAL(10,2),
   PRIMARY KEY(Id_projet)
);   

CREATE TABLE Rapport(
   Id_rapport INT,
   Titre VARCHAR(50),
   Date_Rapport DATE,
   Type VARCHAR(50),
   Id_projet INT,
   Id_evenement INT,
   Id_asso INT,
   PRIMARY KEY(Id_rapport),
   FOREIGN KEY(Id_projet) REFERENCES Projet(Id_projet),
   FOREIGN KEY(Id_evenement) REFERENCES Evenement(Id_evenement),
   FOREIGN KEY(Id_asso) REFERENCES Association(Id_asso)
);   

CREATE TABLE Membre(
   Id_membre INT,
   Prenom VARCHAR(50),
   Nom VARCHAR(50),
   Mail VARCHAR(100),
   Telephone VARCHAR(15),
   Adresse VARCHAR(200),
   Role_interne VARCHAR(30),
   Id_asso INT NOT NULL,
   Id_membre_1 INT,
   PRIMARY KEY(Id_membre),
   FOREIGN KEY(Id_asso) REFERENCES Association(Id_asso),
   FOREIGN KEY(Id_membre_1) REFERENCES Membre(Id_membre)
);   

CREATE TABLE Cotisation(
   id_cotisation INT,
   Date_de_paimant DATE,
   Periodicite VARCHAR(20),
   montant DECIMAL(6,2),
   Id_membre INT NOT NULL,
   PRIMARY KEY(id_cotisation),
   FOREIGN KEY(Id_membre) REFERENCES Membre(Id_membre)
);

CREATE TABLE Responsable(
   Id_projet INT,
   Id_membre INT,
   PRIMARY KEY(Id_projet, Id_membre),
   FOREIGN KEY(Id_projet) REFERENCES Projet(Id_projet),
   FOREIGN KEY(Id_membre) REFERENCES Membre(Id_membre)
);   

CREATE TABLE Inclue(
   Id_sport INT,
   Id_projet INT,
   PRIMARY KEY(Id_sport, Id_projet),
   FOREIGN KEY(Id_sport) REFERENCES Sport(Id_sport),
   FOREIGN KEY(Id_projet) REFERENCES Projet(Id_projet)
);  

CREATE TABLE Concerner(
   Id_sport INT,
   Id_evenement INT,
   PRIMARY KEY(Id_sport, Id_evenement),
   FOREIGN KEY(Id_sport) REFERENCES Sport(Id_sport),
   FOREIGN KEY(Id_evenement) REFERENCES Evenement(Id_evenement)
);   

CREATE TABLE Contribue(
   Id_evenement INT,
   Id_asso INT,
   PRIMARY KEY(Id_evenement, Id_asso),
   FOREIGN KEY(Id_evenement) REFERENCES Evenement(Id_evenement),
   FOREIGN KEY(Id_asso) REFERENCES Association(Id_asso)
);   

CREATE TABLE Finance(
   Id_part INT,
   num_contrat VARCHAR(50),
   Id_evenement INT,
   PRIMARY KEY(Id_part, num_contrat, Id_evenement),
   FOREIGN KEY(Id_part, num_contrat) REFERENCES Contrat(Id_part, num_contrat),
   FOREIGN KEY(Id_evenement) REFERENCES Evenement(Id_evenement)
);

CREATE TABLE Equipe(
   Id_evenement INT,
   Id_asso INT,
   Id_membre INT,
   Nom_equipe VARCHAR(50),
   PRIMARY KEY(Id_evenement, Id_asso, Id_membre),
   FOREIGN KEY(Id_evenement) REFERENCES Evenement(Id_evenement),
   FOREIGN KEY(Id_asso) REFERENCES Association(Id_asso),
   FOREIGN KEY(Id_membre) REFERENCES Membre(Id_membre)
);   

CREATE TABLE Participer(
   Id_evenement INT,
   Id_membre INT,
   role_event VARCHAR(50),
   PRIMARY KEY(Id_evenement, Id_membre),
   FOREIGN KEY(Id_evenement) REFERENCES Evenement(Id_evenement),
   FOREIGN KEY(Id_membre) REFERENCES Membre(Id_membre)
); 
