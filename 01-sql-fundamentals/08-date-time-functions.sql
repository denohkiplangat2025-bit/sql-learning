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
