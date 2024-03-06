-- DAY 3

-- SELECT Statements

-- Retrieve all columns from the Orders table.
SELECT *
FROM Orders;

-- Retrieve the top 5 Order_ID and Order_Date records from the Orders table, ordered by Order_Date.
SELECT TOP 5 order_id, order_date
FROM Orders
ORDER BY order_date;

-- Retrieve distinct values in the Ship_Mode column from the Orders table.
SELECT DISTINCT ship_mode
FROM Orders;

-- Retrieve distinct values in the Ship_Mode and Segment columns from the Orders table.
SELECT DISTINCT ship_mode, segment
FROM Orders;

-- Incorrect usage of DISTINCT; remove it.
SELECT *
FROM Orders;

---- Filters -----

-- Retrieve all columns from the Orders table where Ship_Mode is 'First Class'.
SELECT *
FROM Orders
WHERE ship_mode = 'First Class';

-- Retrieve all columns from the Orders table where Order_Date is '2020-12-08'.
SELECT *
FROM Orders
WHERE order_date = '2020-12-08';

-- Retrieve all columns from the Orders table where Quantity is 5.
SELECT *
FROM Orders
WHERE quantity = 5;

-- Retrieve all columns from the Orders table where Quantity is greater than or equal to 5.
SELECT *
FROM Orders
WHERE quantity >= 5;

-- Retrieve all columns from the Orders table where Quantity is 5.
SELECT *
FROM Orders
WHERE quantity = 5;

-- Retrieve the top 5 Order_Date and Quantity records from the Orders table where Quantity is 5, ordered by Order_Date.
SELECT TOP 5 order_date, quantity
FROM Orders
WHERE quantity = 5
ORDER BY order_date;

-- Retrieve Order_Date and Quantity from the Orders table where Quantity is not 5, ordered by Quantity in descending order.
SELECT order_date, quantity
FROM Orders
WHERE quantity != 5
ORDER BY quantity DESC;

-- Retrieve all columns from the Orders table where Order_Date is earlier than '2020-12-08', ordered by Order_Date in descending order.
SELECT *
FROM Orders
WHERE order_date < '2020-12-08'
ORDER BY order_date DESC;

-- Retrieve all columns from the Orders table where Order_Date is between '2020-12-08' and '2020-12-10', ordered by Order_Date in descending order.
SELECT *
FROM Orders
WHERE order_date BETWEEN '2020-12-08' AND '2020-12-10'
ORDER BY order_date DESC;

-- Retrieve all columns from the Orders table where Quantity is between 3 and 5 (including 3 and 5), ordered by Quantity in descending order.
SELECT *
FROM Orders
WHERE quantity BETWEEN 3 AND 5
ORDER BY quantity DESC;

-- Retrieve all columns from the Orders table where Ship_Mode is either 'First Class' or 'Same Day'.
SELECT *
FROM Orders
WHERE ship_mode IN ('First Class', 'Same Day');

-- To verify the above query, retrieve distinct Ship_Mode values from the Orders table where Ship_Mode is either 'First Class' or 'Same Day'.
SELECT DISTINCT ship_mode
FROM Orders
WHERE ship_mode IN ('First Class', 'Same Day');

-- Retrieve all columns from the Orders table where Quantity is 3, 4, or 5.
SELECT *
FROM Orders
WHERE quantity IN (3, 4, 5);

-- AND operator: Retrieve Order_Date, Ship_Mode, and Segment from the Orders table where Ship_Mode is 'First Class' and Segment is 'Consumer'.
SELECT order_date, ship_mode, segment
FROM Orders
WHERE ship_mode = 'First Class' AND segment = 'Consumer';

-- OR operator: Retrieve Order_Date, Ship_Mode, and Segment from the Orders table where Ship_Mode is 'First Class' or Segment is 'Consumer'.
SELECT order_date, ship_mode, segment
FROM Orders
WHERE ship_mode = 'First Class' OR segment = 'Consumer';

-- Retrieve distinct Ship_Mode values from the Orders table where Ship_Mode is either 'First Class' or 'Same Day'.
SELECT DISTINCT ship_mode
FROM Orders
WHERE ship_mode = 'First Class' OR ship_mode = 'Same Day';

-- Pattern matching using the LIKE operator with wildcards.

-- Retrieve Order_ID, Order_Date, and Customer_Name from the Orders table where Customer_Name is 'Claire Gute'.
SELECT order_id, order_date, customer_name
FROM Orders
WHERE customer_name = 'Claire Gute';

-- Retrieve Order_ID, Order_Date, and Customer_Name from the Orders table where Customer_Name starts with 'C'.
SELECT order_id, order_date, customer_name
FROM Orders
WHERE customer_name LIKE 'C%';

-- Retrieve Order_ID, Order_Date, and Customer_Name from the Orders table where Customer_Name starts with 'Chris'.
SELECT order_id, order_date, customer_name
FROM Orders
WHERE customer_name LIKE 'Chris%' 

-- Retrieve Order_ID, Order_Date, and Customer_Name from the Orders table where Customer_Name ends with 't'.
SELECT order_id, order_date, customer_name
FROM Orders
WHERE customer_name LIKE '%t';

-- Retrieve Order_ID, Order_Date, and Customer_Name from the Orders table where 'ven' appears anywhere in Customer_Name.
SELECT order_id, order_date, customer_name
FROM Orders
WHERE customer_name LIKE '%ven%';

-- Retrieve Order_ID, Order_Date, and Customer_Name from the Orders table where Customer_Name starts with 'A' and ends with 'a'.
SELECT order_id, order_date, customer_name
FROM Orders
WHERE customer_name LIKE 'A%a';

-- Retrieve Order_ID, Order_Date, and Customer_Name from the Orders table where Customer_Name starts with 'A' and ends with 'a' (case-insensitive).
SELECT order_id, order_date, customer_name, UPPER(customer_name) AS Name_upper
FROM Orders
WHERE UPPER(customer_name) LIKE 'A%A';

-- Retrieve Order_ID, Order_Date, and Customer_Name from the Orders table where Customer_Name has '_l' in the second and third positions.
SELECT order_id, order_date, customer_name
FROM Orders
WHERE customer_name LIKE '_l%';

-- Retrieve Order_ID, Order_Date, and Customer_Name from the Orders table where Customer_Name has '_l' in the second and third positions, considering '%' as an escape character.
SELECT order_id, order_date, customer_name
FROM Orders
WHERE customer_name LIKE '_l%' ESCAPE '%';

-- Retrieve Order_ID, Order_Date, and Customer_Name from the Orders table where Customer_Name has 'C' followed by either 'a', 'l', or 'o' as the second character.
SELECT order_id, order_date, customer_name
FROM Orders
WHERE customer_name LIKE 'C[alo]%';

-- Retrieve Order_ID, Order_Date, and Customer_Name from the Orders table where Customer_Name does not have 'a', 'l', or 'o' as the second character.
SELECT order_id, order_date, customer_name
FROM Orders
WHERE customer_name LIKE 'C[^alo]%';

-- Retrieve Order_ID, Order_Date, and Customer_Name from the Orders table where the second character can be any letter from 'a' to 'o'.
SELECT order_id, order_date, customer_name
FROM Orders
WHERE customer_name LIKE 'C[a-o]%'
ORDER BY customer_name;

-- Retrieve Order_ID, Order_Date, and Customer_Name from the Orders table where Order_ID starts with 'CA-20' followed by '1' or '2'.
SELECT order_id, order_date, customer_name
FROM Orders
WHERE order_id LIKE 'CA-20[1-2]%'
ORDER BY order_date;
