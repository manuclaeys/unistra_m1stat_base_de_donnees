SELECT Espece.id,                   -- ici, pas le choix, il faut préciser

       Espece.description,          -- ici, on pourrait mettre juste description

       Animal.nom                   -- idem, la précision n'est pas obligatoire. C'est cependant plus clair puisque les espèces ont un nom aussi

FROM Espece   

INNER JOIN Animal

     ON Espece.id = Animal.espece_id

WHERE Animal.nom LIKE 'Ch%';




-- sélectionnez avec \texttt{JOIN} le nom des animaux  née avant  2008-03-15 12:02:00, ainsi que l'id, le nom courant et la description de leur espèce. 
SELECT Espece.id,                   -- obligatoire si iner join
	   Espece.nom_courant,
       Espece.description,          
       Animal.nom,
       Animal.date_naissance                  

FROM Espece   

INNER JOIN Animal

     ON Espece.id = Animal.espece_id

WHERE Animal.date_naissance < '2008-03-15 12:02:00';

-- Autre syntaxe (sans iner)

SELECT Espece.nom_courant,
       Espece.description,          
       Animal.nom,
       Animal.date_naissance                   

FROM Espece   

JOIN Animal

     ON Espece.id = Animal.espece_id

WHERE Animal.date_naissance < '2008-03-15 12:02:00';


-- Séléction des nom d'animaux dont les especes ont un t dans la description (avec inner)
SELECT Espece.id, 
	   Espece.nom_courant,
       Espece.description,          
       Animal.nom                   

FROM Espece   

INNER JOIN Animal

     ON Espece.id = Animal.espece_id

WHERE Espece.description LIKE '%t%';



-- Séléction des nom d'animaux dont les especes ont un t dans la description (sans inner)
SELECT Espece.nom_courant,
       Espece.description,          
       Animal.nom                   

FROM Espece   

JOIN Animal

     ON Espece.id = Animal.espece_id

WHERE Espece.description LIKE '%t%';

-- En utilisant un alias pour chaque table, sélectionnez avec \texttt{JOIN} le nom des animaux née avant  2008-03-15 12:02:00, ainsi que l'id, le nom courant et la description de leur espèce. 

SELECT e.id,
	   e.nom_courant,
       e.description,          
       a.nom,
       a.date_naissance                 

FROM Espece AS e

JOIN Animal AS a

     ON e.id = a.espece_id

WHERE a.date_naissance < '2008-03-15 12:02:00';



-- En utilisant un alias pour la table Animal, sélectionnez des nom d'animaux dont les espèces ont un t dans la description. 

SELECT Espece.nom_courant,
       Espece.description,          
       a.nom                   

FROM Espece   

JOIN Animal AS a

     ON Espece.id = a.espece_id

WHERE Espece.description LIKE '%t%';


--On peut voir ici que les chats Choupi et Roucky, pour lesquels je n'ai pas d'information sur la race (race_id est NULL), ne sont pas repris dans les résultats.
-- De même, aucun des chats n'est de la race "Sphynx", celle-ci n'est donc pas reprise. Si je veux les inclure, je dois utiliser une jointure externe.


-- Jointure externe
--jointure par la gauche : chat sans race affichés
SELECT Animal.nom AS nom_animal, Race.nom AS race

FROM Animal                         -- Table de gauche

LEFT JOIN Race                      -- Table de droite

    ON Animal.race_id = Race.id

WHERE Animal.espece_id = 2 

ORDER BY Race.nom, Animal.nom;

--jointure par la droite : chat sans race affichés
SELECT Animal.nom AS nom_animal, Race.nom AS race

FROM Race                        -- Table de gauche

RIGHT JOIN Animal                     -- Table de droite

    ON Race.id = Animal.race_id

WHERE Animal.espece_id = 2 

ORDER BY Race.nom, Animal.nom;




    --jointure par la gauche : chat sans race affichés + nom commencant par C
SELECT Animal.nom AS nom_animal, Race.nom AS race

FROM Animal                         -- Table de gauche

LEFT JOIN Race                      -- Table de droite

    ON Animal.race_id = Race.id

