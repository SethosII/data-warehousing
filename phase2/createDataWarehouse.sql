-- Anlegen der Dimensionstabellen

CREATE TABLE DimAlter (
  AltersgruppeID INT IDENTITY(1,1) PRIMARY KEY,
  Bezeichnung CHAR(100),
  Anzahl INT
)

-- als PK soll die IWAN der Produkte verwendet werden 
-- normale int als PK verursachen Ueberlauf (lt. MS SQL-Server 2012)
CREATE TABLE DimProdukt (
  ProduktID CHAR(50) PRIMARY KEY, 
  Produktgruppe CHAR(100),
  Preis DECIMAL,
  Farbe CHAR(50),
  Groesse CHAR(50),
  Bezeichnung CHAR(50)
)

-- maennlich -> m
-- weiblich -> w
CREATE TABLE DimGeschlecht (
  Geschlecht CHAR(1) PRIMARY KEY,
  Anzahl INT
)

CREATE TABLE DimNewsletter (
  Newsletter BIT PRIMARY KEY,
  Anzahl INT
)

CREATE TABLE DimZeit (
  ID INT IDENTITY(1,1) PRIMARY KEY,
  Monat INT,
  Quartal INT,
  Jahr INT
)

CREATE TABLE DimRetourengrund (
  Grund CHAR(50) PRIMARY KEY NOT NULL,
  Wert DECIMAL,
  Anzahl INT
)

-- Anlegen der Faktentabellen

CREATE TABLE Bestellungen (
  AnzahlBestellungen INT,
  Umsatz DECIMAL,
  AltersgruppeID INT,
  ProduktID CHAR(50),
  Geschlecht CHAR(1),
  Newsletter BIT,
  ZeitID INT,
  PRIMARY KEY (AltersgruppeID, ProduktID, Geschlecht, Newsletter, ZeitID),
  CONSTRAINT fk_Bestellungen_Altersgruppe FOREIGN KEY (AltersgruppeID) REFERENCES DimAlter (AltersgruppeID) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_Bestellungen_Produkt FOREIGN KEY (ProduktID) REFERENCES DimProdukt (ProduktID) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_Bestellungen_Geschlecht FOREIGN KEY (Geschlecht) REFERENCES DimGeschlecht (Geschlecht) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_Bestellungen_Newsletter FOREIGN KEY (Newsletter) REFERENCES DimNewsletter (Newsletter) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_Bestellungen_Zeit FOREIGN KEY (ZeitID) REFERENCES DimZeit (ID) ON DELETE CASCADE ON UPDATE CASCADE
)

-- zwischen den Produkten bestehte eine m-zu-n-Beziehung -> CrossSells-Tabelle speichert, wie oft ein Produkt zusammen mit einem
-- anderen Produkt gekauft wurde 
CREATE TABLE CrossSells (
  Anzahl INT,
  Produkt1ID CHAR(50),
  ZeitID INT,
  Produkt2ID CHAR(50),
  PRIMARY KEY (Produkt1ID, ZeitID, Produkt2ID),
  CONSTRAINT fk_CrossSells_Produkt1 FOREIGN KEY (Produkt1ID) REFERENCES DimProdukt (ProduktID) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_CrossSells_Produkt2 FOREIGN KEY (Produkt2ID) REFERENCES DimProdukt (ProduktID) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_CrossSells_Zeit FOREIGN KEY (ZeitID) REFERENCES DimZeit (ID) ON DELETE CASCADE ON UPDATE CASCADE
)
  
CREATE TABLE Retouren (
  AnzahlRetouren INT,
  Umsatz DECIMAL,
  AltersgruppeID INT,
  ProduktID CHAR(50),
  Geschlecht CHAR(1),
  Grund CHAR(50),
  ZeitID INT,
  PRIMARY KEY (AltersgruppeID, ProduktID, Geschlecht, Grund, ZeitID),
  CONSTRAINT fk_Retouren_Altersgruppe FOREIGN KEY (AltersgruppeID) REFERENCES DimAlter (AltersgruppeID) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_Retouren_Produkt FOREIGN KEY (ProduktID) REFERENCES DimProdukt (ProduktID) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_Retouren_Geschlecht FOREIGN KEY (Geschlecht) REFERENCES DimGeschlecht (Geschlecht) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_Retouren_Newsletter FOREIGN KEY (Grund) REFERENCES DimRetourengrund (Grund) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_Retouren_Zeit FOREIGN KEY (ZeitID) REFERENCES DimZeit (ID) ON DELETE CASCADE ON UPDATE CASCADE
)
