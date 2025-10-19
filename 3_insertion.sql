-- Script d'insertion pour BD ONG sportive - Données réalistes (total ~80 enregistrements)
-- Ordre : Parents d'abord (Sport, Partenaire, Association, Evenement, Projet, Membre), puis dépendants
-- Respect contraintes : FK valides, NOT NULL remplis, budgets >=0, durées >0, exclusivité Rapport via Type, UNIQUE Num_aggregation

INSERT INTO Sport (Id_sport, Nom, Categorie) VALUES
(1, 'Football', 'Collectif'),
(2, 'Basketball', 'Collectif'),
(3, 'Tennis', 'Individuel'),
(4, 'Natation', 'Individuel'),
(5, 'Athlétisme', 'Individuel'),
(6, 'Volleyball', 'Collectif'),
(7, 'Handball', 'Collectif'),
(8, 'Cyclisme', 'Individuel'),
(9, 'Judo', 'Combat'),
(10, 'Yoga', 'Bien-être');

INSERT INTO Partenaire (Id_part, Nom, Type, Coordonnes) VALUES
(1, 'Mairie de Paris', 'public', 'contact@mairie.paris.fr / 01 42 76 40 40'),
(2, 'Entreprise Decathlon', 'prive', 'partenariat@decathlon.fr / 03 20 26 78 00'),
(3, 'Fondation Sport pour Tous', 'ONG', 'info@sportpourtous.org / 01 45 67 89 01'),
(4, 'Région Île-de-France', 'public', 'sport@idf.fr / 01 53 85 30 00'),
(5, 'Adidas France', 'prive', 'sponsor@adidas.fr / 01 41 23 45 67'),
(6, 'UNICEF France', 'ONG', 'sport@unicef.fr / 01 46 23 00 00');

INSERT INTO Association (Id_asso, Num_aggregation, Nom, Adresse, Discipline) VALUES
(1, 'ASSO001', 'Club Foot Paris Est', '12 Rue de la Paix, 75002 Paris', 'Football'),
(2, 'ASSO002', 'Basket Solidaire Lyon', '45 Ave des Sports, 69001 Lyon', 'Basketball'),
(3, 'ASSO003', 'Tennis Inclusion', '78 Bd Saint-Germain, 75006 Paris', 'Tennis'),
(4, 'ASSO004', 'Natation Jeunes', '23 Quai de la Marne, 93100 Montreuil', 'Natation'),
(5, 'ASSO005', 'Athlé Santé Bobigny', '56 Rue du Stade, 93000 Bobigny', 'Athlétisme'),
(6, 'ASSO006', 'Volley Femmes Marseille', '34 Ave du Prado, 13008 Marseille', 'Volleyball'),
(7, 'ASSO007', 'Handi Sport Nord', '90 Rue de Lille, 59000 Lille', 'Handball'),
(8, 'ASSO008', 'Cyclo Éco Toulouse', '67 Bd des Minimes, 31000 Toulouse', 'Cyclisme');

INSERT INTO Evenement (Id_evenement, Nom, Date_, Lieu, Budget_preventiel, Budget_reel) VALUES
(1, 'Tournoi Foot Solidaire', '2025-03-15', 'Stade de France, Paris', 15000.00, 14850.00),
(2, 'Compétition Basket Inclusion', '2025-04-20', 'Halle Tony Garnier, Lyon', 12000.00, 12200.00),
(3, 'Open Tennis Jeunes', '2025-05-10', 'Roland Garros, Paris', 20000.00, 19800.00),
(4, 'Challenge Natation', '2025-06-05', 'Piscine Molitor, Paris', 8000.00, 7800.00),
(5, 'Marathon Athlé', '2025-07-14', 'Champs-Élysées, Paris', 25000.00, 25200.00),
(6, 'Tournoi Volley', '2025-08-22', 'Palais des Sports, Marseille', 10000.00, 10200.00),
(7, 'Coupe Handball', '2025-09-18', 'Stade Pierre Mauroy, Lille', 14000.00, 13800.00),
(8, 'Rallye Cyclo', '2025-10-12', 'Parc de la Villette, Paris', 9000.00, 9200.00),
(9, 'Festival Judo', '2025-11-08', 'Dojo National, Paris', 11000.00, 10800.00),
(10, 'Journée Yoga Bien-être', '2025-12-20', 'Parc des Princes, Paris', 5000.00, 5200.00);

