  --TIME GAP ANALYSIS
--find the number of days between each order and previous order
SELECT
    OrderID,
    OrderDate CurrentOrderDate,
    LAG(OrderDate) OVER(ORDER BY OrderDate)PreviousOrderDate,
    DATEDIFF(day, LAG(OrderDate) OVER(ORDER BY OrderDate),OrderDate)NrOfDays
FROM Sales.Orders