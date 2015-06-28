INSERT INTO [Cubes].dbo.DimProdukt(ProduktID, Preis, Farbe, Groesse, Bezeichnung, Produktgruppe)
SELECT IWAN, unitPrice, ColorDescription, size, description, productGroup
FROM iw_article
