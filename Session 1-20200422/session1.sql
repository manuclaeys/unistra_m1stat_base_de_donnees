#Session 1

#https://osr-base.unistra.fr/
#Se connecter et créer une bdd 
#https://documentation.unistra.fr/Catalogue/Services_pedagogiques/Salles/Ressources/MAI_VIE/co/guideMAI_VIE.html





#####TD0
#Connexion au Serveur d'applications des TPs Base de Données au domicile
#Procédure à suivre
#Se connecter au poste de travail.
#Ouvrir le tableau de bord et chercher le terminal
#Taper  dans la zone de recherche.
#terminal
#Lancer le Terminal
#Taper ssh -X claeys@osr-etudiant.unistra.fr
#Exemple : s.kreto@osr-etudiant.unistra.fr
#Mot de passe : taper son mot de passe
#Appuyer sur 
#Entrée
#Si un message apparaît : cliquer sur OUI
#Appuyer sur Entrée
#MYSQL claeys claeys


###TD 1
CREATE DATABASE elevage CHARACTER SET 'utf8';
#Impossible sur la bdd d'osr ==> Base elvage sera nom_etudiant


### CREATION DE LA TABLE 
CREATE  TABLE  Animal (
id  SMALLINT  UNSIGNED  NOT  NULL  AUTO_INCREMENT ,
espece  VARCHAR (40)  NOT NULL ,
sexe  CHAR (1),
date_naissance  DATETIME  NOT NULL ,
nom  VARCHAR (30),
commentaires  TEXT ,
PRIMARY  KEY (id)
)
ENGINE=INNODB;


#SMALL INT Deux octets
#VARCHAR(n) Données de type chaîne non Unicode (standard de charactères accepté) de longueur variable (max 8000).
#CHAR Données de type chaîne non Unicode de longueur fixe (max 8000)
#DATETIME AAAA-MM-JJ hh:mm:ss[.nnn]
#id :  SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT  : toujours positif, jamais nulle , 
#s'incrémente automatiquement (pas besoin d'être renseignée par l'utilisateur)



#SUPPRESSION DE LA TABLE 
DROP TABLE Animal;


#EXO 2
#SHOW TABLE 
SHOW TABLES ;
#DESCRIBE TABLE
DESCRIBE Animal;

#SHOW TABLES liste les tables sans les détails et DESCRIBE table décrit les attributs 

##CREATION TUTO
CREATE  TABLE  Tuto (
id  INT  UNSIGNED  NOT  NULL,
nom  CHAR (10),
date_insertion  DATETIME
)
ENGINE=INNODB;



#Ajout commentaire

ALTER  TABLE  Tuto
ADD  COLUMN  commentaire  TEXT;

#VERIFICATION
DESCRIBE Tuto;


#Suppression colonne date_insertion
ALTER  TABLE  Tuto
DROP  date_insertion;

#VERIFICATION
DESCRIBE Tuto;

#Suppression table tuto
DROP TABLE Tuto;



##TD 2 

#Créez la table Tuto2 


CREATE TABLE Tuto2 (
  
  id INT NOT NULL,
  
  prénom VARCHAR(10) NOT NULL
  
);


##Renomez Tuto2 en Test_Tuto
RENAME TABLE
    Tuto2 TO Test_tuto ;


ALTER TABLE Test_tuto 

CHANGE prénom nom VARCHAR(30) NOT NULL DEFAULT 'Blabla';

#Vérification
DESCRIBE Test_tuto;


ALTER TABLE Test_tuto

MODIFY id BIGINT NOT NULL;



#CHANGE si  Si vous avez déjà créé votre base de données MySQL, 
#et que vous décidez après coup qu'une de vos colonnes est mal nommée, 
#vous n'avez pas besoin de la supprimer et de faire un remplacement, 
#vous pouvez simplement la renommer en utilisant la colonne 

#MODIFY Cette commande fait tout ce que CHANGE COLUMN peut faire, mais sans renommer la colonne. 

###TD 3

