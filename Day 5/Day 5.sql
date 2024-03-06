-- DAY 5

USE SQL_training

-- DATABASE JOINS

-- INNER JOIN
SELECT o.order_id, o.order_date, r.[Return Reason]
FROM Orders o
INNER JOIN returns r ON o.order_id = r.[Order Id]

-- LEFT JOIN
SELECT o.order_id, o.product_id, r.[Return Reason]
FROM Orders o
LEFT JOIN returns r ON o.order_id = r.[Order Id]

SELECT r.[Return Reason], SUM(sales) AS total_sales
FROM Orders o
LEFT JOIN returns r ON o.order_id = r.[Order Id]
GROUP BY r.[Return Reason]

-- NEW TABLE
CREATE TABLE employee(
    emp_id INT,
    emp_name VARCHAR(20),
    dept_id INT,
    salary INT,
    manager_id INT,
    emp_age INT
);

INSERT INTO employee VALUES
(1, 'Ankit', 100, 10000, 4, 39),
(2, 'Mohit', 100, 15000, 5, 48),
(3, 'Vikas', 100, 10000, 4, 37),
(4, 'Rohit', 100, 5000, 2, 16),
(5, 'Mudit', 200, 12000, 6, 55),
(6, 'Agam', 200, 12000, 2, 14),
(7, 'Sanjay', 200, 9000, 2, 13),
(8, 'Ashish', 200, 5000, 2, 12),
(9, 'Mukesh', 300, 6000, 6, 51),
(10, 'Rakesh', 500, 7000, 6, 50);

CREATE TABLE dept(
    dep_id INT,
    dep_name VARCHAR(20)
);

INSERT INTO dept VALUES
(100, 'Analytics'),
(200, 'IT'),
(300, 'HR'),
(400, 'Text Analytics');

-- CROSS JOIN
SELECT *
FROM employee
INNER JOIN dept ON 1=1 -- This would be true in every case
ORDER BY employee.emp_id

-- INNER JOIN
SELECT e.emp_id, e.emp_name, d.dep_id, d.dep_name
FROM employee e
INNER JOIN dept d ON e.dept_id = d.dep_id

-- LEFT JOIN
SELECT e.emp_id, e.emp_name, d.dep_id, d.dep_name
FROM employee e
LEFT JOIN dept d ON e.dept_id = d.dep_id

-- RIGHT JOIN (Instead of this, swap the table names and use left join)
SELECT e.emp_id, e.emp_name, d.dep_id, d.dep_name
FROM dept d
LEFT JOIN employee e ON d.dep_id = e.dept_id

-- FULL OUTER JOIN
SELECT e.emp_id, e.emp_name, d.dep_id, d.dep_name
FROM employee e
FULL OUTER JOIN dept d ON e.dept_id = d.dep_id

CREATE TABLE people
(
    manager VARCHAR(20),
    region VARCHAR(10)
)

INSERT INTO people 
VALUES ('Ankit', 'West'),
       ('Deepak', 'East'),
       ('Vishal', 'Central'),
       ('Sanjay', 'South')

SELECT * FROM people

SELECT o.order_id, o.product_id, r.[Return Reason], p.manager 
FROM Orders o
INNER JOIN returns r ON o.order_id = r.[Order Id]
INNER JOIN people p ON p.region = o.region
