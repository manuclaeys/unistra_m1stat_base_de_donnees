#######TD4 
DESCRIBE Animal;


####Select des colonnes espece, nom et sexe
SELECT espece, nom, sexe
FROM Animal;


#Selection des chiens 
SELECT *
FROM Animal
WHERE espece='chien';


###Opérateur différent de (plusieurs solutions)
# <>
# !=
#certaines sgbd n'acceptent que les '<>'

#Animaux nées avant le 2008-01-01
SELECT *
FROM Animal 
WHERE date_naissance < '2008-01-01';

#Ts les animaux sauf les chats
SELECT *
FROM Animal 
WHERE espece <> 'chat';


#Condition multiples
SELECT *
FROM Animal
WHERE espece = 'chat'
AND sexe = 'M'

#Opérateur or : OR ou ||

#séléction tortues ou perroquets 
SELECT *
FROM Animal
WHERE espece = 'tortue'
OR  espece = 'perroquet';


#séléction de tous les animaux sauf les chiennes
SELECT *
FROM Animal
WHERE sexe = 'F'
AND  espece <> 'chien';



#XOR = ou exclusif https://fr.wikipedia.org/wiki/Fonction_OU_exclusif

#Séléction des animaux qui sont mâles ou perroquets mais pas les deux
SELECT *
FROM Animal
WHERE sexe = 'M'
XOR  espece = 'perroquet';

##
- date < 2009
OU
- chat
	- chat male
	- chat femelles + née < juin 2009

#3.1.a)
#en sql
SELECT * FROM Animal
WHERE 
date_naissance <   '2009-01-01'
OR
( 
		( espece='chat' AND sexe='M')
	AND
		( (espece='chat' AND sexe='F') AND date_naissance <  '2009-06-01' )
);


#

#3.1.b) = Ne marche pas avec NULL
SELECT * FROM Animal
WHERE  commentaires = NULL;

# <> Ne marche pas avec NULL
SELECT * FROM Animal
WHERE  commentaires  <> NULL;

# <=> Marche avec NULL
SELECT * FROM Animal
WHERE  commentaire  <=> NOT NULL;


SELECT * FROM Animal
WHERE  commentaires  IS NULL;


SELECT * FROM Animal
WHERE  commentaires  <> IS NOT NULL;

#NULL est un type particulier qui ne se compare pas avec les opérateurs classiques

#3.2
SELECT * FROM Animal
ORDER BY id
LIMIT 6;


SELECT * FROM Animal
WHERE espece = 'chien'
ORDER BY date_naissance
LIMIT 10;


SELECT * FROM Animal
ORDER BY espece, date_naissance
LIMIT 10;

#lister les especes reviens à utiliser DISTINCT
SELECT DISTINCT espece FROM Animal;

SELECT DISTINCT commentaires FROM Animal;


###Recherche pour une chaine de charactere
SELECT * 
FROM Animal
WHERE nom LIKE 'b%';

SELECT * 
FROM Animal
WHERE nom LIKE '%o';


SELECT * 
FROM Animal
WHERE nom LIKE '%er%';

SELECT * 
FROM Animal
WHERE nom LIKE 'f%er%';

SELECT * 
FROM Animal
WHERE commentaires LIKE '%\%%';

SELECT * 
FROM Animal
WHERE nom NOT LIKE '%o%';




##Opérateur Between

SELECT * FROM Animal
WHERE date_naissance 
BETWEEN '2008-01-01' AND '2009-03-23';

SELECT * FROM Animal
WHERE 
date_naissance >  '2008-01-01' AND date_naissance < '2009-03-23';


SELECT * FROM Animal
WHERE nom 
IN ('Moka', 'Bilba','Tortilla', 'Balou', 'Dana', 'Redbull', 'Gingko');


SELECT * FROM Animal
WHERE 
nom = 'Moka' 
OR
nom = 'Bilba'
OR 
nom ='Tortilla'
OR
nom = 'Balou'
OR
nom = 'Dana'
OR
nom = 'Redbull'
OR 
nom = 'Gingko';



#######TD5

#Rappel des tables existantes
SHOW TABLES; 

#Décrire une table
DESCRIBE Test_tuto;


##A
CREATE TABLE toto(
id TINYINT,
INDEX (id)
 );

##B
SHOW INDEX FROM toto;


###ON CONSTATE QUE LE NOM DE L INDEXE EST LE NOM DE LA COLONNE

##C
CREATE TABLE toto2(
id SMALLINT,
INDEX monIndex (id)
 );

###D
SHOW INDEX FROM toto2;


DROP TABLE toto;
DROP TABLE toto2;


###On vérifie que la colonne nom existe
DESCRIBE Test_tuto;


#Ajoutez un index ind_nom sur la colonne nom dans votre table Test_tuto .
ALTER TABLE Test_tuto
	ADD INDEX ind_nom (nom);

#Proposez la commande similaire avec l’opérande CREATE INDEX
#Attention il faut changer le nom de l'indexe
CREATE INDEX ind_nom2
ON Test_tuto (nom);

#on peut mettre deux indexes sur une colonne mais pas des indexes avec le même nom

#Procédure Analyse sur animal
#On commence par voir les colonnes possibles
DESCRIBE Animal;

