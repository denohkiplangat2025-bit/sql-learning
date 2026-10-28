/* USE CASE 2#
 Handle the NULL beofe doing mathemathical operations */
 --Display the full of customers in a single field, 
 --by merging their first and last names,
 --and add 10 bonus points to each customer's scores.
 SELECT
 FirstName,
 LastName,
 FirstName + '  ' + COALESCE(LastName, ' ') AS FullName,
 Score,
 COALESCE(Score, 0) + 10 As ScoreWithBonus
 FROM Sales.Customers


 /*
   USE CASE#3
handle the NULL before JOINING tables
   
   USE CASE#4
handle NULL before sorting data
*/
--Sort the customers from lowest to the highest scores,
--with nulls appearing last
SELECT
   CustomerID,
   Score
FROM Sales.Customers
ORDER BY CASE WHEN Score is NULL THEN 1 
              ELSE 0 END, Score


/* 
        NULLIF()
compares two expressions returns:
 -NULL, if they are equal
 -First Value, if they are not equal
        syntax
    NULL(value1, value2)
        examples
    NULLIF(Shipping_Address, 'unkown')
    NULLIF(Shipping_Addres, Billing_Address)
        NULLIF() USE CASE
    -division by zero
    -preventing the error of diving by zero


*/
--Find the price for each order by dividing sales by quantity
SELECT
  OrderId,
  Sales,
  Quantity,
  Sales/ NULLIF(Quantity,0) AS Price
FROM Sales.Orders



/*
      IS NULL
returns TRUE if the vale IS NULL , otherwise it returns FALSE .

      IT IS NOT NULL 
returns TRUE if the value IS NOT NULL, otherwise returns FALSE.

      syntax
   Value IS NULL
   Value IS NOT NULL

     exapmles
    Shipping_Addres IS NULL
    Shipping_Addres IS NOT NULL


*/
       --#1 USE CASE
          --searching for missing information
--Identify the customers who have no scores
SELECT
*
FROM Sales.Customers
WHERE Score IS NULL

--List all customerds who have scores
SELECT
*
FROM Sales.Customers
WHERE Score IS NOT NULL



/*
           IS NULL USE CASES
        #1. ANTI JOINS
    finding the unmatched rows between two tables 
        #2. LEFT ANTI JOIN
    all rows from the left table without matches in the right table


*/
--list all details for customers who have not placed any orders 
SELECT 
c.*,
o.OrderID
FROM Sales.Customers c
LEFT JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID
WHERE o.CustomerID IS NULL




--          BLANK SPACE
-- Sting value has one ore more space characters 
WITH Orders AS(
SELECT 1 Id, 'A' Category UNION
SELECT 2, NULL UNION
SELECT 3, '' UNION
SELECT 4, ' '
)
SELECT
*,
DATALENGTH(Category) CategoryLen
FROM Orders


/*
         DATA POLICY
set of rules that defines how data should be handled 
       #1. data policy
only use NULLs and empty strings, but avoid blank spaces
       TRIM
remove unwanted leading and trailing spaces from a string
*/


WITH Orders AS(
SELECT 1 Id, 'A' Category UNION
SELECT 2, NULL UNION
SELECT 3, '' UNION
SELECT 4, ' '
)
  SELECT
  *,
  DATALENGTH(Category) CategoryLen,
  DATALENGTH(TRIM(Category)) Policy1
  FROM Orders



  /* 
   #2 DATA POLICY
only use NULLS and avoid using empty strings and blank spaces
*/

WITH Orders AS (
SELECT 1 Id, 'A' Category UNION
SELECT 2, NULL UNION
SELECT 3, '' UNION
SELECT 4, ' '
)
SELECT
*,
TRIM(Category) Policy1,
NULLIF(TRIM(Category), '') Policy2
FROM Orders



/*
   #3 DATA POLICY
use the default value 'unkwon' and avoid using nulls, empty stings, and blank spaces.
*/

WITH Orders AS (
SELECT 1 Id, 'A' Category UNION
SELECT 2, NULL UNION
SELECT 3, '' UNION
SELECT 4, ' '
)
SELECT
	*,
	TRIM(Category) Policy1,
	NULLIF(TRIM(Category), '') Policy2,
	COALESCE(NULLIF(TRIM(Category), ''), 'unknown') Policy3
