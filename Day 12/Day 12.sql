-- DAY 12

-- STORED PROCEDURE

-- Create
CREATE PROCEDURE spemp
AS
  SELECT * FROM employee;

-- Execution
EXEC spemp;

-- Modify
ALTER PROCEDURE spemp (@salary INT)
AS
  SELECT * FROM employee;

-- Expects one parameter now
EXEC spemp @salary = 100;

-- Using parameter
DROP PROCEDURE spemp;
CREATE PROCEDURE spemp (@salary INT, @dept_id INT) -- we can give more parameters
AS
  SELECT * FROM employee WHERE salary > @salary AND dept_id = @dept_id;

EXEC spemp @salary = 5000, @dept_id = 100;  -- This will work

-- This will not work:
-- EXEC spemp 100, 5000;

-- INPUT variable
ALTER PROCEDURE pmp (@dept_id INT)
AS
BEGIN
  DECLARE @cnt INT;

  SELECT @cnt = COUNT(1) FROM employee WHERE dept_id = @dept_id;

  IF @cnt = 0
    PRINT 'There is no employee in this department';
  ELSE
    PRINT 'Total employee: ' + CAST(@cnt AS VARCHAR(10));
END

EXEC pmp @dept_id = 100;

-- OUTPUT Variable
ALTER PROCEDURE pmp1 (@dept_id INT, @cnt INT OUT)
AS
BEGIN
  SELECT @cnt = COUNT(1) FROM employee WHERE dept_id = @dept_id;

  IF @cnt = 0
    PRINT 'There is no employee in this department';
  -- ELSE 
  -- PRINT 'Total employee: ' + CAST(@cnt AS VARCHAR(10));
END

DECLARE @outputCnt INT;
EXEC pmp1 100, @cnt OUT;
PRINT @outputCnt;

-- Functions

CREATE FUNCTION fnproduct (@a INT, @b INT)
RETURNS INT
AS 
BEGIN
  RETURN (SELECT @a * @b);
END

SELECT [dbo].[fnproduct](4, 5);

-- Pivot and Unpivot

SELECT * FROM Orders;
-- Category, Sales_2020, Sales_2021
SELECT category,
       SUM(CASE WHEN DATEPART(YEAR, order_date) = 2020 THEN sales END) AS sales_2020,
       SUM(CASE WHEN DATEPART(YEAR, order_date) = 2021 THEN sales END) AS sales_2021
FROM Orders
GROUP BY category;

SELECT * FROM
(SELECT category, DATEPART(YEAR, order_date) AS yod, sales
FROM Orders) t1
PIVOT (
  SUM(sales) FOR yod IN ([2020], [2021])
) AS t2;

SELECT * FROM
(SELECT category, region, sales
FROM Orders) t1
PIVOT (
  SUM(sales) FOR region IN (West, East, South, EastNorth)
) AS t2;

-- Create a table
SELECT * INTO sales_yearwise FROM
(SELECT category, region, sales
FROM Orders) t1
PIVOT (
  SUM(sales) FOR region IN (West, East, South, EastNorth)
) AS t2;

SELECT * FROM sales_yearwise;

-- OR
CREATE TABLE orders_east AS (SELECT * FROM Orders WHERE region = 'East');
