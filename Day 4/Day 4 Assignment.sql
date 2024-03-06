-- DAY 4 ASSIGNMENT

USE SQL_training

-- 1. Write an update statement to set the city as null for order IDs: CA-2020-161389, US-2021-156909

UPDATE Orders
SET city = NULL
WHERE order_id IN ('CA-2020-161389', 'US-2021-156909')

-- 2. Write a query to find orders where the city is null (2 rows)

SELECT * 
FROM Orders
WHERE city IS NULL

-- 3. Write a query to get the total profit, the first order date, and the latest order date for each category

SELECT category, 
       SUM(profit) AS Total_profit, 
       MIN(order_date) AS first_order_date, 
       MAX(order_date) AS latest_order_date
FROM Orders
GROUP BY category

-- 4. Write a query to find sub-categories where the average profit is more than half of the maximum profit in that sub-category

SELECT sub_category
FROM Orders
GROUP BY sub_category
HAVING AVG(profit) > MAX(profit) * 0.5

-- 5. Create the exams table with the following script

CREATE TABLE exams (student_id INT, subject VARCHAR(20), marks INT);
INSERT INTO exams VALUES (1,'Chemistry',91),(1,'Physics',91),(1,'Maths',92),
                         (2,'Chemistry',80),(2,'Physics',90),
                         (3,'Chemistry',80),(3,'Maths',80),
                         (4,'Chemistry',71),(4,'Physics',54),
                         (5,'Chemistry',79);

-- Write a query to find students who have got the same marks in Physics and Chemistry

SELECT student_id, marks 
FROM exams
WHERE subject IN ('Physics','Chemistry')
GROUP BY student_id, marks
HAVING COUNT(1) = 2

-- 6. Write a query to find the total number of products in each category

SELECT category, COUNT(DISTINCT product_id) AS product_name 
FROM Orders
GROUP BY category

-- 7. Write a query to find the top 5 sub-categories in the West region by total quantity sold

SELECT TOP 5 sub_category, SUM(quantity) AS total_quantity_sold
FROM Orders
WHERE region = 'West'
GROUP BY sub_category
ORDER BY total_quantity_sold

-- 8. Write a query to find the total sales for each region and ship mode combination for orders in the year 2020

SELECT region, ship_mode, SUM(sales) AS total_sales
FROM Orders
WHERE order_date BETWEEN '2020-01-01' AND '2020-12-31'
GROUP BY region, ship_mode
ORDER BY region
