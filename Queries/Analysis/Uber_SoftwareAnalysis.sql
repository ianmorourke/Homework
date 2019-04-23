select *
from uber.dbo.vehicletestdata
where start_time > end_time
or end_time is null

--all 5 missing end_times occurred on parked. is that valid?
update uber.dbo.vehicletestdata
set end_time = null
where end_time = '1899-12-30 00:00:00.000'

--get activity count for each vehicle and software type
select vehicle_alias, software, count(*) [ActivityCount]
from uber.dbo.vehicletestdata
group by vehicle_alias, software
order by ActivityCount desc