use [DWH-Onlineshop]

-- fügt nur neue Produkte ein
insert into [Cubes].[dbo].[DimProdukt] (ProduktID, Produktgruppe, Preis, Farbe, Groesse, Bezeichnung)

select
	IWAN,
	productGroup,
	unitPrice,
	colorDescription,
	size,
	description 
from
	iw_article
where  
	not exists(
		select
			1
		from
			[Cubes].[dbo].[DimProdukt]
		where
			DimProdukt.ProduktID = IWAN
	)

select * from [Cubes].[dbo].[DimProdukt]
