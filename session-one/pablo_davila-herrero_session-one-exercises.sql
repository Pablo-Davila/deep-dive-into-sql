/*
WDSS Deep-Dive Into SQL: Session One Homework

To receive a certificate email all four
homework files to education@wdss.io

To start out with this homework, connect to the
course database with the following details

- Host: sql.wdss.io
- Port: 33061
- User: guest
- Password: relational

The homework exercises below will make use of the 'genes' database.
With the help of this database and our SQL skills we will retrieve
data to help us analyse the characteristics, functions, and interactions
of different genes.
*/

-- USING THE GENES TABLE

/* Question 1:
Select the 'GeneID' and 'Function' columns. Use 'ID' as an
alias for GeneID. Name three different types of gene functions that
you can see upon inspection. If you're having problems with this task leave it until you've
seen session 3
*/

SELECT GeneID AS ID, `Function`
FROM genes.Genes;

-- CELLULAR ORGANIZATION (proteins are localized to the corresponding organelle)
-- PROTEIN SYNTHESIS
-- CELL RESCUE, DEFENSE, CELL DEATH AND AGEING


/* Question 2:
Select all of the genes located in the nucleus and with
'METABOLISM' as their function.
*/

SELECT *
FROM genes.Genes
WHERE Localization = "nucleus" AND `Function` = "METABOLISM";


/* Question 3:
Select the top 20 genes located in the cytoplasm with strictly
more than 2 chromosones.
*/

SELECT *
FROM genes.Genes
WHERE Localization = "cytoplasm" AND Chromosome > 2
LIMIT 20;


/* Question 4:
Select all of the 'Essential' genes located in either
the cytoplasm or mitochondria.
*/

SELECT *
FROM genes.Genes
WHERE Essential = "Essential" AND Localization IN ("cytoplasm", "mitochondria");


/* Question 5:
Select the top 10 genes without exactly 2 chromosones and belonging to the
'ATPases' gene class.
*/

SELECT *
FROM genes.Genes
WHERE Chromosome <> 2 AND Class = "ATPases"
LIMIT 10;


-- USING THE INTERACTIONS TABLE

/* Question 6:
Select all physical interactions with correlation greater than 0.5.
*/

SELECT *
FROM genes.Interactions
WHERE `Type` = "Physical" AND Expression_Corr >= 0.5;


/* Question 7:
Select all genetic interactions with correlation strictly less than -0.4.
*/

SELECT *
FROM genes.Interactions
WHERE `Type` = "Genetic" AND Expression_Corr < -0.4;


/* Question 8:
Select all interactions with correlation greater than |0.4|.
*/

SELECT *
FROM genes.Interactions
WHERE ABS(Expression_Corr) >= 0.4;


/* Question 9:
Select the top 10 genetic reactions with highest absolute correlation
(Hint: We will learn about a more efficient way to go about
 this in the next session, but for now try selecting those with absolute
 correlations of more than 0.95 and work from there.
*/

SELECT *
FROM genes.Interactions
WHERE `Type` = "Genetic" AND ABS(Expression_Corr) > 0.930408710
LIMIT 10;

SELECT *
FROM genes.Interactions
WHERE `Type` = "Genetic"
ORDER BY ABS(Expression_Corr) DESC
LIMIT 10;


/* Question 10:
Select all physical interactions with correlation greater than |0.3| and
genetic interactions with correlation greater than |0.5|
(Genetic-physical reactions must satisfy the least binding of these constraints).
*/

SELECT *
FROM genes.Interactions
WHERE
	(ABS(Expression_Corr) >= 0.3 AND `Type` IN ("Genetic-Physical", "Physical"))
	OR
	(ABS(Expression_Corr) >= 0.5 AND `Type` = "Genetic");
