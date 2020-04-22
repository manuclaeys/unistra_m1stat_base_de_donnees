-----------TD N°9


--Renvoyer les lignes de la table Animal pour lesquelles race id vaut 7 (ou 2 selon votre bdd)
SELECT id, sexe, nom, espece_id, race_id 

FROM Animal

WHERE (id, race_id) = (

    SELECT id, espece_id

    FROM Race

    WHERE id = 2);


--- Sélectionner toutes les informations sur les animaux dont l'id est inférieur à tous les id d'espèces dont le nom courant est Tortue d''Hermann, ou Perroquet amazone

SELECT *

FROM Animal

WHERE espece_id < ALL (

    SELECT id

    FROM Espece

    WHERE nom_courant IN ('Tortue d''Hermann', 'Perroquet amazone')

);


--Sélectionner toutes les informations sur les animaux dont le nom courant de l'espèce est différent d'une Tortue dHermann, 
--ou d'un Perroquet amazone (avec une sous requête). 

SELECT id, nom, espece_id

FROM Animal

WHERE espece_id IN (

    SELECT id 

    FROM Espece

    WHERE nom_courant NOT IN ('Tortue d''Hermann', 'Perroquet amazone')

);


--Sélectionner les id de la table Espece pour lesquelles le nom\_courant est 'Tortue d'Hermann' ou 'Perroquet amazone'). 
SELECT id

FROM Espece

WHERE nom_courant IN ANY ('Tortue d''Hermann', 'Perroquet amazone');

-- Est il possible d'utiliser la synataxe "=ANY"? non
SELECT id

FROM Espece

WHERE nom_courant = ANY ('Tortue d''Hermann', 'Perroquet amazone');


--Parmi les femelles perroquets et tortues, on veut connaître la date de naissance de la plus âgée. Formuler votre requête avec une sous-requête.
SELECT MIN(date_naissance)

FROM (

    SELECT Animal.id, Animal.sexe, Animal.date_naissance, Animal.nom, Animal.espece_id

    FROM Animal

    INNER JOIN Espece

        ON Espece.id = Animal.espece_id

    WHERE sexe = 'F'

    AND Espece.nom_courant IN ('Tortue d''Hermann', 'Perroquet amazone')

) AS tortues_perroquets_F;



-- on sélectionne les races s'il existe un animal qui s'appelle Balou.

SELECT id, nom, espece_id FROM Race 

WHERE EXISTS (SELECT * FROM Animal WHERE nom = 'Balou');

--  je veux sélectionner toutes les races dont on ne possède aucun animal.

SELECT * FROM Race

WHERE NOT EXISTS (SELECT * FROM Animal WHERE Animal.race_id = Race.id);


-- je veux sélectionner toutes les races dont on ne possède aucun animal.

SELECT * FROM Race

WHERE NOT EXISTS (SELECT * FROM Animal WHERE Animal.race_id = Race.id);


-- Séléction des animaux avec au moin un enfant

SELECT * FROM Animal

WHERE id IN (SELECT pere_id FROM Animal WHERE  pere_id IS NOT NULL)
OR 
id IN (SELECT mere_id FROM Animal WHERE  mere_id IS NOT NULL);


INSERT INTO Animal 

    (nom, sexe, date_naissance, race_id, espece_id)              

    -- Je précise les colonnes puisque je ne donne pas une valeur pour toutes.

SELECT  'Yoda', 'M', '2010-11-09', id AS race_id, espece_id     

    -- Attention à l'ordre !

FROM Race WHERE nom = 'Maine coon';

-- Vérification

SELECT Animal.id, Animal.sexe, Animal.nom, Race.nom AS race, Espece.nom_courant as espece

FROM Animal

INNER JOIN Race ON Animal.race_id = Race.id

INNER JOIN Espece ON Race.espece_id = Espece.id

WHERE Race.nom = 'Maine coon';


-- Faite en sorte que tous les perroquets aient en commentaire : "Coco veut un gâteau !" sachant que vous ne savez pas que l'id de cette espèce est 4.
UPDATE Animal SET commentaires = 'Coco veut un gâteau !' WHERE espece_id = 

    (SELECT id FROM Espece WHERE nom_courant LIKE 'Perroquet%');

--INSERT INTO Race (nom, espece_id, description)

VALUES ('Nebelung', 2, 'Chat bleu russe, mais avec des poils longs...');


-- 
UPDATE Animal SET race_id = 

    (SELECT id FROM Race WHERE nom = 'Nebelung' AND espece_id = 2)

WHERE nom = 'Cawette';


--Callune Ne marche pas :

UPDATE Animal SET race_id = 

    (SELECT race_id FROM Animal WHERE nom = 'Cawette' AND espece_id = 2)

WHERE nom = 'Callune';


--ERROR 1093 (HY000): You can't specify target table 'Animal' for update in FROM clause

--La sous-requête utilise la table Animal. Or, vous cherchez à modifier le contenu de celle-ci. C'est impossible !

UPDATE Animal SET race_id = 

    (SELECT id FROM Race WHERE nom = 'Nebelung' AND espece_id = 2)

WHERE nom = 'Callune';


--  Pour les tortues et les perroquets, si un animal n'a pas de commentaire, ajouter comme commentaire la description de l'espèce, en utilisant une jointure. 

UPDATE Animal       -- Classique !

INNER JOIN Espece   -- Jointure.

    ON Animal.espece_id = Espece.id  

    -- Condition de la jointure.

SET Animal.commentaires = Espece.description        

    -- Ensuite, la modification voulue.

WHERE Animal.commentaires IS NULL                 

    -- Seulement s'il n'y a pas encore de commentaire.

AND Espece.nom_courant IN ('Perroquet amazone', 'Tortue d''Hermann');   

    -- Et seulement pour les perroquets et les tortues.



-- Suppression de Carabistouille 
    DELETE FROM Animal

WHERE nom = 'Carabistouille' AND espece_id = 

    (SELECT id FROM Espece WHERE nom_courant = 'Chat');


    -- Ajout de Carabustouille

INSERT INTO Animal 

    (nom, espece_id)  
SELECT  'Carabistouille',  id AS espece_id     

    -- Attention à l'ordre !

FROM Espece WHERE nom_courant = 'Chat';


-- suppression avec Jointure

DELETE Animal   -- Je précise de quelles tables les données doivent être supprimées

FROM Animal     -- Table principale

INNER JOIN Espece ON Animal.espece_id = Espece.id    

    -- Jointure     

WHERE Animal.nom = 'Carabistouille' 

    AND Espece.nom_courant = 'Chat';