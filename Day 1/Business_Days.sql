/*Q. Wrte a sql to find the business days between create date and resolved date by excluding 
weekends and public holidays */

-- Create Table and Data
create table tickets
(
ticket_id varchar(10),
create_date date,
resolved_date date
);
delete from tickets;
insert into tickets values
(1,'2022-08-01','2022-08-03')
,(2,'2022-08-01','2022-08-12')
,(3,'2022-08-01','2022-08-16');
create table holidays
(
holiday_date date
,reason varchar(100)
);
delete from holidays;
insert into holidays values
('2022-08-11','Rakhi'),('2022-08-15','Independence day');

-- Solution

Select * 
, DATEDIFF(DAY, create_date, resolved_date) as actual_days
, DATEDIFF(DAY, create_date, resolved_date) - 2*DATEDIFF(WEEK, create_date, resolved_date) as business_days
from tickets

select * 
, DATEDIFF(DAY, create_date, resolved_date) - 2*DATEDIFF(WEEK, create_date, resolved_date) - no_of_holidays as business_days
from (
select ticket_id, create_date, resolved_date, count(holiday_date) as no_of_holidays
from tickets
left join holidays on holiday_date between create_date and resolved_date
group by ticket_id, create_date, resolved_date) A