-- Find the total score for each country

SELECT
country,
SUM(score) AS total_score
FROM customers
GROUP BY country
-- Query1

-- Find the total score and the total number of customers for each country

SELECT 
country,
SUM(score) AS total_score,
COUNT(id) AS total_customers
FROM customers
GROUP BY country
-- Query2

/* Find the average score for each country considering only customers with a score 
not equal to 0 and return only those countries with an average score  greater than 430 */

SELECT 
country,
AVG(score) AS avg_score
FROM customers 
WHERE score !=0
GROUP BY country
HAVING AVG(score)>430
--Query3

-- Return Unique List  of all countries

SELECT DISTINCT country
FROM customers
--Query4

-- Retrieve only 3 customers

SELECT TOP 3*
FROM customers
--Query5

-- Retrieve the Top 3 customers with the Highest Scores 

SELECT TOP 3*
FROM customers
ORDER BY score DESC
--Query6

-- Retrieve the Lowest 2 Customers based on the score 

SELECT TOP 2*
FROM customers
ORDER BY score ASC
--Query7

-- Get the Two Most Recent Orders

SELECT TOP 2*
FROM orders
ORDER BY order_date DESC
--Query8