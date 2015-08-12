--ID einfach rauslassen beim befüllen?

INSERT INTO [Cubes].[dbo].[DimZeit](Jahr, Quartal, Monat)
Values
(
select
	DATEPART (yyyy, CAST(s.postingDate as date)) "Jahr",
	DATEPART (qq, CAST(s.postingDate as date)) "Quartal",
	DATEPART (mm, CAST(s.postingDate as date)) "Monat"
from
	iw_sales s
where
	s.type = 2
group by
	ROLLUP(DATEPART (yyyy, CAST(s.postingDate as date)),
		DATEPART (qq, CAST(s.postingDate as date)),
		DATEPART (mm, CAST(s.postingDate as date))
	)
)

select * from [Cubes].[dbo].[DimZeit]
