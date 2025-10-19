-- I

-- Événements distincts par sport triés par date descendante (données : planning prioritaire, évite doublons sports)
SELECT DISTINCT s.Nom AS Sport, e.Nom AS Evenement, e.Date_ 
FROM Evenement e JOIN Concerner c ON e.Id_evenement = c.Id_evenement JOIN Sport s ON c.Id_sport = s.Id_sport 
ORDER BY e.Date_ DESC;

-- Membres dont prénom contient 'a' et nom trié (données : candidats bénévoles pour événements, filtre sémantique)
SELECT Prenom, Nom, Role_interne FROM Membre 
WHERE Prenom LIKE '%a%' OR Nom LIKE '%a%' ORDER BY Nom ASC;

-- Associations IDs 1-4 avec subventions uniques (données : assos prioritaires pour invitations)
SELECT DISTINCT a.Nom, s.Montant FROM Association a JOIN Subvention s ON a.Id_asso = s.Id_asso 
WHERE a.Id_asso IN (1, 2, 3, 4);

-- Événements entre mars et juin 2025 triés par budget réel (données : focus printemps pour planification)
SELECT Nom, Budget_reel, Date_ FROM Evenement 
WHERE Date_ BETWEEN '2025-03-01' AND '2025-06-30' ORDER BY Budget_reel DESC;

-- Projets incluant sport 'Football' ou IDs 1,3 (données : projets ciblés pour sponsoring)
SELECT DISTINCT pr.Intitule, s.Nom AS Sport FROM Projet pr JOIN Inclue i ON pr.Id_projet = i.Id_projet JOIN Sport s ON i.Id_sport = s.Id_sport 
WHERE pr.Id_projet IN (1, 3) OR s.Nom LIKE 'Foot%';

-- Cotisations annuelles >100€ entre jan-juin (données : relances payeurs précoces)
SELECT Id_membre, montant, Date_de_paimant FROM Cotisation 
WHERE Periodicite = 'annuelle' AND montant BETWEEN 100 AND 200 AND Date_de_paimant BETWEEN '2025-01-01' AND '2025-06-30' 
ORDER BY montant DESC;

-- II

-- Nombre participations par événement, seulement >5 membres (données : événements populaires pour promotion)
SELECT p.Id_evenement, e.Nom, COUNT(p.Id_membre) AS Nb_Participants
FROM Participer p JOIN Evenement e ON p.Id_evenement = e.Id_evenement
GROUP BY p.Id_evenement, e.Nom HAVING COUNT(p.Id_membre) >= 2 ORDER BY Nb_Participants DESC;

-- Moyenne et total budgets par sport, HAVING moyenne >15000 (données : sports rentables pour priorisation)
SELECT s.Nom, AVG(e.Budget_reel) AS Moy_Budget, SUM(e.Budget_reel) AS Total_Budget 
FROM Evenement e JOIN Concerner c ON e.Id_evenement = c.Id_evenement JOIN Sport s ON c.Id_sport = s.Id_sport 
GROUP BY s.Nom HAVING AVG(e.Budget_reel) > 15000;

-- Budget max par association, HAVING max >4000 (données : assos high-impact pour subventions futures)
SELECT a.Id_asso, MAX(s.Montant) AS Max_Subvention FROM Association a JOIN Subvention s ON a.Id_asso = s.Id_asso 
GROUP BY a.Id_asso HAVING MAX(s.Montant) > 4000;

-- Min durée projets par sport, HAVING count projets >1 (données : sports multi-projets pour diversification)
SELECT s.Nom, MIN(pr.Duree) AS Min_Duree, COUNT(pr.Id_projet) AS Nb_Projets 
FROM Projet pr JOIN Inclue i ON pr.Id_projet = i.Id_projet JOIN Sport s ON i.Id_sport = s.Id_sport 
GROUP BY s.Nom HAVING COUNT(pr.Id_projet) > 1;

-- Total unique financements par partenaire, HAVING total >20000 (données : partenaires majeurs pour renouvellements)
SELECT p.Id_part, SUM(DISTINCT f.Id_evenement * c.Montant / 10) AS Est_Total_Financé 
FROM Partenaire p JOIN Contrat c ON p.Id_part = c.Id_part JOIN Finance f ON c.Id_part = f.Id_part AND c.num_contrat = f.num_contrat 
GROUP BY p.Id_part HAVING SUM(DISTINCT f.Id_evenement * c.Montant / 10) > 20000;