-- 5 projets
INSERT INTO Projet (Id_projet, Intitule, Duree, Budget) VALUES
(1, 'Inclusion via Football', 12, 30000.00),
(2, 'Éducation par Basket', 6, 15000.00),
(3, 'Santé Tennis', 9, 20000.00),
(4, 'Natation pour Tous', 8, 18000.00),
(5, 'Athlé Jeunesse', 10, 25000.00);

-- 20 membres
INSERT INTO Membre (Id_membre, Prenom, Nom, Mail, Telephone, Adresse, Role_interne, Id_asso, Id_membre_1) VALUES
(1, 'Jean', 'Dupont', 'jean.dupont@email.fr', '06 12 34 56 78', '12 Rue de la Paix, 75002 Paris', 'joueur', 1, NULL),
(2, 'Marie', 'Martin', 'marie.martin@email.fr', '06 98 76 54 32', '45 Ave des Sports, 69001 Lyon', 'benevole', 2, 1),
(3, 'Pierre', 'Durand', 'pierre.durand@email.fr', '06 11 22 33 44', '78 Bd Saint-Germain, 75006 Paris', 'entraineur', 3, NULL),
(4, 'Sophie', 'Leroy', 'sophie.leroy@email.fr', '06 55 66 77 88', '23 Quai de la Marne, 93100 Montreuil', 'joueur', 4, 3),
(5, 'Louis', 'Roux', 'louis.roux@email.fr', '06 99 00 11 22', '56 Rue du Stade, 93000 Bobigny', 'encadrant', 5, NULL),
(6, 'Claire', 'Moreau', 'claire.moreau@email.fr', '06 33 44 55 66', '34 Ave du Prado, 13008 Marseille', 'benevole', 6, 5),
(7, 'Thomas', 'Petit', 'thomas.petit@email.fr', '06 77 88 99 00', '90 Rue de Lille, 59000 Lille', 'joueur', 7, NULL),
(8, 'Julie', 'Simon', 'julie.simon@email.fr', '06 44 55 66 77', '67 Bd des Minimes, 31000 Toulouse', 'entraineur', 8, 7),
(9, 'Alex', 'Bernard', 'alex.bernard@email.fr', '06 22 33 44 55', '12 Rue de la Paix, 75002 Paris', 'benevole', 1, NULL),
(10, 'Emma', 'Dubois', 'emma.dubois@email.fr', '06 66 77 88 99', '45 Ave des Sports, 69001 Lyon', 'joueur', 2, 9),
(11, 'Nicolas', 'Lambert', 'nicolas.lambert@email.fr', '06 00 11 22 33', '78 Bd Saint-Germain, 75006 Paris', 'encadrant', 3, NULL),
(12, 'Laura', 'Fontaine', 'laura.fontaine@email.fr', '06 88 99 00 11', '23 Quai de la Marne, 93100 Montreuil', 'benevole', 4, 11),
(13, 'Hugo', 'Michel', 'hugo.michel@email.fr', '06 55 66 77 88', '56 Rue du Stade, 93000 Bobigny', 'joueur', 5, NULL),
(14, 'Camille', 'Lefevre', 'camille.lefevre@email.fr', '06 11 22 33 44', '34 Ave du Prado, 13008 Marseille', 'entraineur', 6, 13),
(15, 'Maxime', 'Boyer', 'maxime.boyer@email.fr', '06 44 55 66 77', '90 Rue de Lille, 59000 Lille', 'benevole', 7, NULL),
(16, 'Léa', 'Girard', 'lea.girard@email.fr', '06 77 88 99 00', '67 Bd des Minimes, 31000 Toulouse', 'joueur', 8, 15),
(17, 'Antoine', 'Andre', 'antoine.andre@email.fr', '06 33 44 55 66', '12 Rue de la Paix, 75002 Paris', 'encadrant', 1, NULL),
(18, 'Sara', 'Blanc', 'sara.blanc@email.fr', '06 66 77 88 99', '45 Ave des Sports, 69001 Lyon', 'benevole', 2, 17),
(19, 'Victor', 'Caron', 'victor.caron@email.fr', '06 99 00 11 22', '78 Bd Saint-Germain, 75006 Paris', 'joueur', 3, NULL),
(20, 'Nina', 'Delorme', 'nina.delorme@email.fr', '06 22 33 44 55', '23 Quai de la Marne, 93100 Montreuil', 'entraineur', 4, 19);

