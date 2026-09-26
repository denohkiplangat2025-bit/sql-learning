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

.................................................................................
.................................................................................
DATA TYPE CONVERSION & DATE CALCULATIONS
/*CONVERT()
  converts a date or time value to a diffferent data type
  syntax
  CONVERT(data_type,value,[,style])
  examples
  CONVERT(INT,'1234')
  CONVERT(VARCHAR, OrderDate, '34')
  */
  SELECT
  CONVERT(INT,'123')AS[String to Int CONVERT],
  CONVERT(DATE,'2025-08-20')AS[String to Date CONVERT];


  SELECT
  CreationTime,
  CONVERT(DATE, CreationTime)AS[Datetime to Date CONVERT]
  FROM Sales.Orders;

  SELECT
  CreationTime,
  CONVERT(DATE,CreationTime)AS [Datetime to Date CONVERT],
  CONVERT(VARCHAR, CreationTime, 32)AS [USA Std.Style:32],
  CONVERT(VARCHAR, CreationTime, 34)AS [EURO Std.Style:34]
  FROM Sales.Orders


  --Data Aggregations

  SELECT
  FORMAT(OrderDate, 'MM yy') OrderDate,
  COUNT(*)
  FROM Sales.Orders
  GROUP BY FORMAT(OrderDate,'MM yy')
  
  --show CreationTime using the following format:
-- Day Wed Jan Q1 2025 12:34:56 PM
SELECT
OrderID,
CreationTime,
'DAY' + FORMAT(CreationTime,'ddd MMM') + 'Q' + 
DATENAME(quarter, CreationTime) + '' + 
FORMAT(CreationTime, 'yyyy hh:mm:ss tt')AS CustomeFormat
FROM Sales.Orders

/* Format & Casting
1. CASTING(checking the data type from one to another)
2. FORMAT()-formats a date or time value
   syntax
   FORMAT(value,format[,culture])
   examples
   FORMAT(OrderDate,'dd/MM/yyyyy')
   FORMAT(OrderDate,'dd/MM/yyyy,'ja-JP')
   FORMAT(1234.56, 'D','fr-FR')
*/

SELECT
OrderID,
CreationTime,
FORMAT(CreationTime,'MM-dd-yyyy')USA_Format,
FORMAT(CreationTime,'dd-MM-yyyy')EURO_Format,
FORMAT(CreationTime,'dd')dd,
FORMAT(CreationTime,'ddd')ddd,
FORMAT(CreationTime,'dddd')dddd,
FORMAT(CreationTime,'MM')MM,
FORMAT(CreationTime,'MMM')MMM,
FORMAT(CreationTime,'MMMM')MMMM
FROM Sales.Orders


/*
    CAST()
converts a value to a specified data type 
     syntax
CAST(value AS data_type)
     example
CAST('123' AS INT)
CAST('2025-08-20' AS DATE)
*/

SELECT
CAST('123' AS INT) AS [String to Int],
CAST(123 AS VARCHAR) AS [Int to String],
CAST('2025-08-20' AS DATE) AS [String to Date],
CAST('2025-08-20' AS DATETIME2) AS [String to Datetime],
CreationTime,
CAST(CreationTime AS DATE) AS [Datetime to Date]
FROM Sales.Orders

/*
     DATE CALCULATIONS
DATEADD()
adds or subtracts a specific time interval to/from a date
         sytax
         DATEADD(part,interval,date)
         examples
         DATEADD(year,2,OrderDate)
         DATEADD(month,-4,OrderDate)
*/
SELECT
     OrderID,
     OrderDate,
     DATEADD(month,3,OrderDate)AS ThreeMonthsLater,
     DATEADD(year,2,OrderDate)AS TwoYearsLater,
     DATEADD(day,-10,OrderDate)AS TenDaysBefore
FROM Sales.Orders

/*
     DATEDIFF()
finds the difference between two dates.
     syntax
     DATEDIFF(year,start_date,end_date)
     examples
     DATEDIFF(year,OrderDate,ShipDate)
     DATEDIFF(day,OrderDate,ShipDate)
*/
--calculate the age of employees
SELECT
     EmployeeID,
     BirthDate,
     DATEDIFF(year,BirthDate,GETDATE())Age
FROM Sales.Employees

--Find the shipping duration in days 
SELECT
    OrderID,
    OrderDate,
    ShipDate,
    DATEDIFF(day,OrderDate,ShipDate)Day2Ship
FROM Sales.Orders

--Find the average shipping duration in days for each month.
SELECT
    MONTH(OrderDate)AS OrderDate,
    AVG(DATEDIFF(day,OrderDate,ShipDate))AvShip
FROM Sales.Orders
GROUP BY MONTH(OrderDate)


------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------

         
/*
      ISDATE()
check if a value is a date
returns 1 if the string value is avalid date
      syntax
ISDATE(value)
      examples
ISDATE('2025-08-20')
ISDATE(2025)
*/
SELECT
ISDATE('123')DateCheck1,
ISDATE('2025-08-20')DateCheck2,
ISDATE('20-08-2025')DateCheck3,
ISDATE('2025')DateCheck4,
ISDATE('08')DateCheck5


--     APPLICATION OF ISDATE()
SELECT
   --CAST(OrderDate AS DATE)OrderDate,
   OrderDate,
   ISDATE(OrderDate),
   CASE WHEN ISDATE(OrderDate) =1 THEN CAST(OrderDate AS DATE)
   ELSE '9999-01-01'
   END NewOrderDate
FROM
  (
  SELECT '2025-08-20' AS OrderDate UNION
  SELECT '2025-08-21' UNION
  SELECT '2025-08-23' UNION
  SELECT '2025-08'
  )t
   


/*
              IS NULL
  replaces 'NULL' with a specified value
              syntax
    ISNULL(Value, replacement_value)
              example
    ISNULL(Shipping_Adress,'unkwon')
    ISNULL(Shipping_Adress, Billing_Address)

              COALESCE()
  returns the first non-null value from a list
              syntax
    COALESCE(value1,value2,value3,--)
              examples
    COALESCE(Shipping_Addres,'unknown')
    COALESCE(Shipping_Address,Billing_Address)
    COALSCE(Shipping_Address,Billing_Addres,'unkown')
*/
--        USE CASES OF IS NULL()
      --#1.use case.
      --Hande the NULL before doing data aggregation 
--Find the average scores of the customer
SELECT
   CustomerID,
   Score,
   COALESCE(Score,0) Score2,
   AVG(Score) OVER() AvgScores,
   AVG(COALESCE(Score,0)) OVER () AvgScores2
FROM Sales.Customers



