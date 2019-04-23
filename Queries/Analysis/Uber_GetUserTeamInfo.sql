--Get number of teams per user
select user_name, team_name, COUNT(*)
from uber.dbo.vehicletestdata
group by user_name, team_name
order by user_name

--Get most recent team 
select user_name, team_name
from
(
select ROW_NUMBER() OVER(PARTITION BY user_name ORDER BY end_time desc) RN, user_name, team_name
from uber.dbo.vehicletestdata
) A
WHERE a.rn = 1