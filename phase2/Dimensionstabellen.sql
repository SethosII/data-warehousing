--Dimensionstabellen
 CREATE TABLE DimAlter (
  AltersgruppeID INT PRIMARY KEY NOT NULL,
  Bezeichnung CHAR(100),
  Anzahl INT )


CREATE TABLE DimProdukt (
  ProduktID INT PRIMARY KEY NOT NULL,
  Produktgruppe CHAR(100),
  Preis DECIMAL ,
  Farbe CHAR(50) ,
  Groesse CHAR(50) ,
  Bezeichnung CHAR(50)
  )

  CREATE TABLE DimGeschlecht (
  Geschlecht CHAR(1) PRIMARY KEY NOT NULL,
  Anzahl INT ,
  )

  CREATE TABLE DimNewsletter (
  Newsletter BIT PRIMARY KEY NOT NULL,
  Anzahl INT,
  )

  CREATE TABLE DimJahr (
  JahrID INT PRIMARY KEY NOT NULL,
  Bezeichnung CHAR(50),
  )

  CREATE TABLE DimQuartal (
  QuartalID INT PRIMARY KEY NOT NULL,
  Bezeichnung CHAR(50),
  JahrID INT NOT NULL,
  CONSTRAINT fk_Quartal_Jahr FOREIGN KEY (JahrID) REFERENCES DimJahr (JahrID) ON DELETE CASCADE ON UPDATE CASCADE
  )

  CREATE TABLE DimMonat (
  MonatID INT PRIMARY KEY NOT NULL,
  Bezeichnung CHAR(50) ,
  QuartalID INT NOT NULL,
  CONSTRAINT fk_Monat_Quartal FOREIGN KEY (QuartalID) REFERENCES DimQuartal (QuartalID) ON DELETE CASCADE ON UPDATE CASCADE
  )

  CREATE TABLE DimRetourengrund (
  Grund CHAR(50) PRIMARY KEY NOT NULL,
  Wert DECIMAL,
  Anzahl INT ,
  )


 