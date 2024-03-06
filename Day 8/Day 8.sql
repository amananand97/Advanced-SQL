-- DAY 8

-- VIEWS or Virtual Tables

-- Select all records from the Orders table
SELECT * FROM Orders

-- Create a view called orders_vw, which is a virtual table with the same data as the Orders table
CREATE VIEW orders_vw AS
SELECT * FROM Orders

-- Select all records from the orders_vw view
SELECT * FROM orders_vw

-- Create a view called orders_summary_vw, which provides a summary of sales data by category, sub-category, and ship mode
CREATE VIEW orders_summary_vw AS
SELECT 'Category' AS Hierarchy_Type, category AS Hierarchy_Name,
    SUM(CASE WHEN region='West' THEN sales END) AS total_sales_west_region,
    SUM(CASE WHEN region='East' THEN sales END) AS total_sales_east_region
FROM Orders
GROUP BY category
UNION ALL
SELECT 'Sub-Category', sub_category,
    SUM(CASE WHEN region='West' THEN sales END),
    SUM(CASE WHEN region='East' THEN sales END)
FROM Orders
GROUP BY sub_category
UNION ALL
SELECT 'Ship-Mode', ship_mode,
    SUM(CASE WHEN region='West' THEN sales END),
    SUM(CASE WHEN region='East' THEN sales END)
FROM Orders
GROUP BY ship_mode

-- Select all records from the orders_summary_vw view
SELECT * FROM orders_summary_vw

-- Select all records from the Orders table
SELECT * FROM Orders

-- Create a view called orders_south_vw, which contains data only for the 'South' region
CREATE VIEW orders_south_vw AS
SELECT * FROM Orders
WHERE region = 'South'

-- Select all records from the orders_south_vw view, showing data only for the 'South' region
SELECT * FROM orders_south_vw

-- Referential Integrity Constraint

-- Select all records from the employee table and dept table
SELECT * FROM employee;
SELECT * FROM dept

-- Create a table named emp with a foreign key reference to the dept table
CREATE TABLE emp
(
    emp_id INT,
    emp_name VARCHAR(10),
    dept_id INT REFERENCES dept (dep_id)
)

-- Insert data into the emp table, including an attempt to insert a value that violates the foreign key constraint
INSERT INTO emp VALUES (1, 'Ankit', 100)
INSERT INTO emp VALUES (1, 'Sharma', 500) -- FK Constraint error
INSERT INTO emp VALUES (1, 'Sharma', NULL)

-- Alter the dept table to make the dep_id column NOT NULL
ALTER TABLE dept ALTER COLUMN dep_id INT NOT NULL

-- Add a primary key constraint on the dep_id column in the dept table
ALTER TABLE dept ADD CONSTRAINT primary_key PRIMARY KEY (dep_id)

-- Identity

-- Create a table named dept1 with an identity column
CREATE TABLE dept1
(
    id INT IDENTITY(1, 1), -- Starting and increment
    dep_id INT,
    dep_name VARCHAR(10)
)

-- Insert data into the dept1 table, where the id column is auto-generated
INSERT INTO dept1(dep_id, dep_name) VALUES (100, 'HR');
INSERT INTO dept1(dep_id, dep_name) VALUES (200, 'Analytics');

-- Select all records from the dept1 table
SELECT * FROM dept1
