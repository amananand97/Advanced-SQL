/*
Find the room types which are searched most of the times.
Output the room type alongside the number of searches for it.
If the filter for room type has more than one room type,
consider each unique room type as a separate row.
Sort the result based on the number of searches in descending order.
*/

create table airbnb_searches 
(
user_id int,
date_searched date,
filter_room_types varchar(200)
);

delete from airbnb_searches;
insert into airbnb_searches values
(1,'2022-01-01','entire home,private room')
,(2,'2022-01-02','entire home,shared room')
,(3,'2022-01-02','private room,shared room')
,(4,'2022-01-03','private room');

-- SOLUTION
-- Selecting all columns from the airbnb_searches table
select * from airbnb_searches;

-- Hard coding a string and splitting it into individual values
select value from string_split('entire home, private rooms', ',');  -- Hard coded

-- Counting the number of searches for each room type after splitting the filter_room_types column
select 
    value as room_type, 
    count(1) as no_of_searches 
from 
    airbnb_searches
CROSS APPLY 
    string_split(filter_room_types, ',') -- Splitting the filter_room_types column by comma
group by 
    value -- Grouping by the individual values obtained from splitting
order by 
    no_of_searches desc; -- Ordering the results by the number of searches in descending order
