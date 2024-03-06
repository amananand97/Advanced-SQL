-- Q. Write a sql to find the total number of people present inside the hospital

-- Create table and enter data
create table hospital ( emp_id int
, action varchar(10)
, time datetime);

insert into hospital values ('1', 'in', '2019-12-22 09:00:00');
insert into hospital values ('1', 'out', '2019-12-22 09:15:00');
insert into hospital values ('2', 'in', '2019-12-22 09:00:00');
insert into hospital values ('2', 'out', '2019-12-22 09:15:00');
insert into hospital values ('2', 'in', '2019-12-22 09:30:00');
insert into hospital values ('3', 'out', '2019-12-22 09:00:00');
insert into hospital values ('3', 'in', '2019-12-22 09:15:00');
insert into hospital values ('3', 'out', '2019-12-22 09:30:00');
insert into hospital values ('3', 'in', '2019-12-22 09:45:00');
insert into hospital values ('4', 'in', '2019-12-22 09:45:00');
insert into hospital values ('5', 'out', '2019-12-22 09:40:00');


-- Solution
-- Method 1
with cte as(
select emp_id
, max(case when action = 'in' then time end) as intime
, max(case when action = 'out' then time end) as outtime
from hospital
group by emp_id
having max(case when action = 'in' then time end) > max(case when action = 'out' then time end) or
max(case when action = 'out' then time end) is null 
)
select * 
from cte
where intime > outtime or outtime is null

-- Method 2
with intime as
(select emp_id, max(time) as latest_in_time 
from hospital
where action = 'in'
group by emp_id
),
outtime as
(select emp_id, max(time) as latest_out_time 
from hospital
where action = 'out'
group by emp_id)
select * from
intime
left join outtime on intime.emp_id=outtime.emp_id
where latest_in_time > latest_out_time or latest_out_time is null


-- Method 3
With latest_time as (
select emp_id, max(time) as max_latest_time from hospital group by emp_id)
, latest_in_time as (select emp_id, max(time) as max_in_time from hospital 
where action = 'in'
group by emp_id)
select *
from latest_time lt
inner join latest_in_time lit on lt.emp_id= lit.emp_id and max_latest_time=max_in_time