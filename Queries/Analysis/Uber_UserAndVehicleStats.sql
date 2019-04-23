--Get user activity per vehicle count
select user_name, count(*) [Activities]
from uber.dbo.vehicletestdata
group by user_name
order by Activities desc
--Alexander Hamilton - 1084
--Peter Rasputin - 1

--Get full table of a user's activities and length in seconds
select user_name, start_time, end_time, datediff(second, start_time, end_time) [ActivitySeconds]
from uber.dbo.vehicletestdata
where vehicle_activity = 'manual' 
OR vehicle_activity = 'autonomous'
--and user_name = 'cosmo.kramer'
group by user_name, start_time, end_time
order by user_name

--Get user's average activity time
select user_name, vehicle_activity, avg(datediff(second, start_time, end_time)) [Averagetime]
from uber.dbo.vehicletestdata
where (vehicle_activity = 'manual' OR vehicle_activity = 'autonomous')
group by user_name, vehicle_activity
order by averagetime desc, user_name
--Jean Grey - 304 second average activity time
--Overall average - 64 seconds

--Get uses of software per vehicle
select vehicle_alias, software, count(*)
from uber.dbo.vehicletestdata
group by vehicle_alias, software
order by vehicle_alias

--Get user total minutes to compare to total activities
select user_name, SUM(DATEDIFF(second, start_time, end_time)) [TotalActivityTime]
from uber.dbo.vehicletestdata
group by user_name
order by TotalActivityTime desc

--Get user time distributions - order by most short activities
select user_name,
	SUM(CASE WHEN DATEDIFF(second, start_time, end_time) < 10 THEN 1 ELSE 0 END) as 'x<10',
	SUM(CASE WHEN DATEDIFF(second, start_time, end_time) >= 10 AND DATEDIFF(second, start_time, end_time) < 30 THEN 1 ELSE 0 END) '10<=x<30',
	SUM(CASE WHEN DATEDIFF(second, start_time, end_time) >= 30 AND DATEDIFF(second, start_time, end_time) < 60 THEN 1 ELSE 0 END) '30<x<60',
	SUM(CASE WHEN DATEDIFF(second, start_time, end_time) >= 60 AND DATEDIFF(second, start_time, end_time) < 120 THEN 1 ELSE 0 END) '60<x<120',
	SUM(CASE WHEN DATEDIFF(second, start_time, end_time) >= 120 THEN 1 ELSE 0 END) 'x>120'
from uber.dbo.vehicletestdata
group by user_name
order by 'x<10' desc

--Order by most long activities
select user_name,
	SUM(CASE WHEN DATEDIFF(second, start_time, end_time) < 10 THEN 1 ELSE 0 END) as 'x<10',
	SUM(CASE WHEN DATEDIFF(second, start_time, end_time) >= 10 AND DATEDIFF(second, start_time, end_time) < 30 THEN 1 ELSE 0 END) '10<=x<30',
	SUM(CASE WHEN DATEDIFF(second, start_time, end_time) >= 30 AND DATEDIFF(second, start_time, end_time) < 60 THEN 1 ELSE 0 END) '30<x<60',
	SUM(CASE WHEN DATEDIFF(second, start_time, end_time) >= 60 AND DATEDIFF(second, start_time, end_time) < 120 THEN 1 ELSE 0 END) '60<x<120',
	SUM(CASE WHEN DATEDIFF(second, start_time, end_time) >= 120 THEN 1 ELSE 0 END) 'x>120'
from uber.dbo.vehicletestdata
group by user_name
order by 'x>120' desc

--Get overall average vehicle activity time
select avg(datediff(second, start_time, end_time))
from uber.dbo.vehicletestdata

--Review sample of data
select *
from uber.dbo.vehicletestdata
where user_name = 'jean.grey'
and vehicle_activity = 'manual'

--Get vehicle total minutes to compare to total activities
select vehicle_alias, SUM(DATEDIFF(minute, start_time, end_time)) [TotalActivityTime]
from uber.dbo.vehicletestdata
group by vehicle_alias
order by TotalActivityTime desc
