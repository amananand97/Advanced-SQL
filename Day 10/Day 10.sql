-- DAY 10

-- WINDOWS FUNCTION

-- Sorting employees by department and salary in descending order
SELECT *
FROM employee
ORDER BY dept_id, salary DESC;

-- Selecting the top 2 employees with the highest salary in each department
SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY dept_id ORDER BY salary DESC) AS rn
    FROM employee
) A
WHERE rn <= 2;

-- OR

-- Using a Common Table Expression (CTE) for the same purpose
WITH cte AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY dept_id ORDER BY salary DESC) AS rn
    FROM employee
)
SELECT *
FROM cte
WHERE rn <= 2;

-- RANK

-- Adding row numbers and ranks based on salary in descending order
SELECT *,
       ROW_NUMBER() OVER (ORDER BY salary DESC) AS rn,
       RANK() OVER (ORDER BY salary DESC) AS rnk
FROM employee;

-- Adding row numbers, ranks, and dense ranks within each department based on salary in descending order
SELECT *,
       ROW_NUMBER() OVER (PARTITION BY dept_id ORDER BY salary DESC) AS rn,
       RANK() OVER (PARTITION BY dept_id ORDER BY salary DESC) AS rnk,
       DENSE_RANK() OVER (PARTITION BY dept_id ORDER BY salary DESC) AS d_rnk
FROM employee;

-- Print top 5 selling products from each category by sales

WITH cat_product_sales AS (
    SELECT category, product_id, SUM(sales) AS category_sales
    FROM Orders
    GROUP BY category, product_id
),
rnk_sales AS (
    SELECT *,
           RANK() OVER (PARTITION BY category ORDER BY category_sales DESC) AS rn
    FROM cat_product_sales
)
SELECT *
FROM rnk_sales
WHERE rn <= 5;

-- lead & lag

-- Showing the next employee's salary within the same department, ordered by salary in ascending order
SELECT *,
       LEAD(salary, 1) OVER (PARTITION BY dept_id ORDER BY salary ASC) AS lead_sal
FROM employee;

-- Showing the previous employee's salary within the same department, ordered by salary in descending order
SELECT *,
       LAG(salary, 1) OVER (PARTITION BY dept_id ORDER BY salary DESC) AS lag_sal
FROM employee;

-- first_value and last_value

-- Showing the next employee's salary and the first employee's salary within the same department, ordered by employee name in ascending order
SELECT *,
       LEAD(salary, 1) OVER (PARTITION BY dept_id ORDER BY salary ASC) AS lead_sal,
       FIRST_VALUE(salary) OVER (PARTITION BY dept_id ORDER BY emp_name ASC) AS first_value
FROM employee;
