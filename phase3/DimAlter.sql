use [DWH-OnlineShop]

delete from [Cubes].[dbo].[DimAlter]

insert into [Cubes].[dbo].[DimAlter] (Bezeichnung, Anzahl)
select
	case
		when datediff(yy, c.birthdate, current_timestamp) < 20 then '<20'
		when datediff(yy, c.birthdate, current_timestamp) between 20 and 29 then '>=20 & < 30'
		when datediff(yy, c.birthdate, current_timestamp) between 30 and 39 then '>=30 & < 40'
		when datediff(yy, c.birthdate, current_timestamp) between 40 and 49 then '>=40 & < 50'
		when datediff(yy, c.birthdate, current_timestamp) between 50 and 59 then '>=50 & < 60'
		when datediff(yy, c.birthdate, current_timestamp) between 60 and 89 then '>=60 & < 90'
		when datediff(yy, c.birthdate, current_timestamp) >= 90 then '>=90'
	end as 'Altersgruppe',
	count(c.RiskID) 'Anzahl'
from
	iw_customer c
group by
	case
		when datediff(yy, c.birthdate, current_timestamp) < 20 then '<20'
		when datediff(yy, c.birthdate, current_timestamp) between 20 and 29 then '>=20 & < 30'
		when datediff(yy, c.birthdate, current_timestamp) between 30 and 39 then '>=30 & < 40'
		when datediff(yy, c.birthdate, current_timestamp) between 40 and 49 then '>=40 & < 50'
		when datediff(yy, c.birthdate, current_timestamp) between 50 and 59 then '>=50 & < 60'
		when datediff(yy, c.birthdate, current_timestamp) between 60 and 89 then '>=60 & < 90'
		when datediff(yy, c.birthdate, current_timestamp) >= 90 then '>=90'
	end

select * from [Cubes].[dbo].[DimAlter]
