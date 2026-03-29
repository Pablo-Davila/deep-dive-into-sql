
-- salesdb table

/* QUESTION 1
Perform an INNER JOIN between the tables Employees and Sales on Salesperson ID. 
*/

SELECT *
FROM salesdb.Employees INNER JOIN salesdb.Sales
	ON Employees.EmployeeID = Sales.SalesPersonID;


/* QUESTION 2
Return the first and last names of Customers in order of number of transactions in the table Sales.
*/

SELECT FirstName, LastName
FROM salesdb.Customers
ORDER BY (
	SELECT COUNT(*)
	FROM salesdb.Sales
	WHERE Sales.CustomerID = Customers.CustomerID
) DESC; 


/* QUESTION 3
The manager needs 2 employees manning the store at all times. Generate all possible pairs of employees. 
Count the number of rows to find the number of possible pairs.
*/

SELECT DISTINCT COUNT(*)/2 AS PossiblePairs
FROM salesdb.Employees AS E1 CROSS JOIN salesdb.Employees AS E2
	ON E1.EmployeeID <> E2.EmployeeID;


/* QUESTION 4
Recall that Full Outer Join is no longer supported by MySQL
How could you perform an equivalent operation? 
Read up on UNION and UNION ALL.
Perform a full outer join on the tables Employees and Customers. We want the data to display in a single row if a customer and an employee have the same ID
Do allow duplicate rows.
*/

SELECT *
FROM salesdb.Customers LEFT JOIN salesdb.Employees ON CustomerID = EmployeeID
UNION ALL
SELECT *
FROM salesdb.Customers RIGHT JOIN salesdb.Employees ON CustomerID = EmployeeID;


-- walmart table
/* QUESTION 5
Select the first 10 rows from the key table, ordered by station_nbr descending.
Can you see how this query could be interpreted in 2 different ways? 
Carry out both possible interpretations
*/

SELECT *
FROM walmart.`key`
ORDER BY station_nbr DESC
LIMIT 10;

SELECT *
FROM (
	SELECT *
	FROM walmart.`key`
	LIMIT 10
) meh
ORDER BY meh.station_nbr DESC;


/* QUESTION 6
What are the station numbers that experienced the highest recorded snowfall?
Using your answer, indicate which store corresponds to the highest snowfall recorded, grouped by store. 
Use a NATURAL JOIN
*/

SELECT station_nbr
FROM walmart.weather 
WHERE snowfall = (
	SELECT MAX(snowfall)
	FROM walmart.weather
);

SELECT store_nbr
FROM walmart.`key` NATURAL JOIN (
	SELECT station_nbr
	FROM walmart.weather 
	WHERE snowfall = (
		SELECT MAX(snowfall)
		FROM walmart.weather
	)
) station;


/* QUESTION 7
What was the maximum temperature on 2012-02-05 at all the stores that sold 
more than 120 000 of units in total across all days?
*/

SELECT tmax
FROM walmart.weather NATURAL JOIN walmart.`key`
WHERE `date` = "2012-02-05" AND store_nbr IN (
	SELECT store_nbr
	FROM walmart.train
	GROUP BY store_nbr
	HAVING SUM(units) > 120000
);


-- restbase table
/* QUESTION 10
Select a table of every restaurant ID, their city, and their region, if the region's details are available in the geographic table.
*/

SELECT id_restaurant, city, region
FROM restbase.location NATURAL JOIN restbase.geographic
WHERE region IS NOT NULL;
