--Get records where the start time is later than the end time 
select *
from uber.dbo.vehicletestdata
where start_time > end_time
-- 4 Team D, 3 Team C, 2 Team A, 1 Team B
--2 hank mccoy, 1: hamilton, george, kramer, seabury, grey, worthington, peteman, tribbiani
--2: softwarev13, 1, 7, 2, 10

--Get user breakdown
select distinct user_name
from uber.dbo.vehicletestdata
--where user_name like '%.%'
--where user_name like '%@%'
where user_name not like '%.%' and user_name not like '%@%'
--50/54 users have first.last naming convention
--2/54 users have first@last naming convention
--2/54 users have one name

--Get null end_time values
select *
from uber.dbo.vehicletestdata
where end_time is null