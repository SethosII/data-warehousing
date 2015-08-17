use [DWH-OnlineShop]

delete [Cubes].[dbo].[DimGeschlecht]

insert into [Cubes].[dbo].[DimGeschlecht] (Geschlecht, Anzahl)

select
	case
		when c.salutation = 'Herr' then 'm'
		when c.salutation = 'Frau' then 'w'
	end 'Geschlecht',
	count(c.riskID) 'Anzahl'
from
	iw_customer c
group by
	salutation

select * from  [Cubes].[dbo].[DimGeschlecht]
