--SET OPERATORS 
--rule of set operators
--#1RULE. ORDER BY can be used only once 
--#2RULE. Same Number of Columns 
--#3RULE. Matching Data TYPES
--#4RULE. Same Order of Columns
--#5RULE. First Query Controls Aliases
--#6RULE. Mapping Corrects Columns

--                 1-UNION
--        returns all distinct rows from both queries.
--        removes duplicate rows from the result.
--Combine the data from employees and customers into one table
SELECT
FirstName,
LastName
FROM Sales.Customers
UNION
SELECT
FirstName,
LastName
FROM Sales.Employees

--         2-UNION ALL
--returns all rows from both queries, including duplicating 
/*Combine the data from employees and customers into one table,
  including duplicates*/
  SELECT
  FirstName,
  LastName
  FROM Sales.Employees
  UNION ALL
  SELECT
  FirstName,
  LastName
  FROM Sales.Customers

                          -- 3.EXCEPT
/* Returns all distinct rows from the first query that are not found in the
   second query. 
   It is the only one where the order of queries affects the final result.
*/
--Find the employees who are not customers at the same time
SELECT 
FirstName,
LastName
FROM Sales.Employees
EXCEPT
SELECT
FirstName,
LastName
FROM Sales.Customers



--                     4.INTERSECT
--returns only the rows that are common in both querries
--Find the Employees, who are also customers
SELECT
FirstName,
LastName
FROM Sales.Employees
INTERSECT
SELECT
FirstName,
LastName
FROM Sales.Customers

--COMBINE INFORMATION
/* Combine similar information before analysing the data.
   Database developers divide the data into multiple tables to optimize 
   performance and archive old data. */
