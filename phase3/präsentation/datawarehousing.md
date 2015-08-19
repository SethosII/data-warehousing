## Agenda

1. Fragestellungen für die Datenanalyse
2. Architektur des Data Warehouse
3. Auswertung der Cubes
4. Bewertung der Analyseergebnisse



## Fragestellungen für die Datenanalyse



### Kunden

- Was sind die kaufkräftigsten Kundengruppen?
- Was sind die aktivsten Kundengruppen?
- Wie viel Umsatz generieren die einzelnen Altersgruppen?

<br/>

### Produkte

- Was sind die meistverkauften Produkte?
- Wie ist die Umsatzentwicklung bzw. –verteilung?
- Welche Produkte werden besonders häufig reklamiert und warum?

<br/>

### Warenkorbanalyse

- Welche Produkte bzw. Produktgruppen werden besonders häufig zusammengekauft?
- Wie ist die zeitliche Entwicklung bestimmter Produktkombinationen?



## Architektur des Data Warehouse



### Cube Bestellungen

![](images/cube-bestellungen.png)



### Cube Retouren

![](images/cube-retouren.png)



### Cube Cross-Selling

![](images/cube-cross-sells.png)

Note:

Cross-Selling auf Basis von Bestellungen



<!-- .slide: data-background="images/cube-bestellungen-sql.png" -->

## Auswertung des Cubes Bestellungen



### Umsatzentwicklung

![](images/umsatzentwicklung.png)



### Meistverkaufte Produkte

![](images/topprodukt-anzahl.png)



### Umsatzstärkste Produkte

![](images/topprodukt-umsatz.png)



### Umsatzstärkste Kundengruppe

![](images/topkunden.png)



<!-- .slide: data-background="images/cube-retouren-sql.png" -->

## Auswertung des Cubes Retouren



### Meistretournierte Produkte

![](images/topretouren-anzahl.png)



### Retourenstärkste Kundengruppe

![](images/downkunden.png)



### Häufigster Retourengrund

![](images/topretourengrund.png)



<!-- .slide: data-background="images/cube-cross-sells-sql.png" -->

## Auswertung des Cubes Cross-Selling



### Cross-Selling zwischen Produkten

![](images/topcross-produkte.png)



### Zeitliche Entwicklung des Top-Cross-Sellings

![](images/topcrosssell-entwicklung.png)



### Cross-Selling zwischen Produktgruppen

![](images/topcross-gruppen.png)



<!-- .slide: data-background="images/xkcd.png" -->

## Auswertung der Analyseergebnisse



### Analyseergebnisse

- Daten für Umsatzentwicklung ohne Auffälligkeiten
- Kunden kaufen vermehrt Sommerkleidung
- Frauen zwischen 40 und 60 sind umsatzstärkste Kundengruppe
- Retouren korrelieren mit Verkaufszahlen
- Männer geben weniger zurück als Frauen
- Retourengründe meist DONTLIKE, TOBIG, TOSHORT
- Generell fehlen Langzeitdaten für weitere Aussagen



### Empfehlungen

- Daten für Umsatzentwicklung nicht ausreichend für Empfehlungen
- Saisonangebote
- Ausrichtung auf Zielgruppe
- Keine Retourentreiber, die aus dem Sortiment genommen werden sollten
- Bessere Beschreibung von Produkt und Größe
- Artikel aus der gleichen Produktgruppe vorschlagen
- Anzeige von Cross-Selling-Vorschlägen
- Angebote zu Produktgruppen
