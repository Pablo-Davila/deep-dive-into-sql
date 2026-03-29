
-- genes

/* QUESTION 1
What are the types of interactions possible? How many different interactions are there?
*/

SELECT DISTINCT `Type`
FROM genes.Interactions;

SELECT COUNT(*) AS NumberOfInteractions
FROM genes.Interactions;


/* QUESTION 2
What is the maximum and minimum expression_correlation between genes? 
*/

SELECT MIN(Expression_Corr) AS minimum, MAX(Expression_Corr) AS maximum
FROM genes.Interactions;


/* QUESTION 3
Right-click on the Genes Table, then click on "View Structure". 
Which columns are allowed to contain a NULL value? 
Do any of them contain a NULL value?
*/

-- Only `Complex` is allowed to contain NULL values

SELECT *
FROM genes.Genes
WHERE Complex IS NULL;

-- It does not have any NULL values


-- restbase

/* QUESTION 4
Select the ids and location(city) of all restaurants whose address contains the word "san"
*/

SELECT id_restaurant AS id, city
FROM restbase.location
WHERE street_name LIKE "%san%";


/* QUESTION 5
which cities hava a name composed of at least 2 words? How many of exactly 2 words?
*/

SELECT *
FROM restbase.geographic
WHERE city LIKE "% %";

SELECT COUNT(*) AS ExactlyTwoWordsCities
FROM restbase.geographic
WHERE city LIKE "% %" AND city NOT LIKE "% % %"; 


/* QUESTION 6
Using you queries from Question 5 and COUNT() how many cities are there, whose 
names are longer than 2 words? You may use more than 1 query to answer this
*/

SELECT COUNT(*) AS LongerThanTwoWordsCities
FROM restbase.geographic
WHERE city LIKE "% % %"; 


-- walmart
/* QUESTION 7
Select all rows from the weather table, for which the time of snowfall has not been recorded but
total precipitation has
*/

SELECT *
FROM walmart.weather
WHERE snowfall IS NULL AND preciptotal IS NOT NULL;


/* QUESTION 8
Select all station numbers for which the average maximum temperature was above 60
*/

SELECT station_nbr
FROM walmart.weather
GROUP BY station_nbr
HAVING AVG(tmax) >= 60;


/* QUESTION 9
Select all station numbers and their average snowfall. Order by maximum average temperature (lowest to highest). 
Rename the appropriate column to "mean_snowfall"
*/

SELECT station_nbr, AVG(snowfall) AS mean_snowfall
FROM walmart.weather
WHERE snowfall IS NOT NULL
GROUP BY station_nbr
ORDER BY AVG(tmax) ASC;


/* QUESTION 10
Modify your previous query to order by mean snowfall from lowest to highest and by 
maximum average temperature from highest to lowest
*/

SELECT station_nbr, AVG(snowfall) AS mean_snowfall
FROM walmart.weather
WHERE snowfall IS NOT NULL
GROUP BY station_nbr
ORDER BY AVG(snowfall) ASC, AVG(tmax) DESC;
