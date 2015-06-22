INSERT INTO [Cubes].[dbo].[DimAlter](Bezeichnung, Anzahl)
Values
(
'<20',(select isnull(sum(b.anzahl),0)
from
-- OPTIMIERUNG: Diese Query als Materialized View speichern
	(select a.age, count(a.riskID)'anzahl' 
	from
		(select distinct riskID, DATEDIFF(yy,birthdate,CURRENT_TIMESTAMP)'age' from [DWH-OnlineShop].dbo.iw_customer group by riskID,birthdate)a
	group by a.age)b
where b.age <20)
)

INSERT INTO [Cubes].[dbo].[DimAlter](Bezeichnung, Anzahl)
Values
(
'>=20 & < 30',(select isnull(sum(b.anzahl),0)
from
	(select a.age, count(a.riskID)'anzahl' 
	from
		(select distinct riskID, DATEDIFF(yy,birthdate,CURRENT_TIMESTAMP)'age' from [DWH-OnlineShop].dbo.iw_customer group by riskID,birthdate)a
	group by a.age)b
where b.age >= 20 and b.age <30)
)


INSERT INTO [Cubes].[dbo].[DimAlter](Bezeichnung, Anzahl)
Values
(
'>=30 & < 40',(select isnull(sum(b.anzahl),0)
from
	(select a.age, count(a.riskID)'anzahl' 
	from
		(select distinct riskID, DATEDIFF(yy,birthdate,CURRENT_TIMESTAMP)'age' from [DWH-OnlineShop].dbo.iw_customer group by riskID,birthdate)a
	group by a.age)b
where b.age >= 30 and b.age <40)
)


INSERT INTO [Cubes].[dbo].[DimAlter](Bezeichnung, Anzahl)
Values
(
'>=40 & < 50',(select isnull(sum(b.anzahl),0)
from
	(select a.age, count(a.riskID)'anzahl' 
	from
		(select distinct riskID, DATEDIFF(yy,birthdate,CURRENT_TIMESTAMP)'age' from [DWH-OnlineShop].dbo.iw_customer group by riskID,birthdate)a
	group by a.age)b
where b.age >= 40 and b.age <50)
)

INSERT INTO [Cubes].[dbo].[DimAlter](Bezeichnung, Anzahl)
Values
(
'>=50 & < 60',(select isnull(sum(b.anzahl),0)
from
	(select a.age, count(a.riskID)'anzahl' 
	from
		(select distinct riskID, DATEDIFF(yy,birthdate,CURRENT_TIMESTAMP)'age' from [DWH-OnlineShop].dbo.iw_customer group by riskID,birthdate)a
	group by a.age)b
where b.age >= 50 and b.age <60)
)

INSERT INTO [Cubes].[dbo].[DimAlter](Bezeichnung, Anzahl)
Values
(
'>=60 & < 90',(select isnull(sum(b.anzahl),0)
from
	(select a.age, count(a.riskID)'anzahl' 
	from
		(select distinct riskID, DATEDIFF(yy,birthdate,CURRENT_TIMESTAMP)'age' from [DWH-OnlineShop].dbo.iw_customer group by riskID,birthdate)a
	group by a.age)b
where b.age >= 60 and b.age <90)
)

INSERT INTO [Cubes].[dbo].[DimAlter](Bezeichnung, Anzahl)
Values
(
'ohne gültige Altersangabe',(select isnull(sum(b.anzahl),0)
from
	(select a.age, count(a.riskID)'anzahl' 
	from
		(select distinct riskID, DATEDIFF(yy,birthdate,CURRENT_TIMESTAMP)'age' from [DWH-OnlineShop].dbo.iw_customer group by riskID,birthdate)a
	group by a.age)b
where b.age >= 90)
)

select * from [Cubes].[dbo].[DimAlter]