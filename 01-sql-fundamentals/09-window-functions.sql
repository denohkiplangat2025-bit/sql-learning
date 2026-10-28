  --TIME GAP ANALYSIS
--find the number of days between each order and previous order
SELECT
    OrderID,
    OrderDate CurrentOrderDate,
    LAG(OrderDate) OVER(ORDER BY OrderDate)PreviousOrderDate,
    DATEDIFF(day, LAG(OrderDate) OVER(ORDER BY OrderDate),OrderDate)NrOfDays
FROM Sales.Orders

====================================================================================================================================
-- AGGREGATE FUNCTIONS
--find the total number of orders
SELECT
COUNT(*)
FROM Sales.Orders

===================================================================================================================================
--find the total sales of all orders
SELECT
COUNT(*) AS total_nr_orders,
SUM(Sales) AS total_orders
FROM Sales.Orders

===================================================================================================================================

--find the average sales of all orders
SELECT
COUNT(*) AS total_nr_orders,
SUM(Sales) AS total_sales,
AVG(Sales) AS avg_sales
FROM Sales.Orders

====================================================================================================================================
--find the highest sales of all orders
SELECT
	COUNT(*) AS total_nr_orders,
	SUM(Sales) AS total_sales,
	AVG(Sales) AS avg_sales,
	MAX(Sales) AS highest_sales
FROM Sales.Orders

===================================================================================================================================
--find the lowest sales of all orders
SELECT
    COUNT(*) AS total_nr_orders,
    SUM(Sales) AS total_sales,
    AVG(Sales) AS avg_sales,
    MAX(Sales) AS highest_sales,
    MIN(Sales) AS lowest_sales
FROM Sales.Orders

====================================================================================================================================
/*
               WINDOW FUNCTION
perform calculations(e.g aggregation) on a specific subset of data, without losing the level of details of rows
    GROUP BY
simple aggregation
    WINDOW
aggregation + keep details
   GROUP BY Functions, Aggregate Functions
COUNT(expr)
SUM(expr)
AVG(expr)
MIN(expr)
MAX(expr)
   WINDOW Functions, Aggregate Functions
COUNT(expr)
SUM(expr)
AVG(expr)
MIN(expr)
MAX(expr)
   WINDOW Functions, Rank Functions
ROW_NUMBER()
RANK()
DENSE_RANK()
CUME_DIST()
PERCENT_RANK()
NTILE(n)
*/
=======================================================================================================================================
/*
        WINDOW  FUNCTIONS, Value(Analytics) Functions
LEAD(expr, offset, default)
LAG(expr, offset, default)
FIRST_VALUE(expr)
*/
--find the total Sales Across all orders
SELECT
SUM(Sales)
FROM Sales.Orders
========================================================================================================================================
--find the total sales for each product
SELECT
	ProductID,
	SUM(Sales) TotalSales
FROM Sales.Orders
GROUP BY ProductID

========================================================================================================================================

--find the total sales for each product, additionally provide details such orderID and order date
SELECT
OrderID,
OrderDate,
ProductID,
SUM(Sales) OVER(PARTITION BY ProductID) TotalSalesByProducts
FROM Sales.Orders

========================================================================================================================================

/*
              OVER CLAUSE
tells sql that function used is a window function.
it defines a window or subset of data

PARTITION CLAUSE
divides the dataset into windows (Partitions)
PARTITION BY divides the rows into groups, based on the columns
              syntax
SUM(Sales) OVER(PARTITION BY Product)
calculation is done individually on each window 
SUM(Sales) OVER- Total sales across all rows(Entire Result Set)
*/
--find the total sales across all orders additionally provide details such order id & order date
SELECT
    OrderID,
    OrderDate,
    SUM(Sales) OVER() TotalSales
FROM Sales.Orders

========================================================================================================================================

--find the total sales for each product, additionally provide details such order id and order date
SELECT
	OrderID,
	OrderDate,
	ProductID,
	SUM(Sales) OVER(PARTITION BY ProductID) TotalSales
FROM Sales.Orders

=======================================================================================================================================

--find the total sales across all orders
--find the total sales for each product
--additionally provide details such order Id, order date
SELECT
	OrderID,
	OrderID,
	Sales,
	SUM(Sales) OVER() TotalSales,
    SUM(Sales) OVER(PARTITION BY ProductID) TotalSalesByProducts
FROM Sales.Orders

======================================================================================================================================

--find the total sales for each combination of product and order status
SELECT
	OrderID,
	OrderDate,
	ProductID,
	OrderStatus,
	Sales,
	SUM(Sales) OVER() TotalSales,
	SUM(Sales) OVER(PARTITION BY ProductID) SalesByProducts,
	SUM(Sales) OVER(PARTITION BY ProductID, OrderStatus) SalesByProductsAndStatus
FROM Sales.Orders

=======================================================================================================================================
