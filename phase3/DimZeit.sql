USE Cubes; 
select * from dimZeit order by jahr, Quartal, Monat;


--Query fügt nur noch neue Zeitangaben ein
INSERT into DimZeit(Jahr,Quartal,Monat)
	select Jahr, Quartal, Monat 
	from(
		select * 
		from(
			select
				DATEPART (yyyy, CAST(s.postingDate as date)) "Jahr",
				DATEPART (qq, CAST(s.postingDate as date)) "Quartal",
				DATEPART (mm, CAST(s.postingDate as date)) "Monat"
			from
				[DWH-OnlineShop].[dbo].[iw_sales] s
			where
				s.type = 2
			group by
				ROLLUP(DATEPART (yyyy, CAST(s.postingDate as date)),
				DATEPART (qq, CAST(s.postingDate as date)),
				DATEPART (mm, CAST(s.postingDate as date))
			)
		)rawDataZeit
		where 
			rawDataZeit.Jahr is not null AND rawDataZeit.Monat is not null AND rawDataZeit.Quartal is not null
	)cleanData
	where  
		not exists(select 1 from DimZeit where dimZeit.Jahr = cleanData.Jahr and dimZeit.Quartal = cleanData.Quartal and dimZeit.Monat = cleanData.Monat)

select * from dimZeit order by jahr, Quartal, Monat;