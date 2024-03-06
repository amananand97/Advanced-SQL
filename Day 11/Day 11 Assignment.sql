-- DAY 11 ASSIGNMENT

-- 1. Write a query to find the top 3 products in each category by the highest rolling 3 months total sales for Jan 2020.
WITH xxx AS (
  SELECT category, product_id, DATEPART(year, order_date) AS yo, DATEPART(month, order_date) AS mo, SUM(sales) AS sales
  FROM Orders
  GROUP BY category, product_id, DATEPART(year, order_date), DATEPART(month, order_date)
),
yyyy AS (
  SELECT *, SUM(sales) OVER (PARTITION BY category, product_id ORDER BY yo, mo ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS roll3_sales
  FROM xxx
)
SELECT *
FROM (
  SELECT *, RANK() OVER (PARTITION BY category ORDER BY roll3_sales DESC) AS rn
  FROM yyyy
  WHERE yo = 2020 AND mo = 1
) A
WHERE rn <= 3;

-- 2. Write a query to find products for which month-over-month sales have never declined.
WITH xxx AS (
  SELECT product_id, DATEPART(year, order_date) AS yo, DATEPART(month, order_date) AS mo, SUM(sales) AS sales
  FROM Orders
  GROUP BY product_id, DATEPART(year, order_date), DATEPART(month, order_date)
),
yyyy AS (
  SELECT *, LAG(sales, 1, 0) OVER (PARTITION BY product_id ORDER BY yo, mo) AS prev_sales
  FROM xxx
)
SELECT DISTINCT product_id
FROM yyyy
WHERE product_id NOT IN (
  SELECT product_id
  FROM yyyy
  WHERE sales < prev_sales
  GROUP BY product_id
);

-- 3. Write a query to find month-wise sales for each category for months where sales are more than the combined sales of the previous 2 months for that category.
WITH xxx AS (
  SELECT category, DATEPART(year, order_date) AS yo, DATEPART(month, order_date) AS mo, SUM(sales) AS sales
  FROM Orders
  GROUP BY category, DATEPART(year, order_date), DATEPART(month, order_date)
),
yyyy AS (
  SELECT *, SUM(sales) OVER (PARTITION BY category ORDER BY yo, mo ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING) AS prev2_sales
  FROM xxx
)
SELECT *
FROM yyyy
WHERE sales > prev2_sales;
