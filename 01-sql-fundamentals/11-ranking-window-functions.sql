/*
							INTEGER_BASED RANKING
							RANKING WINDOW FUNCTION
	     syntax example
RANK() OVER(PARTITION BY ProductID ORDER BY Sales)
            1.ROW_NUMBER()
assign a unique number to each row
it doesn't handle ties
         syntax example
ROW_NUMBER() OVER(ORDER BY Sales DESC)
*/
--rank ther orders based on their sales from highest to lowest
SELECT
OrderID,
ProductId,
Sales,
ROW_NUMBER() OVER(ORDER BY Sales DESC) SalesRank_Row
FROM Sales.Orders

.................................................................................................
/*
       RANK()
assign a ran to each row
it handles ties
it leaves gaps in ranking
       syntax example
RANK() OVER(ORDER BY Sales DESC)
*/
--rank the orders based on their sales from highest to lowest
SELECT
    OrderID,
    ProductID,
    Sales,
    RANK() OVER(ORDER BY Sales DESC) SalesRank_Rank
FROM Sales.Orders
  
................................................................................................

/*
      DENSE_RANK()
assign a rank to each row
it handles ties
it doesn't leaves gaps in ranking
     syntax example
DENSE_RANK OVER(ORDER BY Sales DESC)
*/
--rank the orders based on their sales from highes to lowest
SELECT
OrderID,
ProductID,
Sales,
DENSE_RANK() OVER(ORDER BY Sales DESC) SalesRankDense
FROM Sales.Orders

................................................................................................
/*
           ROW_NUMBER USE CASE
#1. TOP_N ANALYSIS
*/
--find the top highest sales for each product
SELECT
*
FROM(
    SELECT
    OrderID,
    ProductID,
    Sales,
    ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales DESC) RankByProduct
    FROM Sales.Orders
)t
WHERE RankByProduct = 1

.................................................................................................
/*
    ROW_NUMBER USE CASE
#2.BOTTOM_N ANALYSIS
helps analyse the underperformance to manage risks and to do optimazations
*/
--find the lowest 2 customers based on their total sales 
SELECT
*
FROM(
    SELECT
        CustomerID,
        SUM(Sales) TotalSales,
        ROW_NUMBER() OVER(ORDER BY SUM(Sales)) RankCustomers
    FROM Sales.Orders
    GROUP BY 
    CustomerID

)t
WHERE RankCustomers <=2

...............................................................................................
/*
        ROW_NUMBER USE CASE
    #3. GENERATE UNIQUE IDs
help to assign unique identifiers for each row to help paginating
*/
--assig unique IDs to the rows of the 'Orders Archive' table
SELECT
ROW_NUMBER() OVER(ORDER BY OrderID, OrderDate) UniqueID,
*
FROM Sales.OrdersArchive

..................................................................................................
/*
    ROW_NUMBER USE CASE
#4. IDENTIFY DUPLICATES
identify and remove duplicate rows to improve data quality
*/
--identify duplicate rows in the table 'Orders Archive'
--add return a clean resultwithout any duplicates
SELECT
*
FROM(
    SELECT
        ROW_NUMBER() OVER(PARTITION BY OrderID ORDER BY CreationTime DESC) rn,
        *
    FROM Sales.OrdersArchive
    )t
      WHERE rn=1

................................................................................................
/*
ROW_NUMBER | USE CASES
   #1. Top-N Analysis
   #2. Bottom-N Analysis
   #3. Assign unique IDs
   #4. Quality Checks:Identify Duplicates
*/

...................................................................................................
/*
      NTILE()
divides the rows into specified number of approximately equal groups(Buckets)
      syntax example
NTILE(2) OVER(ORDER BY Sales DESC)
      sql rule
larger groups come first
*/

SELECT
    OrderID,
    Sales,
    NTILE(4) OVER(ORDER BY Sales DESC) FourBuckets,
    NTILE(3) OVER(ORDER BY Sales DESC) FourBuckets,
    NTILE(2) OVER(ORDER BY Sales DESC) FourBuckets,
    NTILE(1) OVER(ORDER BY Sales DESC) FourBuckets
FROM Sales.Orders

..................................................................................................
/*
             NTILE USE CASE
#1. DATA SEGMENTATION
divides a dataset into distinct subsets based on certain criteria.
*/
--segment all orders into 3 categories: high, medium and low sales
SELECT
*,
CASE  WHEN Buckets =1 THEN 'High'
      WHEN Buckets =2 THEN 'Medium'
      WHEN Buckets =3 THEN 'Low'
END SalesSegmentations
FROM(
    SELECT
        OrderID,
        Sales,
        NTILE(3) OVER(ORDER BY Sales DESC) Buckets
    FROM Sales.Orders
    )t

...............................................................................................
/*
			NTILE USE CASE
#2. EQUALIZING LOAD
*/
--in order to export the data , divide the orders into 2 groups.
SELECT
	NTILE(2) OVER(ORDER BY OrderID) Buckets,
	*
FROM Sales.Orders

.................................................................................................
/*
PERCENTAGE-BASED RANKING
      1. PERCENT_RANK()
    calculates the relative position of each row
          syntax example
      PERCENT_RANK() OVER(ORDER BY Sales DESC)
           tie rule
      the position of the first occurrence of the same value

         
      2. CUME_DIST()
    cumulative distribution calculates the distribution of data points within a window
          syntax example
     CUME_DIST() OVER(ORDER BY Sales DESC)
          tie rule
     the position of the first occurrence of the same value

*/
--find the products that fall within the highest 40% of the prices
SELECT
*,
CONCAT(DistRank*100, '%')DistRankPerc
FROM(
    SELECT
      Product,
      Price,
      CUME_DIST() OVER (ORDER BY Price DESC) DistRank
    FROM Sales.Products
    )t
WHERE DistRank <= 0.4
...................................................................................................
--find the products that fall within the highest 40% of the prices
SELECT
*,
CONCAT(DistRank * 100, '%') DistRankPerc
FROM(
	SELECT 
		Product,
		Price,
		PERCENT_RANK()OVER(ORDER BY Price DESC)DistRank
	FROM Sales.Products
    )t
WHERE DistRank <= 0.4

...................................................................................................
/*
       WINDOW RANK FUNCTIONS SUMMARY
       types. Integer-based-ranking
             1. ROW_NUMBER()
             2. RANK()
             3. DENSE_RANK()
             4. NTILE()

       types. Percentage-based_ranking
             1. CUME_DIST()
             2. PERCENT_RANK()  



      RULES
      expression-empty
      ORDER BY - required
      FRAME- not allowed

      USE CASES
      top N analysis
      bottom N analysis
      identity + remove dupicates
      assign unique IDs + Pagination
      data Segmentation analysis
      equalizing load processing
*/
....................................................................................................