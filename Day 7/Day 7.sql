-- DAY 7
USE SQL_training

-- STRING FUNCTIONS

-- Calculate the length of customer names, excluding trailing spaces
SELECT
    order_id,
    customer_name,
    LEN(customer_name) AS len_name,
    LEFT(customer_name, 4) AS name_4,
    RIGHT(customer_name, 4),
    SUBSTRING(order_id, 4, 4) AS sub_tr45,
    CHARINDEX(' ', customer_name) AS space_position,
    CONCAT(order_id, ' ', customer_name),
    REPLACE(order_id, 'CA', 'PB') AS CA_to_PB,
    TRANSLATE(customer_name, 'AG', 'TP') AS Translate_AG -- Replace 'A' with 'T' and 'G' with 'P'
FROM Orders

-- NULL handling functions
SELECT
    order_id,
    city
FROM Orders
WHERE city IS NULL

SELECT
    order_id,
    city,
    ISNULL(city, 'Unknown') AS New_city,
    state,
    COALESCE(city, state, region, 'Unknown') AS neww_city -- Default is 'Unknown' here
FROM Orders
ORDER BY city
WHERE city IS NULL

SELECT TOP 5
    order_id,
    sales,
    CAST(sales AS INT) AS sales_int,
    ROUND(sales, 1) AS rounded_sales
FROM Orders

-- SET FUNCTIONS/QUERIES

-- Union and union all

SELECT * FROM Orders

-- Create tables for orders in the west and east regions
CREATE TABLE orders_west
(
    order_id INT,
    region VARCHAR(10),
    sales INT
);

CREATE TABLE orders_east
(
    order_id INT,
    region VARCHAR(10),
    sales INT
);

-- Insert sample data into the west and east tables
INSERT INTO orders_west VALUES (1, 'west', 100), (2, 'west', 200);
INSERT INTO orders_east VALUES (3, 'east', 300), (4, 'east', 400);
INSERT INTO orders_west VALUES (3, 'east', 300), (4, 'east', 400);

-- Union all will combine all rows from both tables, preserving duplicates
SELECT * FROM orders_west
UNION ALL
SELECT * FROM orders_east

-- INTERSECT to find common records in the tables
SELECT * FROM orders_west
INTERSECT
SELECT * FROM orders_east

-- EXCEPT to find records in orders_east that are not in orders_west
SELECT * FROM orders_east
EXCEPT
SELECT * FROM orders_west

-- EXCEPT to find records in orders_west that are not in orders_east
SELECT * FROM orders_west
EXCEPT
SELECT * FROM orders_east
UNION ALL
(
    -- Combine results of EXCEPT for orders_west and orders_east
    SELECT * FROM orders_west
    EXCEPT
    SELECT * FROM orders_east
)
