-- DAY 6 ASSIGNMENT

-- Add 'dob' column to the 'employee' table
ALTER TABLE employee
ADD dob DATE;

-- Update 'dob' values based on employee age
UPDATE employee
SET dob = DATEADD(YEAR, -1 * emp_age, GETDATE());

-- 1. Query to print emp name, their manager name, and the difference in their age (in days)
-- for employees whose year of birth is before their manager's year of birth
SELECT e1.emp_id, e1.emp_name, e2.emp_name AS manager_name,
       DATEDIFF(DAY, e1.dob, e2.dob) AS diff_in_age
FROM employee e1
INNER JOIN employee e2 ON e1.manager_id = e2.emp_id
WHERE YEAR(e1.dob) < YEAR(e2.dob)
ORDER BY e1.emp_id;

-- 2. Query to find subcategories with no return orders in the month of November
SELECT o.sub_category
FROM Orders o
LEFT JOIN returns r ON o.order_id = r.[Order Id]
WHERE DATEPART(MONTH, order_date) = 11
GROUP BY sub_category
HAVING COUNT(r.[Order Id]) = 0;

-- 3. Query to find order IDs where there is only 1 product bought by the customer
SELECT order_id
FROM Orders
GROUP BY order_id
HAVING COUNT(*) = 1;

-- 4. Query to print manager names along with a comma-separated list (ordered by emp salary)
-- of all employees directly reporting to them
SELECT e2.emp_name AS Manager,
       STRING_AGG(e1.emp_name, ',') WITHIN GROUP (ORDER BY e1.salary) AS emp_list
FROM employee e1
INNER JOIN employee e2 ON e1.manager_id = e2.emp_id
GROUP BY e2.emp_name;

-- 5. Query to get the number of business days between order_date and ship_date (exclude weekends)
SELECT order_id, order_date, ship_date,
       DATEDIFF(DAY, order_date, ship_date) - 2 * DATEDIFF(WEEK, order_date, ship_date) AS No_of_business_days
FROM Orders;

-- 6. Query to print category, total_sales, and total sales of returned orders
SELECT o.category, SUM(o.sales) AS total_sales,
       SUM(CASE WHEN r.[Order Id] IS NOT NULL THEN sales END) AS returned_orders_sales
FROM Orders o
LEFT JOIN returns r ON o.order_id = r.[Order Id]
GROUP BY o.category;

-- 7. Query to print category, total_sales in 2019, and total sales in 2020
SELECT category,
       SUM(CASE WHEN DATEPART(YEAR, order_date) = 2019 THEN sales END) AS total_sales_2019,
       SUM(CASE WHEN DATEPART(YEAR, order_date) = 2020 THEN sales END) AS total_sales_2020
FROM Orders
GROUP BY category;

-- 8. Query to print the top 5 cities in the West region by average number of days between order date and ship date
SELECT TOP 5 city, AVG(DATEDIFF(DAY, order_date, ship_date)) AS avg_days
FROM Orders
WHERE region = 'West'
GROUP BY city
ORDER BY avg_days DESC;

-- 9. Query to print emp name, manager name, and senior manager name (senior manager is the manager's manager)
SELECT e1.emp_name, e2.emp_name AS Manager, e3.emp_name AS Senior_Manager
FROM employee e1
INNER JOIN employee e2 ON e1.manager_id = e2.emp_id
INNER JOIN employee e3 ON e2.manager_id = e3.emp_id;