-- Moyenne cotisations par rôle interne, HAVING avg >20 et count >3 (données : rôles rentables pour incitations)
SELECT m.Role_interne, AVG(c.montant) AS Moy_Cotisation, COUNT(c.id_cotisation) AS Nb_Cotis 
FROM Membre m JOIN Cotisation c ON m.Id_membre = c.Id_membre GROUP BY m.Role_interne HAVING AVG(c.montant) > 20 AND COUNT(c.id_cotisation) > 3;

-- III. Jointures 

-- Événements et leurs lieux (données : localisation pour logistique)
SELECT e.Nom, e.Lieu FROM Evenement e INNER JOIN Evenement e2 ON e.Id_evenement = e2.Id_evenement;  -- Simple, même table pour démo

-- Membres participants à événements via équipes et assos (données : équipes complètes pour invitations)
SELECT m.Prenom, m.Nom, e.Nom AS Evenement, a.Nom AS Asso, eq.Nom_equipe 
FROM Membre m INNER JOIN Equipe eq ON m.Id_membre = eq.Id_membre 
INNER JOIN Evenement e ON eq.Id_evenement = e.Id_evenement 
INNER JOIN Association a ON eq.Id_asso = a.Id_asso;

-- Subventions avec associations (inclut assos sans subventions)
SELECT a.Nom AS Asso, s.Montant FROM Association a LEFT JOIN Subvention s ON a.Id_asso = s.Id_asso;

-- Sports avec projets (inclut sports sans projets)
SELECT s.Nom AS Sport, pr.Intitule FROM Sport s RIGHT JOIN Inclue i ON s.Id_sport = i.Id_sport RIGHT JOIN Projet pr ON i.Id_projet = pr.Id_projet;

-- Contrats financés par partenaires, left pour événements non financés (données : gaps financements)
SELECT p.Nom AS Partenaire, c.num_contrat, e.Nom AS Evenement 
FROM Partenaire p INNER JOIN Contrat c ON p.Id_part = c.Id_part 
LEFT JOIN Finance f ON c.Id_part = f.Id_part AND c.num_contrat = f.num_contrat 
LEFT JOIN Evenement e ON f.Id_evenement = e.Id_evenement;

-- Membres et superviseurs (données : hiérarchie pour délégations)
SELECT m1.Prenom AS Membre, m2.Prenom AS Superviseur FROM Membre m1 INNER JOIN Membre m2 ON m1.Id_membre_1 = m2.Id_membre;

-- IV. Requêtes imbriquées 

-- Événements avec associations participantes (données : événements collaboratifs)
SELECT Nom FROM Evenement WHERE Id_evenement IN (SELECT Id_evenement FROM Contribue);

-- Membres sans participation événement (données : membres inactifs pour relance)
SELECT Prenom, Nom, Role_interne FROM Membre m WHERE Id_membre IN (SELECT Id_membre FROM Participer) ORDER BY Nom;

-- Projets avec responsables (données : projets actifs)
SELECT Intitule FROM Projet pr WHERE EXISTS (SELECT 1 FROM Responsable r WHERE r.Id_projet = pr.Id_projet);

-- Associations sans événements contributifs (données : assos dormantes)
SELECT a.Nom, COUNT(c.Id_evenement) AS Nb_Evenements 
FROM Association a JOIN Contribue c ON a.Id_asso = c.Id_asso 
GROUP BY a.Id_asso, a.Nom ORDER BY Nb_Evenements DESC;

-- extrait les subventions sous-financées par rapport aux budgets minimaux des projets liés aux associations
SELECT s.Montant, a.Nom AS Asso, MIN(pr.Budget) AS Min_Budget_Projet_Lie
FROM Subvention s JOIN Association a ON s.Id_asso = a.Id_asso
JOIN Membre m ON m.Id_asso = a.Id_asso
JOIN Responsable r ON r.Id_membre = m.Id_membre
JOIN Projet pr ON r.Id_projet = pr.Id_projet
GROUP BY s.Id_sub, s.Montant, a.Id_asso, a.Nom
HAVING s.Montant < MIN(pr.Budget)  
ORDER BY s.Montant DESC;

-- Événements avec budget réel >= ALL cotisations membres participants (données : événements auto-suffisants)
SELECT Nom FROM Evenement e WHERE e.Budget_reel >= ALL (SELECT c.montant FROM Cotisation c JOIN Membre m ON c.Id_membre = m.Id_membre JOIN Participer p ON m.Id_membre = p.Id_membre WHERE p.Id_evenement = e.Id_evenement);