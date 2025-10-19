-- Budgets/montants positifs (règle finances >0, dico DECIMAL)

ALTER TABLE Evenement ADD CONSTRAINT CHK_Budget_Preventiel CHECK (Budget_preventiel >= 0);
ALTER TABLE Evenement ADD CONSTRAINT CHK_Budget_Reel CHECK (Budget_reel >= 0);
ALTER TABLE Projet ADD CONSTRAINT CHK_Budget CHECK (Budget >= 0);
ALTER TABLE Subvention ADD CONSTRAINT CHK_Montant_Sub CHECK (Montant >= 0);
ALTER TABLE Cotisation ADD CONSTRAINT CHK_Montant_Cot CHECK (montant >= 0);
ALTER TABLE Contrat ADD CONSTRAINT CHK_Montant_Contrat CHECK (Montant >= 0);

-- Exclusivité Rapport (règle "exactement un élément", via Type discriminant)

ALTER TABLE Rapport ADD CONSTRAINT CHK_Rapport_Exclusive CHECK (
  (Type = 'asso' AND Id_asso IS NOT NULL AND Id_evenement IS NULL AND Id_projet IS NULL) OR
  (Type = 'event' AND Id_evenement IS NOT NULL AND Id_asso IS NULL AND Id_projet IS NULL) OR
  (Type = 'projet' AND Id_projet IS NOT NULL AND Id_asso IS NULL AND Id_evenement IS NULL)
);

-- Durées positives (règle projets/contrats >0 mois, dico Entier 3 chiffres)

ALTER TABLE Projet ADD CONSTRAINT CHK_Duree CHECK (Duree > 0);
ALTER TABLE Contrat ADD CONSTRAINT CHK_Duree_Contrat CHECK (Duree > 0);
