use [Cubes]

-- fügt nur neue neue Zeitangaben ein
insert into DimZeit (Jahr, Quartal, Monat)

select Jahr, Quartal, Monat
from(
	select * 
	from(
		select
			datepart(yyyy, cast(s.postingDate as date)) 'Jahr',
			datepart(qq, cast(s.postingDate as date)) 'Quartal',
			datepart(mm, cast(s.postingDate as date)) 'Monat'
		from
			[DWH-OnlineShop].[dbo].[iw_sales] s
		where
			s.type = 2
		group by
			rollup(
				datepart(yyyy, cast(s.postingDate as date)),
				datepart(qq, cast(s.postingDate as date)),
				datepart(mm, cast(s.postingDate as date))
			)
	) rawDataZeit
	where 
		rawDataZeit.Jahr is not null and
		rawDataZeit.Monat is not null and
		rawDataZeit.Quartal is not null
) cleanData
where  
	not exists(
		select
			1
		from
			DimZeit
		where
			dimZeit.Jahr = cleanData.Jahr and
			dimZeit.Quartal = cleanData.Quartal and
			dimZeit.Monat = cleanData.Monat
	)

select * from dimZeit order by Jahr, Quartal, Monat
