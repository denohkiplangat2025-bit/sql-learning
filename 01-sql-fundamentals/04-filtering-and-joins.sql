--COMPARISON OPERATORS
--   (=)
--compare two things
--checks if two values are equal

--Retrieve all customers from Germany
SELECT*
FROM customers
WHERE country = 'Germany'

-- (<>!=)
-- Checks if two values are not equal 
--Retrieve all customers who are not from Germany
SELECT*
FROM customers
WHERE country !='Germany'

--Retrieve all customers  who are from Germany 
SELECT*
FROM customers
WHERE country <>'Germany'

               --(>)
       --checks if a value is greater than another value
--Retrieve all customers with a score greater than 500
SELECT*
FROM customers
WHERE score > 500

            --(>=)
    -- checks if a value is greater than or equal to another value
--Retrieve all customers with a score of 500 or more
SELECT*
FROM customers
WHERE score >= 500

      --(<)Checks if a value is less than another value 
--Retrieve all customers with a score less than 500 
SELECT*
FROM customers 
WHERE score <500

   --(<=)Checks if a value is less than or equal to another value
--Retrieve all customers with a score of 500 or less 
SELECT*
FROM customers
WHERE score <=500

                        --LOGIGAL OPERATOR
               --(AND)All conditions must be TRUE
--Retrieve all customers who are from USA and have a score greater than 500.
SELECT*
FROM customers
WHERE country = 'USA' AND score >500

                       --(OR)Atleast one condition must be TRUE
--Retrieve all customers who are either from the USA OR have a score greater than 500.
SELECT*
FROM customers
WHERE country = 'USA' OR score > 500

                       --(NOT)(reverse)Excludes matching values
--Retrieve all customers with a score not less than 500 
SELECT*
FROM customers
WHERE NOT score <500

              --(BETWEEN)Check if a value is within a range
--Retrieve all customers whose score falls in the range between 100 and 500 
SELECT*
FROM customers
WHERE score BETWEEN 100 AND 500

SELECT*
FROM customers
WHERE score >=100 AND score <=500


                         --(IN)Check if a value exists in a list
--retrieve all customers from either Germany or USA
SELECT*
FROM customers
WHERE country ='Germany' OR country= 'USA';


SELECT*
FROM customers
WHERE country IN('Germany','USA')

                        --(LIKE)Search for a patern in text
--find all customers whose first name starts with 'M'
SELECT*
FROM customers 
WHERE first_name LIKE 'M%'

--find all customers whose first name ends with 'n'
SELECT*
FROM customers
WHERE first_name LIKE '%n'

--find all customers whose first name contains 'r'
SELECT *
FROM customers
WHERE first_name LIKE '%r'

--find all customers whose first name has 'r' in the 3rd position.
SELECT*
FROM customers
WHERE first_name LIKE '__r%'

                             --COMBINING DATA
                             --JOINING DATA 
--recombine data(big picture)
--data enrichment(getting extra data)
--check for existence(filtering)
                           --(1.NO JOIN) Returns data from tables without combining them 
--retrieve all data from customers and orders in two different results
SELECT*
FROM customers

SELECT*
FROM orders

              --(2.INNER JOIN)Returns only matching rows from both tables
--get all customers along with their orders, but only for customers who have placed an order
SELECT
   id,
   first_name,
   order_id,
   sales
FROM customers
INNER JOIN orders
ON id = customer_id

SELECT
   customers.id,
   customers.first_name,
   orders.order_id,
   orders.sales
FROM customers
INNER JOIN orders
ON customers.id = orders.customer_id

SELECT
   c.id,
   c.first_name,
   o.order_id,
   o.sales
FROM customers AS c
INNER JOIN orders AS o
ON c.id = o.customer_id

--(LEFT JOIN)Returns all rows from left and only matchting from right 
--get all customers along with their orders,including those without orders.
SELECT
  c.id,
  c.first_name,
  o.order_id,
  o.sales
FROM customers AS c 
LEFT JOIN orders AS o
ON c.id = o.customer_id

--(RIGHT JOIN)Retruns all rows from right and only matching from left 
--get all customers along with their orders,including orders without matching customers
SELECT
   c.id,
   c.first_name,
   o.order_id,
   o.sales
FROM customers AS c
RIGHT JOIN orders AS o
ON c.id =o.customer_id

SELECT
   c.id,
   c.first_name,
   o.order_id,
   o.sales
FROM orders AS o
LEFT JOIN customers AS c

            --(LEFT ANTI JOIN)Returns row from left that has NO MATCH in right
--get all customers who haven't placed any order
SELECT*
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id
WHERE o.customer_id IS NULL

      --(FULL ANTI JOIN)Returns only rows that don't match in either tables
--find customers without orders and orders without customers
SELECT*
FROM orders AS o
FULL JOIN customers AS c
ON c.id = o.customer_id
WHERE c.id IS NOT NULL OR o.customer_id IS NULL

/*get all customers along with their orders, but only for customers who have placed 
  an order without using INNER JOIN*/
  SELECT*
  FROM customers AS c
  LEFT JOIN orders AS o
  ON c.id = o.customer_id
  WHERE o.customer_id IS NOT NULL

  --(CROSS JOIN)Combines every row from left with every row from right 
--All posible combinations-CARTERSIAN JOIN
--generate all posible combinations of customers and orders
SELECT*
FROM customers
CROSS JOIN orders

/*Using SalesDB,Retrieve a list of all orders, along with the related customer,product,
  and employee details .For each oder, dipslay:
  Order ID, Customer's name, Product name,Sales, Price , Sales person's name */
  
  SELECT
    o.OrderID,
    o.Sales,
    c.FirstName AS CustomerFirstName,
    c.LastName AS CustomerLastName,
    p.Product AS ProductName,
    p.Price,
    e.FirstName AS EmployeeFirstName,
    e.LastName AS EmployeeLastName
FROM Sales.Orders AS o
LEFT JOIN Sales.Customers AS c
ON o.CustomerID = c.CustomerID
LEFT JOIN Sales.Products AS p
ON o.ProductID = p.ProductID
LEFT JOIN Sales.Employees AS e
ON o.SalesPersonID = e.EmployeeID



