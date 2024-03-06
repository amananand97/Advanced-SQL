-- DAY 11

-- Select all employees
SELECT *
FROM employee;

-- Calculate average and maximum salary by department
SELECT *,
  AVG(salary) OVER (PARTITION BY dept_id) AS avg_salary, -- It is not mandatory to give ORDER BY with aggregation function
  MAX(salary) OVER (PARTITION BY dept_id) AS max_salary
FROM employee;

-- Analyze salary with and without order
SELECT *,
  SUM(salary) OVER (PARTITION BY dept_id) AS sum_salary,
  SUM(salary) OVER (PARTITION BY dept_id ORDER BY emp_age) AS sum_salary, -- Running sum
  SUM(salary) OVER (ORDER BY emp_age) AS EntireTable_salary, -- Entire table running sum
FROM employee;

-- Calculate rolling sums for salary
SELECT *,
  SUM(salary) OVER (ORDER BY emp_id ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS rolling_3_salary,
  SUM(salary) OVER (ORDER BY emp_id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS rolling_3_salary_1
FROM employee;

-- Analyze department-wise and total salary
SELECT *,
  SUM(salary) OVER (PARTITION BY dept_id) AS dep_running_salary,
  SUM(salary) OVER (PARTITION BY dept_id ORDER BY emp_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS total_salary
FROM employee;

-- Find the first and last salary values
SELECT *,
  FIRST_VALUE(salary) OVER (ORDER BY salary) AS first_salary,
  LAST_VALUE(salary) OVER (ORDER BY salary) AS last_salary,
  LAST_VALUE(salary) OVER (ORDER BY salary ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS last_salary
FROM employee;

-- Example: Calculate running sales with duplicates considered separately
SELECT order_id, sales, SUM(sales) OVER (ORDER BY order_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_sales
FROM Orders;

-- OR
SELECT order_id, sales, SUM(sales) OVER (ORDER BY order_id, row_id) AS running_sales
FROM Orders;

-- Calculate rolling 3 months sales
WITH month_wise_sales AS (
  SELECT DATEPART(YEAR, order_date) AS year_order, DATEPART(MONTH, order_date) AS month_order, SUM(sales) AS total_sales
  FROM Orders
  GROUP BY DATEPART(YEAR, order_date), DATEPART(MONTH, order_date)
)
SELECT year_order, month_order, total_sales, SUM(total_sales) OVER (ORDER BY year_order, month_order ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS rolling_3_sales
FROM month_wise_sales;
