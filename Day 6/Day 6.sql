-- DAY 6

-- SELF JOIN - Single table joined with itself
-- Highlight the employee and their manager's name
SELECT e1.emp_id, e1.emp_name, e2.emp_name AS Manager_Name 
FROM employee e1
INNER JOIN employee e2 ON e1.manager_id = e2.emp_id

-- Where Employee's salary is greater than Manager's salary
SELECT e1.emp_id, e1.emp_name, e2.emp_name AS Manager, e1.salary
FROM employee e1
INNER JOIN employee e2 ON e1.manager_id = e2.emp_id
WHERE e1.salary > e2.salary

-- STRING AGGREGATIONS
SELECT dept_id, STRING_AGG(emp_name, ',') WITHIN GROUP (ORDER BY emp_name) AS list_of_employees
FROM employee
GROUP BY dept_id

-- DATE FUNCTIONS
SELECT order_id, order_date,
       DATEPART(YEAR, order_date) AS Year_of_order_date,
       DATEPART(MONTH, order_date) AS Month_of_order_date,
       DATEPART(WEEK, order_date) AS Week_of_order_date,
       DATENAME(MONTH, order_date) AS month_name,
       DATENAME(WEEKDAY, order_date) AS week_name
FROM Orders
WHERE DATEPART(YEAR, order_date) = 2020

SELECT order_id, order_date,
       DATEADD(DAY, 5, order_date) AS order_date_5,
       DATEADD(WEEK, 5, order_date) AS order_week_5,
       DATEADD(DAY, -5, order_date) AS order_date_minus_5
FROM Orders

SELECT order_id, order_date, ship_date,
       DATEDIFF(DAY, order_date, ship_date) AS datediff_in_days,
       DATEDIFF(WEEK, order_date, ship_date) AS datediff_in_week
FROM Orders

-- CASE WHEN
-- It checks from top to bottom
SELECT order_id, profit,
       CASE
           WHEN profit < 100 THEN 'low profit'
           WHEN profit < 250 THEN 'medium profit'
           WHEN profit < 400 THEN 'high profit'
           ELSE 'Very High Profit'
       END AS profit_category
FROM Orders
