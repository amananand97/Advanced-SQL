-- DAY 4

-- Select all orders
SELECT * 
FROM Orders

-- Adding some null values
UPDATE Orders
SET city = NULL
WHERE order_id IN ('CA-2018-144666', 'US-2020-120929')

-- Select orders with null values
SELECT * 
FROM Orders
WHERE order_id IN ('CA-2018-144666', 'US-2020-120929')

-- Will not work
SELECT * 
FROM Orders
WHERE city IS NULL

-- Filtering null values
SELECT * 
FROM Orders
WHERE city IS NULL

SELECT * 
FROM Orders
WHERE city IS NOT NULL

-- AGGREGATIONS

-- COUNT
SELECT COUNT(*) AS cnt
FROM Orders

SELECT SUM(sales) AS Total_Sales
FROM Orders

SELECT 
  MAX(sales) AS max_sales, 
  MIN(sales) AS min_sales, 
  AVG(profit) AS Avg_profit
FROM Orders

-- Group by
SELECT 
  region, 
  COUNT(*) AS cnt,
  SUM(sales) AS total_sales,
  MAX(sales) AS max_sales,
  MIN(sales) AS min_profit,
  AVG(profit) AS avg_profit
FROM Orders
GROUP BY region

-- HAVING
SELECT 
  sub_category, 
  SUM(sales) AS total_sales
FROM Orders
WHERE profit > 50
GROUP BY sub_category
HAVING SUM(sales) > 100000
ORDER BY total_sales DESC

SELECT 
  sub_category, 
  SUM(sales) AS total_sales
FROM Orders
GROUP BY sub_category
HAVING MAX(order_date) > '2020-01-01'
ORDER BY total_sales DESC;

-- Example data
-- chairs, '2019-01-01', 100
-- chairs, '2019-10-10', 200
-- bookcases, '2019-01-01', 300
-- bookcases, '2020-10-10', 400

SELECT 
  sub_category, 
  SUM(sales) AS total_sales, 
  MAX(order_date)
FROM Orders
GROUP BY sub_category
-- HAVING MAX(order_date) > '2020-01-01'
ORDER BY total_sales DESC;

-- Example data
-- chairs, '2019-10-10', 300
-- bookcases, '2020-10-10', 700

-- COUNT
SELECT COUNT(*)
FROM Orders

SELECT COUNT(category)
FROM Orders

SELECT COUNT(DISTINCT region)
FROM Orders

SELECT COUNT(1)
FROM Orders

SELECT COUNT(2)
FROM Orders

-- Does not count null values
SELECT COUNT(city),
SUM(sales)
FROM Orders
