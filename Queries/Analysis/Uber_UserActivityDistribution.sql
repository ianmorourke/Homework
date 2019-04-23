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