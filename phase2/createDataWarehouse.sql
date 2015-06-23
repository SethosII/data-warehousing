-- Anlegen der Dimensionstabellen

CREATE TABLE DimAlter (
  AltersgruppeID INT IDENTITY(1,1) PRIMARY KEY,
  Bezeichnung CHAR(100),
  Anzahl INT )

-- als PK soll die IWAN der Produkte verwendet werden 
-- normale int als PK verursachen Ueberlauf (lt. MS SQL-Server 2012)
CREATE TABLE DimProdukt (
  ProduktID CHAR(50) PRIMARY KEY, 
  Produktgruppe CHAR(100),
  Preis DECIMAL ,
  Farbe CHAR(50) ,
  Groesse CHAR(50) ,
  Bezeichnung CHAR(50)
  )

-- maennlich -> m
-- weiblich -> w
CREATE TABLE DimGeschlecht (
  Geschlecht CHAR(1) PRIMARY KEY,
  Anzahl INT ,
  )

CREATE TABLE DimNewsletter (
  Newsletter BIT PRIMARY KEY,
  Anzahl INT
  )

CREATE TABLE DimJahr (
  JahrID INT IDENTITY(1,1) PRIMARY KEY,
  Bezeichnung CHAR(50),
  )

CREATE TABLE DimQuartal (
  QuartalID INT IDENTITY(1,1) PRIMARY KEY,
  Bezeichnung CHAR(50),
  JahrID INT NOT NULL,
  CONSTRAINT fk_Quartal_Jahr FOREIGN KEY (JahrID) REFERENCES DimJahr (JahrID) ON DELETE CASCADE ON UPDATE CASCADE
  )

CREATE TABLE DimMonat (
  MonatID INT IDENTITY(1,1) PRIMARY KEY,
  Bezeichnung CHAR(50) ,
  QuartalID INT NOT NULL,
  CONSTRAINT fk_Monat_Quartal FOREIGN KEY (QuartalID) REFERENCES DimQuartal (QuartalID) ON DELETE CASCADE ON UPDATE CASCADE
  )

CREATE TABLE DimRetourengrund (
  Grund CHAR(50) PRIMARY KEY NOT NULL,
  Wert DECIMAL,
  Anzahl INT ,
  )



-- Anlegen der Faktentabellen

CREATE TABLE Bestellungen (
  AnzahlBestellungen INT,
  Umsatz DECIMAL ,
  AltersgruppeID INT,
  ProduktID CHAR(50) ,
  Geschlecht CHAR(1) ,
  Newsletter BIT ,
  MonatID INT ,
  PRIMARY KEY (AltersgruppeID, ProduktID, Geschlecht, Newsletter, MonatID),
  CONSTRAINT fk_Bestellungen_Altersgruppe FOREIGN KEY (AltersgruppeID) REFERENCES DimAlter (AltersgruppeID) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_Bestellungen_Produkt FOREIGN KEY (ProduktID) REFERENCES DimProdukt (ProduktID) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_Bestellungen_Geschlecht FOREIGN KEY (Geschlecht) REFERENCES DimGeschlecht (Geschlecht) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_Bestellungen_Newsletter FOREIGN KEY (Newsletter) REFERENCES DimNewsletter (Newsletter) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_Bestellungen_Monat1 FOREIGN KEY (MonatID) REFERENCES DimMonat (MonatID) ON DELETE CASCADE ON UPDATE CASCADE
  )

-- zwischen den Produkten bestehte eine m-zu-n-Beziehung -> CrossSells-Tabelle speichert, wie oft ein Produkt zusammen mit einem
-- anderen Produkt gekauft wurde 
CREATE TABLE CrossSells (
  Anzahl INT ,
  Produkt1ID CHAR(50),
  MonatID INT,
  Produkt2ID CHAR(50),
  PRIMARY KEY (Produkt1ID, MonatID, Produkt2ID),
  CONSTRAINT fk_CrossSells_Produkt1 FOREIGN KEY (Produkt1ID) REFERENCES DimProdukt (ProduktID) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_CrossSells_Produkt2 FOREIGN KEY (Produkt2ID) REFERENCES DimProdukt (ProduktID) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_CrossSells_Monat FOREIGN KEY (MonatID) REFERENCES DimMonat (MonatID) ON DELETE CASCADE ON UPDATE CASCADE
  )
  
CREATE TABLE Retouren (
  AnzahlRetouren INT ,
  Umsatz DECIMAL,
  AltersgruppeID INT ,
  ProduktID CHAR(50),
  Geschlecht CHAR(1),
  Grund CHAR(50),
  MonatID INT,
  PRIMARY KEY (AltersgruppeID, ProduktID, Geschlecht, Grund, MonatID),
  CONSTRAINT fk_Retouren_Altersgruppe FOREIGN KEY (AltersgruppeID) REFERENCES DimAlter (AltersgruppeID) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_Retouren_Produkt FOREIGN KEY (ProduktID) REFERENCES DimProdukt (ProduktID) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_Retouren_Geschlecht FOREIGN KEY (Geschlecht) REFERENCES DimGeschlecht (Geschlecht) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_Retouren_Newsletter FOREIGN KEY (Grund) REFERENCES DimRetourengrund (Grund) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_Retouren_Monat FOREIGN KEY (MonatID) REFERENCES DimMonat (MonatID) ON DELETE CASCADE ON UPDATE CASCADE
  )