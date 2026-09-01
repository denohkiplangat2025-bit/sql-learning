--                  SET OPERATORS 
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

--                2-UNION ALL
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

   --              3.EXCEPT
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



--                 4.INTERSECT
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

--               COMBINE INFORMATION
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