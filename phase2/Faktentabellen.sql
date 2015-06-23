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