-- 8 contrats
INSERT INTO Contrat (Id_part, num_contrat, Montant, Duree) VALUES
(1, 'C001', 25000.00, 12),
(2, 'C002', 18000.00, 6),
(3, 'C003', 30000.00, 18),
(4, 'C004', 15000.00, 9),
(5, 'C005', 22000.00, 12),
(6, 'C006', 10000.00, 3),
(1, 'C007', 12000.00, 6),
(2, 'C008', 28000.00, 15);

-- 15 subventions
INSERT INTO Subvention (Id_sub, Montant, Date_dattribution, Id_asso) VALUES
(1, 5000.00, '2025-01-15', 1),
(2, 4000.00, '2025-02-10', 2),
(3, 6000.00, '2025-03-05', 3),
(4, 3500.00, '2025-04-20', 4),
(5, 7000.00, '2025-05-12', 5),
(6, 4500.00, '2025-06-08', 6),
(7, 5500.00, '2025-07-18', 7),
(8, 3000.00, '2025-08-22', 8),
(9, 6500.00, '2025-09-14', 1),
(10, 4800.00, '2025-10-09', 2),
(11, 5200.00, '2025-11-03', 3),
(12, 3800.00, '2025-12-17', 4),
(13, 7200.00, '2025-01-25', 5),
(14, 4200.00, '2025-02-28', 6),
(15, 5800.00, '2025-03-30', 7);

-- 12 cotisations
INSERT INTO Cotisation (id_cotisation, Date_de_paimant, Periodicite, montant, Id_membre) VALUES
(1, '2025-01-01', 'annuelle', 150.00, 1),
(2, '2025-02-01', 'mensuelle', 15.00, 2),
(3, '2025-03-01', 'annuelle', 150.00, 3),
(4, '2025-04-01', 'mensuelle', 15.00, 4),
(5, '2025-05-01', 'annuelle', 150.00, 5),
(6, '2025-06-01', 'mensuelle', 15.00, 6),
(7, '2025-07-01', 'annuelle', 150.00, 7),
(8, '2025-08-01', 'mensuelle', 15.00, 8),
(9, '2025-09-01', 'annuelle', 150.00, 9),
(10, '2025-10-01', 'mensuelle', 15.00, 10),
(11, '2025-11-01', 'annuelle', 150.00, 11),
(12, '2025-12-01', 'mensuelle', 15.00, 12);

-- 10 responsables (au moins 1 par projet)
INSERT INTO Responsable (Id_projet, Id_membre) VALUES
(1, 1), (1, 3),
(2, 2), (2, 4),
(3, 5), (3, 7),
(4, 6), (4, 8),
(5, 9), (5, 11);

-- 8 inclue (projets-sports)
INSERT INTO Inclue (Id_sport, Id_projet) VALUES
(1, 1), (2, 2),
(3, 3), (4, 4),
(5, 5), (1, 3),
(2, 4), (3, 5);

