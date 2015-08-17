USE [DWH-OnlineShop]

delete [Cubes].[dbo].[Bestellungen]

insert into [Cubes].[dbo].[Bestellungen] (ZeitID, Geschlecht, AltersgruppeID, Newsletter, ProduktID, AnzahlBestellungen, Umsatz)

select dimzeit.ID, Geschlecht, dimaltersgruppe.AltersgruppeID, Newsletter, Produkt, Bestellungen, Umsatz
from (
	select
		*
	from (
		select
			datepart(yyyy, cast(s.postingDate as date)) 'Jahr',
			datepart(qq, cast(s.postingDate as date)) 'Quartal',
			datepart(mm, cast(s.postingDate as date)) 'Monat',
			c.newsletter 'Newsletter',
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
			count(distinct s.orderNo) 'Bestellungen',
			sum(cast(s.line_amount as decimal(10,2))) 'Umsatz'
		from
			iw_sales s,
			iw_customer c,
			iw_article a
		where
			type=2 and
			s.customerNo = c.customerNo and
			s.IWAN = a.IWAN
		group by
			rollup (
				DATEPART(yyyy, CAST(s.postingDate as date)),
				DATEPART(qq, CAST(s.postingDate as date)),
				DATEPART(mm, CAST(s.postingDate as date)),
				c.newsletter,
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
	) rawData
	where
		rawData.Produkt is not null
) cleanData
join [Cubes].[dbo].[DimAlter] dimaltersgruppe on dimaltersgruppe.Bezeichnung = Altersgruppe
join [Cubes].[dbo].[DimZeit] dimzeit on dimzeit.Jahr = cleanData.Jahr and dimzeit.Quartal = cleanData.Quartal and dimzeit.Monat = cleanData.Monat
