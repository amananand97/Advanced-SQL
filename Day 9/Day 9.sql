-- DAY 9: ADVANCED SQL

-- Use the SQL_training database
USE SQL_training;

-- Calculate the average sales from the Orders table
SELECT AVG(sales) FROM Orders;

-- The result of the previous query is incorrect.
-- Find the average order value using a sub-query
SELECT AVG(order_sales) AS avg_order_value
FROM (
    SELECT order_id, SUM(sales) AS order_sales
    FROM Orders
    GROUP BY order_id
) AS orders_aggregated;

-- Find orders with sales greater than the average order value
SELECT order_id
FROM Orders
GROUP BY order_id
HAVING SUM(sales) > (
    SELECT AVG(order_sales) AS avg_order_value
    FROM (
        SELECT order_id, SUM(sales) AS order_sales
        FROM Orders
        GROUP BY order_id
    ) AS orders_aggregated
);

-- Verify a specific order
SELECT *
FROM Orders
WHERE order_id = 'CA-2018-100090';

-- Another example: Find employees not in departments 100, 200, or 300
SELECT *
FROM employee
WHERE dept_id NOT IN (100, 200, 300);

-- Alternatively, use a subquery to achieve the same result
SELECT *
FROM employee
WHERE dept_id NOT IN (SELECT dep_id FROM dept);

-- Calculate the average salary and include it in the result for employees not in department 700
SELECT *, (SELECT AVG(salary) FROM employee) AS avg_sal
FROM employee
WHERE dept_id NOT IN (SELECT dep_id FROM dept);

-- Calculate the average salary for employees not in department 700 directly
SELECT AVG(salary)
FROM employee
WHERE dept_id != 700;

-- Find order values greater than the average order value
SELECT A.*, B.*
FROM (
    SELECT order_id, SUM(sales) AS order_sales
    FROM Orders
    GROUP BY order_id
) A
INNER JOIN (
    SELECT AVG(order_sales) AS avg_order_value
    FROM (
        SELECT order_id, SUM(sales) AS order_sales
        FROM Orders
        GROUP BY order_id
    ) AS orders_aggregated
) B
ON 1 = 1
WHERE order_sales > avg_order_value;

-- For better understanding, join two tables using common columns
SELECT A.*, B.*
FROM table A
INNER JOIN table B ON A.col = B.col;

-- Another example: Join employee and department tables to include the average department salary
SELECT e.*, d.avg_dep_salary
FROM employee e
INNER JOIN (
    SELECT dept_id, AVG(salary) AS avg_dep_salary
    FROM employee
    GROUP BY dept_id
) d
ON e.dept_id = d.dept_id;

-- Question from Day 8 assignment: Calculate matches played, won, and lost for each team
SELECT * FROM icc_world_cup;

SELECT team_name, COUNT(1) AS matches_played, SUM(win_flag) AS matches_won, COUNT(1) - SUM(win_flag) AS matches_lost
FROM (
    SELECT Team_1 AS team_name, CASE WHEN Team_1 = Winner THEN 1 ELSE 0 END AS win_flag
    FROM icc_world_cup
    UNION ALL
    SELECT Team_2 AS team_name, CASE WHEN Team_2 = Winner THEN 1 ELSE 0 END AS win_flag
    FROM icc_world_cup
) A
GROUP BY team_name;

-- Common Table Expressions (CTE) Example
WITH A AS (
    SELECT Team_1 AS team_name, CASE WHEN Team_1 = Winner THEN 1 ELSE 0 END AS win_flag
    FROM icc_world_cup
    UNION ALL
    SELECT Team_2 AS team_name, CASE WHEN Team_2 = Winner THEN 1 ELSE 0 END AS win_flag
    FROM icc_world_cup
)
SELECT team_name, COUNT(1) AS matches_played, SUM(win_flag) AS matches_won, COUNT(1) - SUM(win_flag) AS matches_lost
FROM A
GROUP BY team_name;

-- Another Example: Calculate average department salary and join it with employee data
WITH dep AS (
    SELECT dept_id, AVG(salary) AS avg_dep_salary
    FROM employee
    GROUP BY dept_id
),
total_salary AS (
    SELECT SUM(avg_dep_salary) AS ts
    FROM dep
)
SELECT e.*, d.avg_dep_salary
FROM employee e
INNER JOIN dep d
ON e.dept_id = d.dept_id;

-- Using CTE to calculate order-wise sales and find orders with values greater than the average
WITH order_wise_sales AS (
    SELECT order_id, SUM(sales) AS order_sales
    FROM Orders
    GROUP BY order_id
),
B AS (
    SELECT AVG(order_sales) AS avg_order_value
    FROM order_wise_sales
)
SELECT A.*, B.*
FROM order_wise_sales A
INNER JOIN B
ON 1 = 1
WHERE order_sales > avg_order_value;

-- Using CTE: Example that does not make sense in this context
WITH depts AS (
    SELECT dep_id
    FROM dept
)
SELECT *
FROM employee
WHERE dept_id NOT IN (SELECT dep_id FROM dept);