-- 12 concerner (événements-sports)
INSERT INTO Concerner (Id_sport, Id_evenement) VALUES
(1, 1), (2, 2),
(3, 3), (4, 4),
(5, 5), (6, 6),
(7, 7), (8, 8),
(9, 9), (10, 10),
(1, 2), (2, 1);

-- 10 contribuent (événements-associations)
INSERT INTO Contribue (Id_evenement, Id_asso) VALUES
(1, 1), (2, 2),
(3, 3), (4, 4),
(5, 5), (6, 6),
(7, 7), (8, 8),
(9, 1), (10, 2);

-- 8 finance (contrats-événements)
INSERT INTO Finance (Id_part, num_contrat, Id_evenement) VALUES
(1, 'C001', 1),
(2, 'C002', 2),
(3, 'C003', 3),
(4, 'C004', 4),
(5, 'C005', 5),
(6, 'C006', 6),
(1, 'C007', 7),
(2, 'C008', 8);

-- 15 equipe (ternaire evenements-asso-membres)
INSERT INTO Equipe (Id_evenement, Id_asso, Id_membre, Nom_equipe) VALUES
(1, 1, 1, 'Equipe Alpha'),
(1, 1, 2, 'Equipe Alpha'),
(2, 2, 3, 'Equipe Beta'),
(2, 2, 4, 'Equipe Beta'),
(3, 3, 5, 'Equipe Gamma'),
(3, 3, 6, 'Equipe Gamma'),
(4, 4, 7, 'Equipe Delta'),
(4, 4, 8, 'Equipe Delta'),
(5, 5, 9, 'Equipe Epsilon'),
(5, 5, 10, 'Equipe Epsilon'),
(6, 6, 11, 'Equipe Zeta'),
(6, 6, 12, 'Equipe Zeta'),
(7, 7, 13, 'Equipe Eta'),
(7, 7, 14, 'Equipe Eta'),
(8, 8, 15, 'Equipe Theta');

-- 20 participer (membres-événements)
INSERT INTO Participer (Id_evenement, Id_membre, role_event) VALUES
(1, 1, 'joueur'),
(1, 2, 'arbitre'),
(2, 3, 'staff'),
(2, 4, 'benevole'),
(3, 5, 'joueur'),
(3, 6, 'arbitre'),
(4, 7, 'staff'),
(4, 8, 'benevole'),
(5, 9, 'joueur'),
(5, 10, 'arbitre'),
(6, 11, 'staff'),
(6, 12, 'benevole'),
(7, 13, 'joueur'),
(7, 14, 'arbitre'),
(8, 15, 'staff'),
(8, 16, 'benevole'),
(9, 17, 'joueur'),
(9, 18, 'arbitre'),
(10, 19, 'staff'),
(10, 20, 'benevole');

-- 8 rapports (exclusifs, Type détermine FK)
INSERT INTO Rapport (Id_rapport, Titre, Date_Rapport, Type, Id_projet, Id_evenement, Id_asso) VALUES
(1, 'Bilan Projet Inclusion', '2025-04-01', 'projet', 1, NULL, NULL),
(2, 'Bilan Tournoi Foot', '2025-03-20', 'event', NULL, 1, NULL),
(3, 'Bilan Asso Foot Paris', '2025-02-15', 'asso', NULL, NULL, 1),
(4, 'Bilan Projet Éducation', '2025-07-01', 'projet', 2, NULL, NULL),
(5, 'Bilan Compétition Basket', '2025-04-25', 'event', NULL, 2, NULL),
(6, 'Bilan Asso Basket Lyon', '2025-03-10', 'asso', NULL, NULL, 2),
(7, 'Bilan Projet Santé', '2025-10-01', 'projet', 3, NULL, NULL),
(8, 'Bilan Open Tennis', '2025-05-15', 'event', NULL, 3, NULL);