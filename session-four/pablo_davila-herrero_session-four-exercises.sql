
-- salesdb

/* QUESTION 1
Perform an anti-join that returns the SalesIDs of customers with no middle name
*/

SELECT SalesID
FROM salesdb.Sales LEFT JOIN salesdb.Customers
	ON Sales.CustomerID = Customers.CustomerID
WHERE Customers.MiddleInitial IS NULL;


/* QUESTION 2
Perform an anti-join of your choosing on any other dataset. 
Describe what the result of the query represents (in plain English).
*/

SELECT City.Name
FROM world.City LEFT JOIN world.Country ON City.CountryCode = Country.Code
WHERE Country.Continent = "Oceania";
-- Perform an anti-join that returns the names of cities in Oceania


/* QUESTION 3
Return the Employee First name and last name, as one column, of employees who have sold a "Hex Nut". There should be no repetitions. Alias the resulting column as "full_name". 
You are encouraged to inspect the appropriate table before creating the query. This query could take quite long to run if you select unnecessary columns
*/

SELECT DISTINCT CONCAT_WS(" ", FirstName, LastName) AS full_name
FROM salesdb.Employees NATURAL JOIN salesdb.Sales NATURAL JOIN salesdb.Products
WHERE Products.Name LIKE "Hex Nut%";


/* QUESTION 4
The police are investigating your business, looking for an alleged thief. The only thing they know about the suspect is that they have no middle name but have bought something at your shop. 
The police are requesting a list of all your customers (first name, middle initial and last name), as a single column. Fill in the NULL values with an initial of your choosing to avoid anyone being arested.
Rename the column so the police aren't suspicious.
*/

SELECT CONCAT_WS(" ", Customers.FirstName, COALESCE(Customers.MiddleInitial, "J"), Customers.LastName) AS full_name
FROM salesdb.Customers;


/* QUESTION 5
The police have noticed that one middle initial occurs much more frequently then the others and are questioning if you have tampered with the records.
You apologise profusely and blame it on a technical problem. Build another query that emulates a more natural distribution of middle initials (use CASE WHEN and/or IF)
*/

SELECT CONCAT_WS(
	" ",
	Customers.FirstName,
	COALESCE(
		Customers.MiddleInitial,
		CASE
			WHEN CustomerID % 5 = 0 THEN "J"
			WHEN CustomerID % 5 = 1 THEN "R"
			WHEN CustomerID % 5 = 2 THEN "L"
			WHEN CustomerID % 5 = 3 THEN "M"
			ELSE "N"
		END
	),
	Customers.LastName
) full_name
FROM salesdb.Customers;


-- carcinogenesis

/* QUESTION 6
Recall the simple query we did using IF. It created a column with the values we specified (much like COALESCE). 
Now, inspect the canc table. Create a query that describes a drug  based on its class. Ie if its in class 1 it should say "yes" and if 0 it should say "no". Alias the column with a name of your choosing
*/

SELECT IF(class=0, "yes", "no") AS IsClass0
FROM carcinogenesis.canc;


-- walmart

/* QUESTION 7
What days of the week has the sun risen at 7am (correct to 1 min)? Use CAST(expression AS datatype). 
Can you execute the query without using CAST()?
*/

SELECT DAYNAME(`date`) AS WeekDaysSunrise7am
FROM walmart.weather
WHERE CAST(sunrise AS CHAR) LIKE "07:00:__";

-- No cast
SELECT DAYNAME(`date`) AS WeekDaysSunrise7am
FROM walmart.weather
WHERE sunrise LIKE "07:00:__";

-- No cast
SELECT DAYNAME(`date`) AS WeekDaysSunrise7am
FROM walmart.weather
WHERE TIMEDIFF(sunrise, "7:00") LIKE "00:00:__";

-- No cast
SELECT DAYNAME(`date`) AS WeekDaysSunrise7am
FROM walmart.weather
WHERE HOUR(TIMEDIFF(sunrise, "7:00")) = 0
	AND MINUTE(TIMEDIFF(sunrise, "7:00")) = 0;


/* QUESTION 8
How many days have passed since each of these sunrises were recorded?
*/

SELECT DAYNAME(`date`) AS WeekDaysSunrise7am, DATEDIFF(NOW(), `date`) AS PassedDays
FROM walmart.weather
WHERE sunrise LIKE "07:00:__";


/* QUESTION 9
On what days of the week did these sunrises happen? Create a view with a query that allows you to answer this question. Give it a unique name.
*/

CREATE VIEW walmart.WeekDaysSunrise7am AS
	SELECT DAYNAME(`date`) AS `WeekDay`
	FROM walmart.weather
	WHERE CAST(sunrise AS CHAR) LIKE "07:00:__";

-- SELECT * from walmart.WeekDaysSunrise7am;


/* QUESTION 10
Does any day of the week occur more often than the rest? Use the view created in Q9 to help you determine what the mode(s) is/are.
*/

SELECT `WeekDay`, COUNT(*) AS NumberOccurrences
FROM walmart.WeekDaysSunrise7am
GROUP BY `WeekDay`
ORDER BY NumberOccurrences DESC;
