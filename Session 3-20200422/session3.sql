-- Si Animal2 existe déjà il faut supprimer la table
DROP table Animal2;

-- 1.c
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

--1.D
-- pas d'auto incrémentation
CREATE TABLE Animal3 (
  
  id SMALLINT UNSIGNED NOT NULL ,
  
  espece VARCHAR(40) NOT NULL,
  
  sexe CHAR(1),
  
  date_naissance DATETIME NOT NULL,
  
  nom VARCHAR(30),
  
  commentaires TEXT
  
)

ENGINE=INNODB;

--1.E
ALTER TABLE Animal3
ADD CONSTRAINT pk_id PRIMARY KEY (id);

--1.F 
ALTER TABLE Animal3
DROP PRIMARY KEY;

-- 1.G
DROP table Animal2;
DROP table Animal3;


-----------------
-----------------


CREATE TABLE Client (
  
  id_client SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  
  nom VARCHAR(40) NOT NULL,
  
  prenom VARCHAR(40) NOT NULL,
  
  email VARCHAR(40) NOT NULL,
  
  commentaires TEXT,

  PRIMARY KEY (id_client)
  
)

ENGINE=INNODB;

CREATE TABLE Commande (
  
  id_commande SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  
  id_client SMALLINT UNSIGNED NOT NULL,
  
  produit VARCHAR(40) NOT NULL,

  quantite VARCHAR(40) NOT NULL,

  PRIMARY KEY (id_commande),

  CONSTRAINT fk_id_client FOREIGN KEY (id_client) REFERENCES Client(id_client)
  
)

ENGINE=INNODB;


--- ne fonctionne pas car pas le même type
ALTER TABLE Client
ADD CONSTRAINT fk_commentaires FOREIGN KEY (commentaires) REFERENCES Commande(id_commande);

-- Insertion de produit rappel syntaxe
INSERT INTO table_name (column1, column2, column3, ...)
VALUES (value1, value2, value3, ...), 
(value1, value2, value3, ...); 

-- Insertion des client avant la commande
INSERT INTO Client (nom, prenom, email) VALUES 
('Jean', 'Dupont', 'emailJean'),
('Marie', 'Malherbe', 'emailmarie'),
('Nicolas', 'Jaques', 'emailjaques'),
('Hadrien', 'Piroux', 'emailpirouxs')
;


SELECT * FROM Client;

INSERT INTO Commande (id_client, produit, quantite) VALUES 
(3, 'tube de colle', 3),
(2, 'papier', 6),
(2, 'ciseaux', 2)
;


SELECT * FROM Commande;


--- 

CREATE TABLE Espece (

    id SMALLINT UNSIGNED AUTO_INCREMENT,

    nom_courant VARCHAR(40) NOT NULL,

    nom_latin VARCHAR(40) NOT NULL,

    description TEXT,

    PRIMARY KEY(id)

)

ENGINE=InnoDB;

-- Création sur l'id directement dans la création de la bdd

-- Contrainte unique sur nom latin

ALTER TABLE Espece
ADD UNIQUE (nom_latin); 


-- Insertion de données
INSERT INTO Espece (nom_courant, nom_latin, description) VALUES

    ('Chien', 'Canis canis', 'Bestiole à quatre pattes qui aime les caresses et tire souvent la langue'),

    ('Chat', 'Felis silvestris', 'Bestiole à quatre pattes qui saute très haut et grimpe aux arbres'),

    ('Tortue d''Hermann', 'Testudo hermanni', 'Bestiole avec une carapace très dure'),

    ('Perroquet amazone', 'Alipiopsitta xanthops', 'Joli oiseau parleur vert et jaune');


 -- Ajout d'une colonne espece_id

ALTER TABLE Animal ADD COLUMN espece_id SMALLINT UNSIGNED; -- même type que la colonne id de Espece


-- Remplissage de espece_id

UPDATE Animal SET espece_id = 1 WHERE espece = 'chien';

UPDATE Animal SET espece_id = 2 WHERE espece = 'chat';

UPDATE Animal SET espece_id = 3 WHERE espece = 'tortue';

UPDATE Animal SET espece_id = 4 WHERE espece = 'perroquet';


-- vérification

SELECT * FROM Animal;


-- Suppression de la colonne espece

ALTER TABLE Animal DROP COLUMN espece;


-- Ajout de la clé étrangère

ALTER TABLE Animal

