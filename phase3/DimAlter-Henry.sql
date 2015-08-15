USE Cubes;


delete from DimAlter;

insert into [DimAlter](Bezeichnung, Anzahl)
values(
	'>=20 & < 30', (select isnull(sum(b.anzahl), 0)
	from(
		select a.age, count(a.riskID) 'anzahl' 
		from(
			select distinct riskID, DATEDIFF(yy, birthdate, CURRENT_TIMESTAMP) 'age'
			from [DWH-OnlineShop].dbo.iw_customer
			group by riskID, birthdate
		) a
		group by a.age
	) b
	where b.age >= 20 and b.age < 30)
)


insert into [DimAlter](Bezeichnung, Anzahl)
values(
	'>=30 & < 40', (select isnull(sum(b.anzahl), 0)
	from(
		select a.age, count(a.riskID) 'anzahl' 
		from(
			select distinct riskID, DATEDIFF(yy, birthdate, CURRENT_TIMESTAMP) 'age'
			from [DWH-OnlineShop].dbo.iw_customer
			group by riskID, birthdate
		) a
		group by a.age
	) b
	where b.age >= 30 and b.age < 40)
)


insert into [DimAlter](Bezeichnung, Anzahl)
values(
	'>=40 & < 50', (select isnull(sum(b.anzahl), 0)
	from(
		select a.age, count(a.riskID) 'anzahl' 
		from(
			select distinct riskID, DATEDIFF(yy, birthdate, CURRENT_TIMESTAMP) 'age'
			from [DWH-OnlineShop].dbo.iw_customer
			group by riskID, birthdate
		) a
		group by a.age
	) b
	where b.age >= 40 and b.age < 50)
)



insert into [DimAlter](Bezeichnung, Anzahl)
values(
	'>=50 & < 60', (select isnull(sum(b.anzahl), 0)
	from(
		select a.age, count(a.riskID) 'anzahl' 
		from(
			select distinct riskID, DATEDIFF(yy, birthdate, CURRENT_TIMESTAMP) 'age'
			from [DWH-OnlineShop].dbo.iw_customer
			group by riskID, birthdate
		) a
		group by a.age
	) b
	where b.age >= 50 and b.age < 60)
)


insert into [DimAlter](Bezeichnung, Anzahl)
values(
	'>=60 & < 90', (select isnull(sum(b.anzahl), 0)
	from(
		select a.age, count(a.riskID) 'anzahl' 
		from(
			select distinct riskID, DATEDIFF(yy, birthdate, CURRENT_TIMESTAMP) 'age'
			from [DWH-OnlineShop].dbo.iw_customer
			group by riskID, birthdate
		) a
		group by a.age
	) b
	where b.age >= 60 and b.age < 90)
)



insert into [DimAlter](Bezeichnung, Anzahl)
values(
	'>90', (select isnull(sum(b.anzahl), 0)
	from(
		select a.age, count(a.riskID) 'anzahl' 
		from(
			select distinct riskID, DATEDIFF(yy, birthdate, CURRENT_TIMESTAMP) 'age'
			from [DWH-OnlineShop].dbo.iw_customer
			group by riskID, birthdate
		) a
		group by a.age
	) b
	where b.age >= 90)
)



select * from [Cubes].[dbo].[DimAlter]
