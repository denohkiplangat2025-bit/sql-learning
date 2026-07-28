SELECT*
FROM customers

-- Retrieve customers from Germany filtering rows together with columns
SELECT
first_name,
country
FROM customers
WHERE country = 'Germany'

-- Retrieve all customers and sort the results by the highest score first.
SELECT*
FROM customers
ORDER BY score DESC

-- Retrieve all customers and sort the results by the lowest score first.
SELECT*
FROM customers
ORDER BY score ASC

-- Retrieve all customers and sort the results by the country and then by the highest score
SELECT*
FROM customers
ORDER BY country ASC,score DESC