FROM Orders



/*
                CASE STATEMENT
evaluates a list of conditions and returns a value when the first condition is met
                syntax
CASE 
  WHEN condition1 THEN result1
  WHEN condition2 THEN result2
  ------
  ELESE result
END
                example
CASE 
  WHEN Sales > 50 THEN 'High'
  WHEN Sales > 20 THEN  'Medium'
END

Main purpose of it is 
   1.DATA TRANSPORTATION
     -derive new information
     -create new columns based on existing data
   2.CATEGORIZING DATA
    group the data into different categories based on certain conditions.


*/

--create report showing total sales for each of the following categories:
--High(Sales over 50), Medium(Sales 21-50)
--Low(Sales 20 or less)
--soort the categories from Heighest to Lowest sales.
SELECT 
Category,
SUM(Sales) AS TotalSales
FROM(
     SELECT
     OrderID,
     Sales,
     CASE
          WHEN Sales > 50 THEN 'High'
          WHEN Sales > 20 THEN  'Medium'
          ELSE 'Low'
     END Category
     FROM Sales.Orders
     )t
GROUP BY Category
ORDER BY TotalSales DESC



/*
 #2. USE CASE
   MAPPING VALUES
   transform the values from one form to another  
*/


--retrieve employees datails with gender displayed as full text
SELECT
EmployeeID,
FirstName,
LastName,
Gender,
CASE 
     WHEN Gender = 'F' THEN 'Female'
     WHEN Gender = 'M' THEN 'Male'
     ELSE 'Not Available'
END GenderFullText
FROM Sales.Employees

=================================================================================================================================================
--retrieve customers details with abbreviated country code.
SELECT
CustomerID,
FirstName,
LastName,
Country,
CASE 
    WHEN Country = 'Germany' THEN 'DE'
    WHEN Country =  'USA' THEN 'US'
    ELSE 'n/a'
END CountryAbbr
FROM Sales.Customers;


SELECT DISTINCT Country
FROM Sales.Customers

=================================================================================================================================================
/*
         syntax
1. Full Form
CASE 
     WHEN Country = 'Germany' THEN 'DE'
     WHEN Country = 'India' THEN 'IN'
     WHEN Country = 'United States' THEN 'US'
     WHEN Country = 'France' THEN 'FR'
     WHEN Country = 'Italy' THEN 'IT'
     ELSE 'n/a'
END

2. Quick Form
 CASE  Country
      WHEN 'Germany' THEN 'DE'
      WHEN 'India' THEN 'IN'
      WHEN 'United States' THEN 'US'
      WHEN 'France' THEN 'FR'
      WHEN 'Italy' THEN 'IT'
      ELSE 'n/a'
END
*/

=================================================================================================================================================

/*
#3. USE CASE
   HANDLING NULLs
replace NULLs with a specific value 
NULLs can lead to inaccurate results, which can lead to wrong decision-making
*/
--find the average scores of ccustomers and treat NULLs as 0,
--Additionally provide details such as CustomerID and LastName
SELECT
CustomerID,
LastName,
Score,
CASE 
    WHEN Score IS NULL THEN 0
    ELSE Score
END ScoreClean,

AVG(CASE 
        WHEN Score IS NULL THEN 0
        ELSE Score
    END) OVER () AvgCustomerClean,

AVG(Score) OVER () AvgCustomer
FROM Sales.Customers

=================================================================================================================================================
/*
#4.USE CASE
  CONDITIONAL AGGREGATION
apply aggregate functions only on subsets of data that fulfill certain conditions.
*/
--count how many times each customer has made an order with sales greater than 30
SELECT
OrderID,
CustomerID,
Sales,
CASE 
    WHEN Sales > 30 THEN 1
    ELSE 0
END SalesFlag
FROM Sales.Orders
ORDER BY CustomerID;

SELECT
CustomerID,
SUM(CASE 
         WHEN Sales > 30 THEN 1
         ELSE 0
    END) TotalOrderHighSales,
    COUNT(*) TotalOrders
FROM Sales.Orders
GROUP BY CustomerID

===================================================================================================================================================
