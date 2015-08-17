use [DWH-OnlineShop]

delete [Cubes].[dbo].[DimNewsletter]

insert into [Cubes].[dbo].[DimNewsletter] (Newsletter, Anzahl)

select
	cast(c.newsletter as bit) 'Newsletter',
	count(*) 'Anzahl'
from
	iw_customer c
group by
	c.newsletter

select * from [Cubes].[dbo].[DimNewsletter]
