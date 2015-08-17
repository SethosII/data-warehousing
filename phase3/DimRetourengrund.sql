use [DWH-OnlineShop]

delete [Cubes].[dbo].[DimRetourengrund]

insert into [Cubes].[dbo].[DimRetourengrund] (Grund, Wert, Anzahl)

select
	r.returnReason 'Grund',
	sum(cast(line_amount as decimal (10,2))) 'Wert',
	count(*) 'Anzahl'
from
	iw_return_line r
where
	type = 2
group by
	r.returnReason

select * from [Cubes].[dbo].[DimRetourengrund]