#Ajout de Rox
INSERT  INTO  Animal
VALUES (1, 'chien ', 'M',  '2010-04-05  13:43:00' , 'Rox', 'Mordille
beaucoup');

#Ajout de Roucky
INSERT  INTO  Animal
VALUES (2, 'chat', NULL ,  '2010-03-24  02:23:00' , 'Roucky', NULL);

#Si vous tapez
INSERT INTO Animal   VALUES ('chat', 'F', '2010-09-13 15:02:00', 'Schtroumpfette', NULL);
#ca ne marchera pas : il faut taper
INSERT INTO Animal 
VALUES (NULL , 'chat', 'F', '2010-09-13 15:02:00', 'Schtroumpfette', NULL);


#On vérifie que Stroumpfette est bien présente dans la base
  SELECT * FROM Animal;

# est ce qu'il est nécessaire de mettre des guillement dans 
#- l'id
INSERT INTO Animal 
VALUES ('4' , 'chat', 'F', '2010-09-13 15:02:00', 'Schtroumpfette', NULL);
#Error ==> NON

INSERT INTO Animal 
VALUES (4, chat, 'F', '2010-09-13 15:02:00', 'Schtroumpfette', NULL);
#Error ==> OUI


#Deux choses importantes à retenir ici.
#id est un nombre, on ne met donc pas de guillemets autour.
#Par contre, l'espèce, le nom, la date de naissance et le sexe sont donnés 
#sous forme de chaînes de caractères.
#Les guillemets sont donc indispensables. Quant à NULL, il s'agit d'un marqueur SQL qui, 
#je rappelle, signifie "pas de valeur". Pas de guillemets donc.

#Ajout des colonnes dans le désordre
INSERT INTO Animal 
VALUES ('chat',5, 'F', '2010-09-13 15:02:00', 'Schtroumpfette', 'Blabla');

#MySQL à enlevé "chat" et l'a ajouté via auto incrémentation
#Les valeurs des colonnes sont données dans le bon ordre (donc dans l'ordre donné lors de la création de la table).
#C'est indispensable évidemment. Si vous échangez le nom et l'espèce par exemple, comment MySQL pourrait-il le savoir ?

#Si vous voulez supprimez ces colonnes, l'id est à vérifier selon votre table
DELETE FROM Animal
WHERE id=4;

#Vérification 
SELEC * FROM Animal;


#1.3)

INSERT INTO Animal (espece, sexe, date_naissance) 
VALUES ('tortue', 'F', '2009-08-03 05:12:00');



INSERT INTO Animal (nom,espece, date_naissance) 
VALUES ('Choupi', 'chat', '2010-10-03 16:44:00');


INSERT INTO Animal (espece, date_naissance, commentaires, nom, sexe) 
VALUES ('tortue', '2009-06-13 08:17:00', 'Carapace bizarre', 'Bobosse', 'F');


#2)

INSERT INTO Animal (espece, sexe, date_naissance, nom) 

VALUES ('chien', 'M', '2008-12-06 05:18:00', 'Carolin'),

        ('chat', 'M', '2008-09-11 15:38:00', 'Bagherra'),

        ('tortue', NULL, '2010-08-23 05:18:00', NULL);


#Ajout de Caroline

INSERT INTO Animal (espece, sexe, date_naissance, nom) 

VALUES ('chienne', 'F', '2008-12-06 05:18:00', 'Carolinne'),

        ('chat', 'M', '2008-09-11 15:38:00', NULL),

        ('tortue', NULL, '2010-08-23 05:18:00', NULL);

#Vérification
SELECT * FROM Animal;

#Commencez par sortir de mysql
exit;

#Téléchargez le fichier
#commande depuis le terminal
scp [source file] [username]@[destination server]:.

#Depuis votre machine perso, envoyez les fichiers

scp /home/manue/Documents/manue/Cours/cour_master_Bio_BDD/td/TD_1.csv claeys@osr-etudiant.unistra.fr:.
scp /home/manue/Documents/manue/Cours/cour_master_Bio_BDD/td/TD_animal.sql claeys@osr-etudiant.unistra.fr:.

#véfifiez que vous avez bien votre fichier
ls

#Retour à MySQL
MYSQL claeys claeys

#Chargement du SQL
SOURCE TD_animal.sql;

#chargement du csv
LOAD  DATA  LOCAL  INFILE  'TD_1.csv'
INTO  TABLE  Animal
FIELDS  TERMINATED  BY  ';' ENCLOSED  BY  '"'
LINES  TERMINATED  BY  '\n' 
(espece , sexe , date_naissance , nom , commentaires);



#Si une colonne en trop
DELETE FROM Animal
WHERE id=65;

#Suppression de l'animal Zoulou
DELETE FROM Animal
WHERE nom='Zoulou';


