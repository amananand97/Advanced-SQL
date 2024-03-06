-- DAY 2

-- Create a table named amazon_orders
CREATE TABLE amazon_orders
(
    order_id INTEGER,
    order_date DATE,
    product_name VARCHAR(100),
    total_price DECIMAL(6,2),
    payment_method VARCHAR(20)
);

-- Retrieve all records from the amazon_orders table.
SELECT * FROM amazon_orders;

-- Change the data type of the order_date column to datetime (DDL).
ALTER TABLE amazon_orders ALTER COLUMN order_date DATETIME;
-- Change the data type of the order_id column to date (DDL); data types should be compatible.
ALTER TABLE amazon_orders ALTER COLUMN order_id DATE;
-- Change the data type of the product_name column to varchar(20) (DDL); data types should be compatible.
ALTER TABLE amazon_orders ALTER COLUMN product_name VARCHAR(20);
-- Change the data type of the order_date column to datetime (DDL); data types should be compatible.
ALTER TABLE amazon_orders ALTER COLUMN order_date DATETIME;
-- If the table is empty, you can change from any data type to any other data type.

-- Insert a new record into the amazon_orders table.
INSERT INTO amazon_orders VALUES (5, '2022-10-01 12:05:12', 'Shoes', 132.5, 'UPI');
-- Insert a new record into the amazon_orders table; incorrect date format.
-- INSERT INTO amazon_orders VALUES (5, '10-10-2022 12:05:12', 'Shoes', 132.5, 'UPI', 'ANKIT');
-- Insert a new record into the amazon_orders table with a null product_name.
INSERT INTO amazon_orders VALUES (6, '2022-10-01 12:05:12', NULL, 132.5, 'UPI', 'Ankit');
-- Insert a new record into the amazon_orders table with a product_name of 'null'.
INSERT INTO amazon_orders VALUES (7, '2022-10-01 12:05:12', 'null', 132.5, 'UPI', 'Ankit');

-- Add a username column to the existing table amazon_orders.
ALTER TABLE amazon_orders ADD username VARCHAR(20);
-- Add a category column to the existing table amazon_orders.
ALTER TABLE amazon_orders ADD category VARCHAR(20);

-- Delete the category column from the amazon_orders table.
ALTER TABLE amazon_orders DROP COLUMN category;

-- Constraints

-- Drop the table a_orders if it exists.
DROP TABLE IF EXISTS a_orders;

-- Create a table named a_orders with various constraints.
CREATE TABLE a_orders
(
    order_id INTEGER, -- Not null constraint, unique constraint
    order_date DATE,
    product_name VARCHAR(100),
    total_price DECIMAL(6,2),
    payment_method VARCHAR(20) CHECK (payment_method IN ('UPI', 'CREDIT CARD')) DEFAULT 'UPI', -- Check constraint
    discount INTEGER CHECK (discount <= 20), -- Check constraint
    category VARCHAR(20) DEFAULT 'Mens Wear', -- Default constraint
    PRIMARY KEY (order_id, product_name)
);

-- Insert records into the a_orders table.
INSERT INTO a_orders VALUES (1, '2022-10-01', 'Shirts', 132.5, 'UPI', 20, 'kids wear');
SELECT * FROM a_orders;

INSERT INTO a_orders VALUES (3, '2022-10-01', 'Shirts', 132.5, 'UPI', 20, '');
INSERT INTO a_orders (order_id, order_date, product_name, total_price, payment_method) VALUES (7, '2022-10-01', 'Shirts', 132.5, 'UPI');
INSERT INTO a_orders (order_id, order_date, product_name, total_price, payment_method) VALUES (NULL, '2022-10-01', 'Shirts', 132.5, DEFAULT);

SELECT * FROM a_orders;

-- Insert records into the a_orders table.
INSERT INTO a_orders (order_id, order_date, product_name, total_price, payment_method) VALUES (1, '2022-10-01', 'Shirts', 132.5, DEFAULT);
INSERT INTO a_orders (order_id, order_date, product_name, total_price, payment_method) VALUES (2, '2022-10-01', 'jeans', 132.5, DEFAULT);

-- Primary key is a combination of unique and not null constraints.

-- Delete records with a filter condition.
DELETE FROM a_orders WHERE product_name = 'jeans'; -- DML

-- Update records (DML)
-- Update discount for all records in the a_orders table.
UPDATE a_orders
SET discount = 10;

-- Update discount for a specific record where order_id is 2.
UPDATE a_orders
SET discount = 10
WHERE order_id = 2;

-- Update product_name and payment_method for records with product_name 'jeans'.
UPDATE a_orders
SET product_name = 'jeans2', payment_method = 'CREDIT CARD'
WHERE product_name = 'jeans';

-- Retrieve all records from the a_orders table.
SELECT * FROM a_orders;
