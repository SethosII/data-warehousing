--Query fügt nur noch neue Produkte ein
Use Cubes;

select * from DimProdukt;

INSERT into DimProdukt(ProduktID,Produktgruppe,Preis, Farbe, Groesse, Bezeichnung)
	select IWAN, productGroup, unitPrice, colorDescription, size, description 
	from
		[DWH-OnlineShop].[dbo].iw_article
	where  
		not exists(select 1 from DimProdukt where dimProdukt.ProduktID = IWAN)

select * from DimProdukt;