ADD CONSTRAINT fk_espece_id FOREIGN KEY (espece_id) REFERENCES Espece(id);

-- vérification

INSERT INTO Animal (nom, espece_id, date_naissance)

VALUES ('Caouette', 5, '2009-02-15 12:45:00');


SHOW CREATE TABLE Espece;


-- Si erreur 
ALTER TABLE Animal
DROP FOREIGN KEY fk_espece_id;
DELETE FROM Animal
WHERE id in (61,62);


ALTER TABLE Animal MODIFY espece_id SMALLINT UNSIGNED NOT NULL;


CREATE UNIQUE INDEX ind_uni_nom_espece_id ON Animal (nom, espece_id);


-- --------------------------

-- CREATION DE  LA TABLE Race

-- --------------------------

CREATE TABLE Race (

    id SMALLINT UNSIGNED AUTO_INCREMENT,

    nom VARCHAR(40) NOT NULL,

    espece_id SMALLINT UNSIGNED NOT NULL,     -- pas de nom latin, mais une référence vers l'espèce

    description TEXT,

    PRIMARY KEY(id),

    CONSTRAINT fk_race_espece_id FOREIGN KEY (espece_id) REFERENCES Espece(id)  -- pour assurer l'intégrité de la référence

)

ENGINE = InnoDB;


-- -----------------------

-- REMPLISSAGE DE LA TABLE

-- -----------------------

INSERT INTO Race (nom, espece_id, description)

VALUES ('Berger allemand', 1, 'Chien sportif et élégant au pelage dense, noir-marron-fauve, noir ou gris.'),

('Berger blanc suisse', 1, 'Petit chien au corps compact, avec des pattes courtes mais bien proportionnées et au pelage tricolore ou bicolore.'),

('Boxer', 1, 'Chien de taille moyenne, au poil ras de couleur fauve ou bringé avec quelques marques blanches.'),

('Bleu russe', 2, 'Chat aux yeux verts et à la robe épaisse et argentée.'),

('Maine coon', 2, 'Chat de grande taille, à poils mi-longs.'),

('Singapura', 2, 'Chat de petite taille aux grands yeux en amandes.'),

('Sphynx', 2, 'Chat sans poils.');


-- ---------------------------------------------

-- AJOUT DE LA COLONNE race_id A LA TABLE Animal

-- ---------------------------------------------

ALTER TABLE Animal ADD COLUMN race_id SMALLINT UNSIGNED;


ALTER TABLE Animal

ADD CONSTRAINT fk_race_id FOREIGN KEY (race_id) REFERENCES Race(id);


-- -------------------------

-- REMPLISSAGE DE LA COLONNE

-- -------------------------

UPDATE Animal SET race_id = 1 WHERE id IN (1, 13, 20, 18, 22, 25, 26, 28);

UPDATE Animal SET race_id = 2 WHERE id IN (12, 14, 19, 7);

UPDATE Animal SET race_id = 3 WHERE id IN (17, 21, 27);

UPDATE Animal SET race_id = 4 WHERE id IN (33, 35, 37, 41, 44, 31, 3);

UPDATE Animal SET race_id = 5 WHERE id IN (43, 40, 30, 32, 42, 34, 39, 8);

UPDATE Animal SET race_id = 6 WHERE id IN (29, 36, 38);


-- -------------------------------------------------------

-- AJOUT DES COLONNES mere_id ET pere_id A LA TABLE Animal

-- -------------------------------------------------------

ALTER TABLE Animal ADD COLUMN mere_id SMALLINT UNSIGNED;


ALTER TABLE Animal

ADD CONSTRAINT fk_mere_id FOREIGN KEY (mere_id) REFERENCES Animal(id);


ALTER TABLE Animal ADD COLUMN pere_id SMALLINT UNSIGNED;


ALTER TABLE Animal

ADD CONSTRAINT fk_pere_id FOREIGN KEY (pere_id) REFERENCES Animal(id);


-- -------------------------------------------

-- REMPLISSAGE DES COLONNES mere_id ET pere_id

-- -------------------------------------------

UPDATE Animal SET mere_id = 18, pere_id = 22 WHERE id = 1;

UPDATE Animal SET mere_id = 7, pere_id = 21 WHERE id = 10;

UPDATE Animal SET mere_id = 41, pere_id = 31 WHERE id = 3;

UPDATE Animal SET mere_id = 40, pere_id = 30 WHERE id = 2;


