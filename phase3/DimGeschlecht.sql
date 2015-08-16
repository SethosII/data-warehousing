
delete [Cubes].[dbo].[DimGeschlecht];

INSERT INTO [Cubes].[dbo].[DimGeschlecht](Geschlecht, Anzahl)
Values
(
'm', (select count(g.riskID) from (select riskID, salutation from iw_customer group by riskID, salutation) g where salutation = 'Herr')
)

INSERT INTO [Cubes].[dbo].[DimGeschlecht](Geschlecht, Anzahl)
Values
(
'w', (select count(g.riskID) from (select riskID, salutation from iw_customer group by riskID, salutation) g where salutation = 'Frau')
)


select * from  [Cubes].[dbo].[DimGeschlecht]