##Procédire analyse
SELECT id FROM Animal PROCEDURE ANALYSE (10 ,256);
##Best type Tiny int

SELECT espece FROM Animal PROCEDURE ANALYSE (10 ,256);
##Best type Enum

SELECT sexe FROM Animal PROCEDURE ANALYSE (10 ,256);
##Best type Enum

SELECT nom FROM Animal PROCEDURE ANALYSE (10 ,256);
#VARCHAR(14)

SELECT date_naissance FROM Animal PROCEDURE ANALYSE (10 ,256);
#CHAR(19)

SELECT commentaires FROM Animal PROCEDURE ANALYSE (10 ,256);
#ENNUM


###ANIMAL 2

CREATE TABLE Animal2 (
  
  id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  
  espece VARCHAR(40) NOT NULL,
  
  sexe CHAR(1),
  
  date_naissance DATETIME NOT NULL,
  
  nom VARCHAR(30),
  
  commentaires TEXT,
  
  PRIMARY KEY (id)
  
)

ENGINE=INNODB;



###Création de la table toto

CREATE TABLE toto (
  
  id INT UNSIGNED,
  
  name VARCHAR(20)
  
)

ENGINE=INNODB;

ALTER TABLE toto
	ADD UNIQUE ind_2 (id);

INSERT INTO toto (id, name) 
VALUES (NULL, 'manu');


##Type null accepté si c'est après la création de la table
#Pour faire changer cela, on rajoute CONSTRAINT


ALTER TABLE Animal
	ADD UNIQUE ind_1 (espece,nom);





CREATE TABLE Livre (

    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,

    auteur VARCHAR(50),

    titre VARCHAR(200)

) ENGINE = MyISAM;


INSERT INTO Livre (auteur, titre)

VALUES ('Daniel Pennac', 'Au bonheur des ogres'),

('Daniel Pennac', 'La Fée Carabine'),

('Daniel Pennac', 'Comme un roman'),

('Daniel Pennac', 'La Petite marchande de prose'),

('Jacqueline Harpman', 'Le Bonheur est dans le crime'),

('Jacqueline Harpman', 'La Dormition des amants'),

('Jacqueline Harpman', 'La Plage d''Ostende'),

('Jacqueline Harpman', 'Histoire de Jenny'),

('Terry Pratchett', 'Les Petits Dieux'),

('Terry Pratchett', 'Le Cinquième éléphant'),

('Terry Pratchett', 'La Vérité'),

('Terry Pratchett', 'Le Dernier héros'),

('Terry Goodkind', 'Le Temple des vents'),

('Jules Verne', 'De la Terre à la Lune'),

('Jules Verne', 'Voyage au centre de la Terre'),

('Henri-Pierre Roché', 'Jules et Jim');


CREATE FULLTEXT INDEX ind_full_titre

ON Livre (titre);


CREATE FULLTEXT INDEX ind_full_aut

ON Livre (auteur);


CREATE FULLTEXT INDEX ind_full_titre_aut

ON Livre (titre, auteur);




### Recherche de Thierry
SELECT *
FROM Livre
WHERE MATCH(auteur)
AGAINST ('Terry');


SELECT *
FROM Livre
WHERE MATCH(titre)
AGAINST ('Petite');



SELECT *
FROM Livre
WHERE MATCH(titre)
AGAINST ('Petit');



SELECT *
FROM Livre
WHERE MATCH(auteur)
AGAINST ('Henri');

SELECT *
FROM Livre
WHERE MATCH(auteur,titre)
AGAINST ('Jules');

SELECT *
FROM Livre
WHERE MATCH(titre,auteur)
AGAINST ('Jules Verne');

#MATCH recherche selon l'ordre des colonnes, MATCH AGAINST selon la pertinance 

#Pertinance de la recherche 
SELECT *, MATCH(titre,auteur) AGAINST ('Jules Verne Lune') FROM Livre;

#La requête suivente suit une pertinence croissante
SELECT *
FROM Livre
WHERE MATCH(titre,auteur)
AGAINST ('Jules Verne');

#3.5
SELECT * 
FROM Livre 
WHERE MATCH(titre)
AGAINST ('+bonheur -orgre' IN BOOLEAN MODE);


SELECT * 
FROM Livre 
WHERE MATCH(titre)
AGAINST ('Terre à la lune' IN BOOLEAN MODE);

SELECT * 
FROM Livre 
WHERE MATCH(titre)
AGAINST ('Terre la lune' IN BOOLEAN MODE);


SELECT * 
FROM Livre 
WHERE MATCH(titre)
AGAINST ('petite*' IN BOOLEAN MODE);

SELECT * 
FROM Livre 
WHERE MATCH(titre, auteur)
AGAINST ('d*' IN BOOLEAN MODE);


SELECT * 
FROM Livre 
WHERE MATCH(titre)
AGAINST ('+petit* -prose' IN BOOLEAN MODE);


SELECT * 
FROM Livre 
WHERE MATCH(titre, auteur)
AGAINST ('Daniel');



SELECT * 
FROM Livre 
WHERE MATCH(titre, auteur)
AGAINST ('Daniel' WITH QUERY EXPANSION);