WHERE Animal.espece_id = 2 
    AND Animal.nom LIKE 'C%'

ORDER BY Race.nom, Animal.nom;

 --jointure par la droite: chat sans race affichés + nom commencant par C

 SELECT Animal.nom AS nom_animal, Race.nom AS race

FROM Race                        -- Table de gauche

RIGHT JOIN Animal                     -- Table de droite

    ON Race.id = Animal.race_id

WHERE Animal.espece_id = 2 
    AND Animal.nom LIKE 'C%'

ORDER BY Race.nom, Animal.nom;


  --jointure par la gauche : race de chat sans chat présent 

SELECT Animal.nom AS nom_animal, Race.nom AS race

FROM Race                                               -- Table de gauche

LEFT JOIN Animal                                        -- Table de droite

    ON Animal.race_id = Race.id

WHERE Race.espece_id = 2

ORDER BY Race.nom, Animal.nom;



  --jointure par la droite : race de chat sans chat présent 
SELECT Animal.nom AS nom_animal, Race.nom AS race

FROM Animal                                                -- Table de gauche

RIGHT JOIN Race                                            -- Table de droite

    ON Animal.race_id = Race.id

WHERE Race.espece_id = 2

ORDER BY Race.nom, Animal.nom;

--- Jointure avec plusieurs tables

SELECT Race.nom 
FROM Espece
INNER JOIN Race
ON Espece.id = Race.id
WHERE Race.nom LIKE '%berger%'
AND Espece.nom_courant = 'chien';


SELECT Animal.nom, Animal.date_naissance, Race.nom, Race.description
FROM Animal 
LEFT JOIN Race
ON Animal.race_id = Race.id
WHERE (Race.description NOT LIKE '%pelage%'
AND Race.description NOT LIKE '%poil%'
AND Race.description NOT LIKE '%robe%')
OR Race.description IS NULL;


SELECT Espece.nom_courant , Animal.sexe , Race.nom AS race_nom
FROM Animal
INNER JOIN Espece 
ON Animal.espece_id = Espece.id 
LEFT JOIN Race 
ON Animal.race_id = Race.id
WHERE Espece.nom_courant IN ('Perroquet amazone', 'Chat');

SELECT Animal.sexe, Animal.nom, Race.nom AS race_nom , Animal.date_naissance
FROM Animal
INNER JOIN Race
ON Animal.race_id = Race.id
INNER JOIN Espece
ON Animal.espece_id = Espece.id
WHERE Espece.nom_courant = 'chien'
AND Animal.date_naissance < '2017-07-01'
AND Animal.sexe = 'F';


SELECT Animal.nom as nom_fils , Pere.nom as pere_nom , Mere.nom as mere_nom, Espece.nom_courant
FROM Animal 
INNER JOIN Animal AS Pere 
ON Animal.pere_id = Pere.id
INNER JOIN Animal AS Mere
ON Animal.mere_id = Mere.id
INNER JOIN Espece
WHERE Espece.nom_courant = 'chat';



SELECT Animal.nom , Pere.nom as pere_nom , Mere.nom as mere_nom
FROM Animal
RIGHT JOIN Animal AS Pere 
ON Animal.pere_id = Pere.id
RIGHT JOIN Animal AS Mere
ON Animal.mere_id = Mere.id
WHERE Pere.nom = 'Bilba' OR Mere.nom = 'Bilba';


SELECT Espece.nom_courant AS espece, Animal.nom AS nom_animal, Race.nom AS race_animal,

    Pere.nom AS papa, Race_pere.nom AS race_papa,

    Mere.nom AS maman, Race_mere.nom AS race_maman

FROM Animal

INNER JOIN Espece

    ON Animal.espece_id = Espece.id

INNER JOIN Race

    ON Animal.race_id = Race.id

INNER JOIN Animal AS Pere

    ON Animal.pere_id = Pere.id

INNER JOIN Race AS Race_pere

    ON Pere.race_id = Race_pere.id

INNER JOIN Animal AS Mere

    ON Animal.mere_id = Mere.id

INNER JOIN Race AS Race_mere

    ON Mere.race_id = Race_mere.id;

