-- DAY 1

-- Create Table (DDL)
CREATE TABLE amazon_orders
(
    order_id INT,
    order_date DATE,
    product_name VARCHAR(20),
    total_price DECIMAL(5,2), -- Decimal(5,2) represents values like 123.45
    payment_method VARCHAR(10)
);

-- Store Data (DML)
INSERT INTO amazon_orders VALUES (1, '2022-10-01', 'Baby Milk', 30.5, 'UPI');
INSERT INTO amazon_orders VALUES (2, '2022-10-02', 'Baby Powder', 130.5, 'CC');
INSERT INTO amazon_orders VALUES (3, '2022-10-01', 'Baby Soap', 30.5, 'UPI');
INSERT INTO amazon_orders VALUES (4, '2022-10-02', 'Baby Cream', 130.5, 'CC');

-- Display the Data (DQL) - Data Querying Language
SELECT * FROM amazon_orders;
-- Retrieve the top 2 records from the amazon_orders table.
SELECT TOP 2 * FROM amazon_orders;

-- Deleting a Table (DDL)
DROP TABLE amazon_orders;

-- Deleting the Data (DML)
-- The following DELETE statement deletes all records from the amazon_orders table.
DELETE FROM amazon_orders;

-- Displaying data from the 'Orders' table (assuming you want to display data from a different table called 'Orders').
SELECT * FROM Orders;
