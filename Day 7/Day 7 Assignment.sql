-- DAY 7 ASSIGNMENT

USE SQL_training

-- Creating a table
CREATE TABLE icc_world_cup
(
    Team_1 Varchar(20),
    Team_2 Varchar(20),
    Winner Varchar(20)
);

INSERT INTO icc_world_cup VALUES
('India', 'SL', 'India'),
('SL', 'Aus', 'Aus'),
('SA', 'Eng', 'Eng'),
('Eng', 'NZ', 'NZ'),
('Aus', 'India', 'India');

-- Display the table
SELECT * FROM icc_world_cup

-- Query 1
/*
Write a query to produce the following output from the icc_world_cup table:
team_name, no_of_matches_played, no_of_wins, no_of_losses
*/

-- APPROACH 1
SELECT
    team AS Team_name,
    COUNT(*) AS no_of_matches_played,
    SUM(CASE WHEN team = Winner THEN 1 ELSE 0 END) AS no_of_wins,
    SUM(CASE WHEN team <> Winner THEN 1 ELSE 0 END) AS no_of_losses
FROM (
    SELECT Team_1 AS team, Winner FROM icc_world_cup
    UNION ALL
    SELECT Team_2 AS team, Winner FROM icc_world_cup
) AS Combined_Data
GROUP BY team;

-- APPROACH 2
WITH all_teams AS (
    SELECT Team_1 AS team, CASE WHEN Team_1 = Winner THEN 1 ELSE 0 END AS win_flag FROM icc_world_cup
    UNION ALL
    SELECT Team_2 AS team, CASE WHEN Team_2 = Winner THEN 1 ELSE 0 END AS win_flag FROM icc_world_cup
)
SELECT
    team,
    COUNT(1) AS total_matches_played,
    SUM(win_flag) AS matches_won,
    COUNT(1) - SUM(win_flag) AS matches_lost
FROM all_teams
GROUP BY team

-- Query 2
/*
Write a query to print the first name and last name of a customer using the Orders table.
(Everything after the first space can be considered as the last name)
customer_name, first_name, last_name
*/

-- APPROACH 1
SELECT
    customer_name,
    TRIM(SUBSTRING(customer_name, 1, CHARINDEX(' ', customer_name)) AS First_name,
    SUBSTRING(customer_name, CHARINDEX(' ', customer_name) + 1, LEN(customer_name) - CHARINDEX(' ', customer_name) + 1) AS Second_name
FROM Orders

-- APPROACH 2
SELECT
    customer_name,
    CASE
        WHEN CHARINDEX(' ', customer_name) > 0
        THEN LEFT(customer_name, CHARINDEX(' ', customer_name) - 1)
        ELSE customer_name
    END AS First_name,
    CASE
        WHEN CHARINDEX(' ', customer_name) > 0
        THEN SUBSTRING(customer_name, CHARINDEX(' ', customer_name) + 1, LEN(customer_name) - CHARINDEX(' ', customer_name) + 1)
        ELSE ''
    END AS Second_name
FROM Orders

-- Create table drivers
CREATE TABLE drivers(id VARCHAR(10), start_time TIME, end_time TIME, start_loc VARCHAR(10), end_loc VARCHAR(10));

INSERT INTO drivers VALUES
('dri_1', '09:00', '09:30', 'a', 'b'),
('dri_1', '09:30', '10:30', 'b', 'c'),
('dri_1', '11:00', '11:30', 'd', 'e'),
('dri_1', '12:00', '12:30', 'f', 'g'),
('dri_1', '13:30', '14:30', 'c', 'h'),
('dri_2', '12:15', '12:30', 'f', 'g'),
('dri_2', '13:30', '14:30', 'c', 'h');

-- Query 3
/*
Write a query to print the following output using the drivers table.
Profit rides are the number of rides where the end location of a ride is the same as the start location of the immediate next ride for a driver.
id, total_rides, profit_rides
*/

-- APPROACH 1 (Lead function window)
SELECT
    id,
    COUNT(1) AS total_rides,
    SUM(CASE WHEN end_loc = next_start_location THEN 1 ELSE 0 END) AS profit_rides
FROM (
    SELECT *, LEAD(start_loc, 1) OVER (PARTITION BY id ORDER BY start_time ASC) AS next_start_location
    FROM drivers
) A
GROUP BY id

-- APPROACH 2 (Self Join)
SELECT
    d1.id AS driver_id,
    COUNT(1) AS total_rides,
    COUNT(d2.id) AS profit_rides
FROM drivers d1
LEFT JOIN drivers d2 ON d1.id = d2.id AND d1.end_loc = d2.start_loc AND d1.end_time = d2.start_time
GROUP BY d1.id

-- Query 4
/*
Write a query to print the customer name and the number of occurrences of the character 'n' in the customer name.
customer_name, count_of_occurrence_of_n
*/

SELECT
    customer_name,
    LEN(customer_name) - LEN(REPLACE(LOWER(customer_name), 'n', '')) AS count_of_occurrence_of_n
FROM Orders

-- Query 5
/*
Write a query to print the following output from the Orders data.
Hierarchy type, hierarchy name, total_sales_in_west_region, total_sales_in_east_region
*/

-- Column name is only considered from the first query, and we can remove the aliases from the other queries
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

SELECT category, sub_category, ship_mode, 
    SUM(CASE WHEN region='West' THEN sales END) AS total_sales_west_region,
    SUM(CASE WHEN region='East' THEN sales END) AS total_sales_east_region
FROM Orders
GROUP BY category, sub_category, ship_mode

-- Query 6
/*
The first 2 characters of order_id represent the country of the order placed. 
Write a query to print the total number of orders placed in each country.
(An order can have 2 rows in the data when more than 1 item was purchased in the order but it should be considered as 1 order)
*/

SELECT LEFT(order_id, 2) AS Country, COUNT(DISTINCT order_id) AS Total_orders
FROM Orders
GROUP BY LEFT(order_id, 2)