--Orders data are stored in separate tables(Orders and OrdersArchive)
--Combine all orders data into one report without duplicates
SELECT
'Orders'AS sourceTable
      ,[OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
FROM Sales.Orders
UNION
SELECT
'OrdersArchive'AS sourceTable
      ,[OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
FROM Sales.OrdersArchive

--        STRING functions
--String Fuctions
--            1. CONCAT
--combines multiple strings into one
--show a list of customers first names together with their country in one column
SELECT
first_name,
country,
CONCAT(first_name,'-',country) AS name_country
FROM customers

            --2.LOWER
--converts all characters to lowercase
--tranform the customer's first name to lowercase
SELECT
first_name,
LOWER(first_name) AS low_name
FROM customers

--3.UPPER
--coverts all characters to uppercase
--transform the customer's first name to uppercase
SELECT
first_name,
UPPER(first_name) AS up_name
FROM customers

--4.TRIM
--removes leading and trailing spaces
/*find customers whose first name contains leading or trailing 
spaces*/
SELECT
first_name
FROM customers
WHERE first_name != TRIM(first_name);

SELECT
first_name,
LEN(TRIM(first_name)) len_trim_name,
LEN(first_name)- LEN(TRIM(first_name)) flag
FROM customers
WHERE LEN(first_name) !=LEN(TRIM(first_name))

--       5.REPLACE
--replaces specific character with a new character
--remove dashes(-) from a phone number
SELECT
'123-456-7890'AS phone,
REPLACE('123-456-7890','-','/') AS clean_phone

--       6.LEN
--counts how many characters
--calculate the length of each customer's first name
SELECT 
first_name,
LEN(first_name) AS len_name
FROM customers

--           7.LEFT
--retrieve the first two characters of each first name
SELECT
first_name,
LEFT(TRIM(first_name),2)first_2_char
FROM customers

--          7.RIGHT
--extracts specific number of characters from the end
--retrieve the last two characters of each first name
SELECT
first_name,
RIGHT(TRIM(first_name),2) last_2_char
FROM customers

--             9.SUBSTRING
--extracts a part of string at a specified position.
/*retrieve a list of customers' first names after removing
  the first character*/
  SELECT
  first_name,
  SUBSTRING(TRIM(first_name),2,LEN(first_name)) AS sub_name
  FROM customers

  --             NUMBER FUNCTIONS
--             1.ROUND
SELECT
3.516,
ROUND(3.516,2) AS round_2,
ROUND(3.516,1) AS round_1,
ROUND(3.516,0) AS round_0

--             2.ABS
--returns the absolute(positive) value of a number,removing any negative sign
SELECT
-10,
ABS(-10),
ABS(10)

--            DATE AND TIME FUNCTIONS
--date column from a table
SELECT
OrderID,
OrderDate,
ShipDate,
CreationTime
FROM Sales.Orders;

--Hardcoded Constant String Value
SELECT
OrderID,
CreationTime,
'2025-08-20' HardCoded
FROM Sales.Orders

--       GETDATE()
--returns the current date and time at the moment when the query is executed
SELECT
OrderID,
CreationTime,
GETDATE() Today
FROM Sales.Orders

--                PART EXTRACTION
--1.DAY/MONTH/YEAR
--DAY() returns the day from a date
--MONTH() returns the month from a date
--YEAR() returns the year from a date
SELECT
OrderID,
CreationTime,
YEAR(CreationTime) Year,
MONTH(CreationTime) Month,
DAY(CreationTime) Day
FROM Sales.Orders

--          2.DATEPART()
--returns a specific part of date as a number
--         syntax
-- DATEPART(part, date)
--         examples
--DATEPART(month, OrderDate)
--DATEPART(mm,'2025-08-20')
SELECT
OrderID
CreationTime,
DATEPART(year,CreationTime) Year_dp,
DATEPART(month,CreationTime) Month_dp,
DATEPART(day,CreationTime) Day_dp,
DATEPART(hour,CreationTime) Hour_dp,
DATEPART(quarter,CreationTime) Quarter_dp,
DATEPART(week,CreationTime) Week_dp
FROM Sales.Orders

--            DATENAME()
--returns the name of a specific part of a date.
--            syntax
--          DATENAME(part, date)
SELECT
OrderID,
CreationTime,
DATENAME(month,CreationTime) Month_dn,
DATENAME(weekday,CreationTime) Weekday_dn,
DATENAME(day,CreationTime) Day_dn,
DATENAME(year,CreationTime) Year_dn
FROM Sales.Orders

--            DATETRUNG()
--truncates the date to the specific part
--           syntax
--      DATETRUNC(part, date)
SELECT
OrderID,
CreationTime,
DATETRUNC(minute,CreationTime) Minute_dt,
DATETRUNC(day,CreationTime) Day_dt,
DATETRUNC(year,CreationTime) Year_dt
FROM Sales.Orders;

SELECT
DATETRUNC(month,CreationTime) Creation,
COUNT(*)
FROM Sales.Orders
GROUP BY DATETRUNC(month,CreationTime);

SELECT
DATETRUNC(year,CreationTime) Creation,
COUNT(*)
FROM Sales.Orders
GROUP BY DATETRUNC(year,CreationTime)

--         5.EOMONTH()
--returns the last day of a month
--         syntax
--      EOMONTH(date)
SELECT
OrderId,
CreationTime,
EOMONTH(CreationTime) EndOfMonth
FROM Sales.Orders;

SELECT
OrderID,
CreationTime,
CAST(DATETRUNC(month,CreationTime)AS DATE) StartOfMonth
FROM Sales.Orders

--how many oders were placed each year?
SELECT
YEAR(OrderDate),
COUNT(*) NOfOrders
FROM Sales.Orders
GROUP BY YEAR(OrderDate)

--how many orders were placed each month?
SELECT
DATENAME(month,OrderDate) AS OrderDate,
COUNT(*) NrOfOrders
FROM Sales.Orders
GROUP BY DATENAME(month,OrderDate)

--show all orders that were placed during the month of february
SELECT*
FROM Sales.Orders
WHERE MONTH(OrderDate)=2








