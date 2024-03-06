-- 1. Get all the orders where the customer name has "a" as the second character and "d" as the fourth character (58 rows)
SELECT *
FROM Orders
WHERE customer_name LIKE '_a_d%';

-- 2. Get all the orders placed in the month of December 2020 (352 rows)
SELECT *
FROM Orders
WHERE order_date BETWEEN '2020-12-01' AND '2020-12-31';

-- 3. Get all the orders where ship_mode is neither 'Standard Class' nor 'First Class' and ship_date is after November 2020 (944 rows)
SELECT *
FROM Orders
WHERE ship_mode NOT IN ('Standard Class', 'First Class') AND ship_date > '2020-11-30';

-- 4. Get all the orders where the customer name neither starts with "A" nor ends with "n" (9815 rows)
SELECT *
FROM Orders
WHERE customer_name NOT LIKE 'A%n';

-- 5. Get all the orders where profit is negative (1871 rows)
SELECT *
FROM Orders
WHERE profit < 0;

-- 6. Get all the orders where either quantity is less than 3 or profit is 0 (3348 rows)
SELECT *
FROM Orders
WHERE quantity < 3 OR profit = 0;

-- 7. Create a report of all the orders in the South region where some discount is provided to customers (815 rows)
SELECT *
FROM Orders
WHERE region = 'South' AND discount > 0;

-- 8. Find the top 5 orders with the highest sales in the furniture category
SELECT TOP 5 *
FROM Orders
WHERE category = 'Furniture'
ORDER BY sales DESC;

-- 9. Find all the records in the technology and furniture category for the orders placed in the year 2020 only (1021 rows)
SELECT *
FROM Orders
WHERE order_date BETWEEN '2020-01-01' AND '2020-12-31'
    AND category IN ('Furniture', 'Technology');

-- 10. Find all the orders where the order date is in the year 2020 but the ship date is in 2021 (33 rows)
SELECT *
FROM Orders
WHERE order_date BETWEEN '2020-01-01' AND '2020-12-31'
    AND ship_date BETWEEN '2021-01-01' AND '2021-12-31';
