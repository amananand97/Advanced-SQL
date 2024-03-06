-- DAY 5 ASSIGNMENT

-- 1. Write a query to get region-wise count of return orders

SELECT o.region, COUNT(DISTINCT r.[Order Id]) AS Return_Orders
FROM Orders o
INNER JOIN returns r ON o.order_id = r.[Order Id]
GROUP BY o.region

-- 2. Write a query to get category-wise sales of orders that were not returned

SELECT o.category, SUM(o.sales) AS Sales
FROM Orders o
LEFT JOIN returns r ON o.order_id = r.[Order Id]
WHERE r.[Order Id] IS NULL
GROUP BY o.category

-- 3. Write a query to print department name and average salary of employees in that department

SELECT d.dep_name, AVG(e.salary) AS Average_Salary
FROM employee e
INNER JOIN dept d ON d.dep_id = e.dept_id
GROUP BY d.dep_name

-- 4. Write a query to print department names where none of the employees have the same salary

SELECT d.dep_name
FROM employee e
INNER JOIN dept d ON e.dept_id = d.dep_id
GROUP BY d.dep_name
HAVING COUNT(e.emp_id) = COUNT(DISTINCT e.salary)

-- 5. Write a query to print sub-categories where we have all 3 kinds of returns (others, bad quality, wrong items)

SELECT o.sub_category
FROM Orders o
INNER JOIN returns r ON o.order_id = r.[Order Id]
GROUP BY o.sub_category
HAVING COUNT(DISTINCT r.[Return Reason]) = 3

-- 6. Write a query to find cities where not even a single order was returned

SELECT city
FROM Orders o
LEFT JOIN returns r ON o.order_id = r.[Order Id]
GROUP BY city
HAVING COUNT(r.[Order Id]) = 0

-- 7. Write a query to find the top 3 subcategories by sales of returned orders in the East region

SELECT TOP 3 o.sub_category, SUM(o.sales) AS Sales
FROM Orders o
INNER JOIN returns r ON o.order_id = r.[Order Id]
WHERE o.region = 'East'
GROUP BY o.sub_category
ORDER BY SUM(o.sales) DESC

-- 8. Write a query to print department names for which there are no employees

SELECT d.dep_id, d.dep_name
FROM dept d
LEFT JOIN employee e ON d.dep_id = e.dept_id
WHERE e.emp_name IS NULL

-- 9. Write a query to print employee names for department IDs that are not available in the dept table

SELECT e.*
FROM employee e
LEFT JOIN dept d ON e.dept_id = d.dep_id
WHERE d.dep_id IS NULL
