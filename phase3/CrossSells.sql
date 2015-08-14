USE [DWH-OnlineShop];

--Deklaration der Variablen
DECLARE @orderNo varchar(100);
DECLARE @IWAN varchar(100);
DECLARE @mainIWAN varchar(100);
DECLARE @innerIWAN varchar(100);

DECLARE @oldMainIWAN varchar(100);
SET @oldMainIWAN = ''

DECLARE @postingDate varchar(100);
DECLARE @postingYear int;
DECLARE @postingQuarter int;
DECLARE @postingMonth int;
DECLARE @dimZeitID int;

DECLARE @iwanCounter int;
SET @iwanCounter = 1;

DECLARE @crossSellMatches int;
SET @crossSellMatches =0;


delete from [Cubes].[dbo].CrossSells

--Cursor fuer aueﬂere Schleife
DECLARE ORDER_CURSOR CURSOR 
  LOCAL STATIC READ_ONLY FORWARD_ONLY
FOR select distinct orderNo from iw_sales order by orderNo

--Durchlaufe aueﬂere Schleife
OPEN ORDER_CURSOR
FETCH NEXT FROM ORDER_CURSOR INTO @orderNo
WHILE @@FETCH_STATUS = 0
	BEGIN 
		PRINT 'Bestellung: '+@orderNo
		SET @postingDate = (select distinct postingDate from iw_sales where orderNo = @orderNo)
		SET @postingYear = DATEPART (yyyy, CAST(@postingDate as date))
		SET @postingQuarter = DATEPART (qq, CAST(@postingDate as date))
		SET @postingMonth = DATEPART (mm, CAST(@postingDate as date))
		--PRINT 'J: '+ CAST(@postingYear as varchar) + ' Q: '+CAST(@postingQuarter as varchar)+ ' M: '+CAST(@postingMonth as varchar)
		SET @dimZeitID = (select distinct ID from [Cubes].[dbo].DimZeit where Jahr = @postingYear and Monat = @postingMonth and Quartal = @postingQuarter)
				
		--Cursor fuer innere Schleife
		DECLARE IWAN_CURSOR SCROLL CURSOR 
		FOR select IWAN from iw_sales where orderNo = @orderNo and type = 2
		
		--Durchlaufe innere Schleife
		OPEN IWAN_CURSOR
		FETCH NEXT FROM IWAN_CURSOR INTO @IWAN
		WHILE @@FETCH_STATUS = 0
			BEGIN
				SET @mainIWAN = @IWAN
				--PRINT 'mainIWAN: '+@mainIWAN
				--PRINT 'old: '+@oldMainIWAN
				IF @oldMainIWAN != @mainIWAN --kleiner bugfix ;)
				BEGIN
					FETCH NEXT FROM IWAN_CURSOR INTO @innerIWAN
					WHILE @@FETCH_STATUS = 0
					BEGIN
						--PRINT 'KOMBINATION: '+@mainIWAN+' <---> '+@innerIWAN
						SET @crossSellMatches =(select count(*) 
												from [Cubes].[dbo].CrossSells where
													((Produkt1ID = @mainIWAN and Produkt2ID=@innerIWAN) or (Produkt2ID = @mainIWAN and Produkt1ID=@innerIWAN)) 
													and (ZeitID = @dimZeitID)
												)
						IF @crossSellMatches < 1
							BEGIN

							    PRINT 'lege neu an: '+@mainIWAN+' - '+@innerIWAN
								insert into [Cubes].[dbo].[CrossSells](Produkt1ID,Produkt2ID,ZeitID,Anzahl)
								values
									(@mainIWAN,@innerIWAN, @dimZeitID,1)
							END
						ELSE
							BEGIN
								print 'Update: '+@mainIWAN+' - '+@innerIWAN
								update [Cubes].[dbo].[CrossSells] set Anzahl = Anzahl + 1
								where ((Produkt1ID = @mainIWAN and Produkt2ID=@innerIWAN) or 
								       (Produkt2ID = @mainIWAN and Produkt1ID=@innerIWAN)) and 
										(ZeitID = @dimZeitID)
							END

						FETCH NEXT FROM IWAN_CURSOR INTO @innerIWAN
					END
				END
				SET @oldMainIWAN = @mainIWAN
				SET @iwanCounter = @iwanCounter + 1
				FETCH ABSOLUTE @iwanCounter FROM IWAN_CURSOR INTO @IWAN
			END
		--Aufraeuemen
		CLOSE IWAN_CURSOR
		DEALLOCATE IWAN_CURSOR
		SET @iwanCounter =0
		SET @oldMainIWAN = ''
		FETCH NEXT FROM ORDER_CURSOR INTO @orderNo
	END

--Aufraeumen
CLOSE ORDER_CURSOR
DEALLOCATE ORDER_CURSOR