-- DAY 10 ASSIGNMENT

-- 1. Write a query to print the 3rd highest salaried employee details for each department.
--    Give preference to the younger employee in case of a tie. If a department has less than 3 employees,
--    print the details of the highest salaried employee in that department.

SELECT * FROM employee;

WITH rnk AS (
    SELECT *,
    DENSE_RANK() OVER (PARTITION BY dept_id ORDER BY salary DESC, hire_date ASC) AS rn
    FROM employee
),
cnt AS (
    SELECT dept_id, COUNT(1) AS no_of_emp
    FROM employee
    GROUP BY dept_id
)
SELECT rnk.*
FROM rnk
INNER JOIN cnt ON rnk.dept_id = cnt.dept_id
WHERE rn = 3 OR (no_of_emp < 3 AND rn = 1);

-- 2. Write a query to find the top 3 and bottom 3 products by sales in each region.

WITH region_sales AS (
    SELECT region, product_id, SUM(sales) AS sales
    FROM Orders
    GROUP BY region, product_id
),
rnk AS (
    SELECT *,
    RANK() OVER (PARTITION BY region ORDER BY sales DESC) AS drn,
    RANK() OVER (PARTITION BY region ORDER BY sales ASC) AS arn
    FROM region_sales
)
SELECT region, product_id, sales, 
    CASE WHEN drn <= 3 THEN 'Top 3' ELSE 'Bottom 3' END AS top_bottom
FROM rnk
WHERE drn <= 3 OR arn <= 3;

-- 3. Among all the sub-categories, which sub-category had the highest month-over-month growth by sales in Jan 2020.

WITH sbc_sales AS (
    SELECT sub_category, FORMAT(order_date, 'yyyyMM') AS year_month, SUM(sales) AS sales
    FROM Orders
    GROUP BY sub_category, FORMAT(order_date, 'yyyyMM')
),
prev_month_sales AS (
    SELECT *,
    LAG(sales) OVER (PARTITION BY sub_category ORDER BY year_month) AS prev_sales
    FROM sbc_sales
)
SELECT TOP 1 *, (sales - prev_sales) / prev_sales AS mom_growth
FROM prev_month_sales
WHERE year_month = '202001'
ORDER BY mom_growth DESC;

-- 4. Write a query to print the top 3 products in each category by year-over-year sales growth in the year 2020.

WITH cat_sales AS (
    SELECT category, product_id, DATEPART(year, order_date) AS order_year, SUM(sales) AS sales
    FROM Orders
    GROUP BY category, product_id, DATEPART(year, order_date)
),
prev_year_sales AS (
    SELECT *,
    LAG(sales) OVER (PARTITION BY category ORDER BY order_year) AS prev_year_sales
    FROM cat_sales
),
rnk AS (
    SELECT *, RANK() OVER (PARTITION BY category ORDER BY (sales - prev_year_sales) / prev_year_sales DESC) AS rn
    FROM prev_year_sales
    WHERE order_year = '2020'
)
SELECT *
FROM rnk
WHERE rn <= 3;

-- 5. Create two tables and write a query to get the start time and end time of each call from the tables.
--    Also, create a column for call duration in minutes.

CREATE TABLE call_start_logs (
    phone_number VARCHAR(10),
    start_time DATETIME
);

INSERT INTO call_start_logs VALUES
    ('PN1', '2022-01-01 10:20:00'),
    ('PN1', '2022-01-01 16:25:00'),
    ('PN2', '2022-01-01 12:30:00'),
    ('PN3', '2022-01-02 10:00:00'),
    ('PN3', '2022-01-02 12:30:00'),
    ('PN3', '2022-01-03 09:20:00');

CREATE TABLE call_end_logs (
    phone_number VARCHAR(10),
    end_time DATETIME
);

INSERT INTO call_end_logs VALUES
    ('PN1', '2022-01-01 10:45:00'),
    ('PN1', '2022-01-01 17:05:00'),
    ('PN2', '2022-01-01 12:55:00'),
    ('PN3', '2022-01-02 10:20:00'),
    ('PN3', '2022-01-02 12:50:00'),
    ('PN3', '2022-01-03 09:40:00');

-- Query to get call details and call duration in minutes.

SELECT s.phone_number, s.rn, s.start_time, e.end_time, DATEDIFF(MINUTE, start_time, end_time) AS duration
FROM (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY phone_number ORDER BY start_time) AS rn
    FROM call_start_logs
) s
INNER JOIN (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY phone_number ORDER BY end_time) AS rn
    FROM call_end_logs
) e ON s.phone_number = e.phone_number AND s.rn = e.rn;
