USE [DWH-OnlineShop]

INSERT INTO [Cubes].[dbo].[DimRetourengrund](Grund, Wert, Anzahl)

select
	r.returnReason "Grund",
	SUM(CAST(line_amount as decimal (10,2))) "Wert",
	COUNT(*) "Anzahl"
from
	iw_return_line r
where
	type = 2
group by
	r.returnReason

select * from [Cubes].[dbo].[DimRetourengrund]
