/*partie 1*/
--calculer à la main
--1.

--a,b,c
--x,m,2
--x,n,1
--y,m,4
--z,p,1
-------------
--2.

--a
--x
--x
--y
--z
-------------
--3.

--a
--x
--z
-------------
--4.

--a
--x
--x
--z
-------------
--5.

--a
--x
--z
-------------
--6.

--a
--x
--y
--x
--z
-------------
--7.

--a  e
--x  8  
--x  4
--x  1
--x  8  
--x  4
--x  1
--y  8
--y  4
--y  1
--z  8
--z  4
--z  1
-------------
--8.

--a  e
--x  1
--z  1

-------------------------------
/*partie 2*/

--exercice1 
SELECT editeur.NomEditeur, editeur.Ville, editeur.Region
FROM editeur

--exercice2
SELECT employe.NomEmploye, employe.PnEmploye, employe.DateEmbauche, employe.PositionEmploye
FROM employe
INNER JOIN editeur ON editeur.IdEditeur = employe.IdEditeur
WHERE employe.DateEmbauche BETWEEN '1990-01-01' AND '1990-12-31'
AND employe.NomEmploye LIKE 'L%'
AND employe.PositionEmploye BETWEEN 10 AND 100

--exercice3
SELECT editeur.IdEditeur, employe.NomEmploye, employe.DateEmbauche
FROM employe
INNER JOIN editeur ON editeur.IdEditeur = employe.IdEditeur
ORDER BY editeur.IdEditeur , employe.NomEmploye

--exercice4
SELECT auteur.NomAuteur, auteur.Pays, auteur.Adresse
FROM auteur
WHERE auteur.Pays IN ('FR', 'BE', 'CH')
ORDER BY auteur.Pays

--exercice5
SELECT employe.PositionEmploye, COUNT(0) AS NbEmployes, MIN(employe.DateEmbauche) AS Ancien, MAX(employe.DateEmbauche) AS Recent
FROM employe
GROUP BY employe.PositionEmploye

--exercice6
SELECT droitprevu.IdTitre, MAX(droitprevu.Droit) AS DroitMax
FROM droitprevu
GROUP BY droitprevu.IdTitre

--exercice7
SELECT editeur.Pays, COUNT(*) AS NbEditeur 
FROM editeur
GROUP BY editeur.Pays 
HAVING editeur.Pays LIKE '%s%' 
OR  editeur.Pays LIKE '%r%'

--exercice9
SELECT auteur.NomAuteur, titre.Titre, titre.Prix
FROM auteur
INNER JOIN titreauteur ON titreauteur.IdAuteur = auteur.IdAuteur
INNER JOIN titre ON titre.IdTitre = titreauteur.IdTitre
WHERE auteur.Ville = 'Paris'

--exercice10
SELECT editeur.NomEditeur, titre.Titre, magasin.NomMag, vente.Qt
FROM editeur
INNER JOIN titre ON titre.IdEditeur = editeur.IdEditeur
INNER JOIN vente ON vente.IdTitre = titre.IdTitre
INNER JOIN magasin ON magasin.IdMag = vente.IdMag
ORDER BY editeur.NomEditeur, titre.Titre

--exercice11
SELECT auteur.NomAuteur,  SUM(vente.Qt) AS NbLivre
FROM auteur
INNER JOIN titreauteur ON titreauteur.IdAuteur = auteur.IdAuteur
INNER JOIN titre ON titre.IdTitre = titreauteur.IdTitre
INNER JOIN vente ON vente.IdTitre = titre.IdTitre
WHERE vente.Qt >= 20
GROUP BY auteur.NomAuteur

--exercice12
SELECT auteur.NomAuteur, auteur.PnAuteur,titreauteur.DroitPourCent
FROM auteur
INNER JOIN titreauteur ON titreauteur.IdAuteur = auteur.IdAuteur
WHERE EXISTS (SELECT titreauteur.IdAuteur
              FROM titreauteur 
              WHERE titreauteur.IdAuteur = auteur.IdAuteur)
AND 100 = ALL (SELECT titreauteur.DroitPourCent
               FROM titreauteur 
               WHERE titreauteur.IdAuteur= auteur.IdAuteur)
ORDER BY auteur.NomAuteur, auteur.PnAuteur

--exercice13
SELECT titre.Titre, titre.Prix
FROM titre
WHERE titre.Prix = (SELECT MAX(titre.Prix) 
                    FROM titre)

--exercice14
SELECT titre.Titre, (SELECT SUM(vente.Qt) 
                    FROM vente
                    WHERE titre.IdTitre = vente.IdTitre
                    ) AS QtVente 
FROM titre 
ORDER BY titre.Titre

--exercice15
SELECT titre.Titre, magasin.NomMag
FROM titre
INNER JOIN vente ON vente.IdTitre = titre.IdTitre
INNER JOIN magasin ON magasin.IdMag = vente.IdMag
WHERE vente.Qt IN (SELECT MAX(vente.Qt) 
                   FROM vente)

--exercice15_Bis
SELECT editeur.NomEditeur, editeur.IdEditeur, titre.Type
FROM editeur
INNER JOIN titre ON titre.IdEditeur = editeur.IdEditeur
WHERE titre.Type = 'gestion'
UNION
SELECT editeur.NomEditeur, editeur.IdEditeur, titre.Type
FROM editeur
INNER JOIN titre ON titre.IdEditeur = editeur.IdEditeur
WHERE titre.Type <> 'informatique'

--exercice16
INSERT INTO auteur 
(IdAuteur, NomAuteur, PnAuteur, Telephone, Adresse, Ville, Pays, CodePostal, Contrat) 
VALUES
('123-45-6789', 'Bouden', 'Amira', '45.33.08.49', '50, blabla', 'paris', 'FR', '75000', b'1');
/*quand on relance la meme requete, on retape le meme IdAuteur, ce qui est incorrecte car ce dernier est la clé primaire de la table autre donc elle doit etre unique*/

--exercice17
INSERT INTO auteur (IdAuteur, NomAuteur, PnAuteur, Telephone, Adresse, Ville, Pays, CodePostal, Contrat)
SELECT '123-45-6799', 'Abaied',PnAuteur, Telephone, Adresse, Ville, Pays, CodePostal, Contrat
FROM auteur
WHERE IdAuteur = '123-45-6789'

--exercice18
SELECT titre.Titre, titre.Prix 
FROM titre 
INNER JOIN editeur ON editeur.IdEditeur = titre.IdEditeur
WHERE editeur.NomEditeur = 'Algodata Infosystems';

UPDATE titre
INNER JOIN editeur ON editeur.IdEditeur = titre.IdEditeur
SET titre.prix = titre.Prix + (titre.prix * 0.1)
WHERE editeur.NomEditeur = 'Algodata Infosystems';

SELECT titre.Titre, titre.Prix 
FROM titre 
INNER JOIN editeur ON editeur.IdEditeur = titre.IdEditeur
WHERE editeur.NomEditeur = 'Algodata Infosystems';

--exercice19
DELETE FROM auteur 
WHERE auteur.IdAuteur = '123-45-6789'
OR  auteur.IdAuteur = '123-45-6799';



