USE [DWH-OnlineShop]

delete [Cubes].[dbo].[Retouren]

insert into [Cubes].[dbo].[Retouren] (ZeitID, Geschlecht, AltersgruppeID, Grund, ProduktID, AnzahlRetouren, Umsatz)

select dimzeit.ID, Geschlecht, dimaltersgruppe.AltersgruppeID, Grund, Produkt, Retouren, Umsatz
from (
	select
		*
	from (
		select
			datepart(yyyy, cast(r.postingDate as date)) 'Jahr',
			datepart(qq, cast(r.postingDate as date)) 'Quartal',
			datepart(mm, cast(r.postingDate as date)) 'Monat',
			r.returnReason 'Grund',
			case
				when c.salutation = 'Herr' then 'm'
				when c.salutation = 'Frau' then 'w'
			end 'Geschlecht',
			case
				when datediff(yy, c.birthdate, current_timestamp) < 20 then '<20'
				when datediff(yy, c.birthdate, current_timestamp) between 20 and 29 then '>=20 & < 30'
				when datediff(yy, c.birthdate, current_timestamp) between 30 and 39 then '>=30 & < 40'
				when datediff(yy, c.birthdate, current_timestamp) between 40 and 49 then '>=40 & < 50'
				when datediff(yy, c.birthdate, current_timestamp) between 50 and 59 then '>=50 & < 60'
				when datediff(yy, c.birthdate, current_timestamp) between 60 and 89 then '>=60 & < 90'
				when datediff(yy, c.birthdate, current_timestamp) >= 90 then '>=90'
			end as 'Altersgruppe',
			a.productGroup 'Produktgruppe',
			a.IWAN 'Produkt',
			count(distinct r.returnNo) 'Retouren',
			sum(cast(r.line_amount as decimal(10,2))) 'Umsatz'
		from
			iw_return_line r,
			iw_customer c,
			iw_article a
		where
			type=2 and
			r.customerNo = c.customerNo and
			r.IWAN = a.IWAN
		group by
			rollup(
				DATEPART(yyyy, CAST(r.postingDate as date)),
				DATEPART(qq, CAST(r.postingDate as date)),
				DATEPART(mm, CAST(r.postingDate as date)),
				r.returnReason,
				c.salutation,
				case
					when datediff(yy, c.birthdate, current_timestamp) < 20 then '<20'
					when datediff(yy, c.birthdate, current_timestamp) between 20 and 29 then '>=20 & < 30'
					when datediff(yy, c.birthdate, current_timestamp) between 30 and 39 then '>=30 & < 40'
					when datediff(yy, c.birthdate, current_timestamp) between 40 and 49 then '>=40 & < 50'
					when datediff(yy, c.birthdate, current_timestamp) between 50 and 59 then '>=50 & < 60'
					when datediff(yy, c.birthdate, current_timestamp) between 60 and 89 then '>=60 & < 90'
					when datediff(yy, c.birthdate, current_timestamp) >= 90 then '>=90'
				end,
				a.productGroup,
				a.IWAN
			)
	) notNull
	where
		notNull.Produkt is not null
) forInsert
join [Cubes].[dbo].[DimAlter] dimaltersgruppe on dimaltersgruppe.Bezeichnung = Altersgruppe
join [Cubes].[dbo].[DimZeit] dimzeit on dimzeit.Jahr = forInsert.Jahr and dimzeit.Quartal = forInsert.Quartal and dimzeit.Monat = forInsert.Monat
