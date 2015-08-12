INSERT INTO [Cubes].[dbo].[DimNewsletter](Newsletter, Anzahl)
Values
(
select
	CAST(c.newsletter as bit) "Newsletter",
	COUNT(*) "Anzahl"
from
	iw_customer c
group by c.newsletter
)

select * from [Cubes].[dbo].[DimNewsletter]
