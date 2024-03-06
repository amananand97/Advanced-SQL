-- DAY 9 ASSIGNMENT

USE SQL_training;

/* 1. Write a query to find premium customers from orders data. 
Premium customers are those who have done more orders than the average number of orders per customer. */

WITH no_of_orders_per_Cs AS (
    SELECT customer_id, COUNT(DISTINCT order_id) AS no_of_orders
    FROM Orders
    GROUP BY customer_id
)
SELECT *
FROM no_of_orders_per_Cs
WHERE no_of_orders > (SELECT AVG(no_of_orders) FROM no_of_orders_per_Cs)
ORDER BY no_of_orders;

/* 2. Write a query to find employees whose salary is higher than the average salary of employees in their department. */

SELECT e.*
FROM employee e
INNER JOIN (
    SELECT dept_id, AVG(salary) AS avg_sal1
    FROM employee
    GROUP BY dept_id
) d ON e.dept_id = d.dept_id
WHERE salary > avg_sal1;

/* 3. Write a query to find employees whose age is higher than the average age of all the employees. */

SELECT *
FROM employee
WHERE emp_age > (SELECT AVG(emp_age) FROM employee);

/* 4. Write a query to print employee name, salary, and department ID of the highest salaried employee in each department. */

SELECT e.*
FROM employee e
INNER JOIN (
    SELECT dept_id, MAX(salary) AS max_sal
    FROM employee
    GROUP BY dept_id
) d ON e.dept_id = d.dept_id
WHERE salary = max_sal
ORDER BY dept_id;

/* 5. Write a query to print employee name, salary, and department ID of the highest salaried employee overall. */

SELECT emp_name, salary, dept_id
FROM employee
WHERE salary = (SELECT MAX(salary) FROM employee);

/* 6. Write a query to print product ID and total sales of the highest-selling products (by the number of units sold) in each category. */

WITH product_quantity AS (
    SELECT category, product_id, SUM(quantity) AS total_quantity
    FROM Orders
    GROUP BY category, product_id
),
cat_max_quantity AS (
    SELECT category, MAX(total_quantity) AS max_quantity
    FROM product_quantity
    GROUP BY category
)
SELECT *
FROM product_quantity pq
INNER JOIN cat_max_quantity cmq ON pq.category = cmq.category
WHERE pq.total_quantity = cmq.max_quantity;
