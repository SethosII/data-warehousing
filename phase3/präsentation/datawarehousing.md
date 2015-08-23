## Agenda

1. Fragestellungen für die Datenanalyse
2. Architektur des Data Warehouse
3. Auswertung der Cubes
4. Auswertung der Analyseergebnisse



## Fragestellungen für die Datenanalyse



### Kunden

- Was sind die kaufkräftigsten Kundengruppen?
- Was sind die aktivsten Kundengruppen?
- Wie viel Umsatz generieren die einzelnen Altersgruppen?

<br/>

### Produkte

- Was sind die am häufigsten gekauften Produkte?
- Wie ist die Umsatzentwicklung bzw. –verteilung?
- Welche Produkte werden besonders häufig reklamiert und warum?

<br/>

### Warenkorbanalyse

- Welche Produkte bzw. Produktgruppen werden besonders häufig zusammengekauft?
- Wie ist die zeitliche Entwicklung bestimmter Produktkombinationen?



## Architektur des Data Warehouse



### Cube Bestellungen

![](images/cube-bestellungen.png)

Note:

Untersuchung nach fünf Dimensionen



### Cube Retouren

![](images/cube-retouren.png)

Notes:

ähnlich Bestellungen



### Cube Cross-Selling

![](images/cube-cross-sells.png)

Note:

Cross-Selling auf Basis von Bestellungen



<!-- .slide: data-background="images/cube-bestellungen-sql.png" -->

## Auswertung des Cubes Bestellungen



### Umsatzentwicklung

![](images/umsatzentwicklung.png)

Note:

keine Trend oder starke Monate erkennbar

Umastz korreliert mit Anzahl der Bestellungen



### Meistverkaufte Produkte

![](images/topprodukt-anzahl.png)

Note:

hauptsächlich Sommerbekleidung

keine großen Abstände



### Umsatzstärkste Produkte

![](images/topprodukt-umsatz.png)

Note:

keine spezielle Produktgruppe

Product M5 hat großen Abstand

Umastz und Anzahl der Bestellungen korrelieren nicht



### Umsatzstärkste Kundengruppe

![](images/topkunden.png)

Note:

40-50 w mit Newsletter mit Abstand

Frauen machen mehr Umsatz als Männer (sind auch echt mehr)

Umastz korreliert mit Anzahl der Bestellungen



<!-- .slide: data-background="images/cube-retouren-sql.png" -->

## Auswertung des Cubes Retouren



### Meistretournierte Produkte

![](images/topretouren-anzahl.png)

Note:

hauptsächlich Bikinis

keine großen Abstände



### Retourenstärkste Kundengruppe

![](images/downkunden.png)

Note:

40-50 w (kaufen auch am meisten

korreliert generell mit Bestellungen



### Häufigster Retourengrund

![](images/topretourengrund.png)

Note:

DONTLIKE, TOBIG, TOSHORT, OTHER an der Spitze



<!-- .slide: data-background="images/cube-cross-sells-sql.png" -->

## Auswertung des Cubes Cross-Selling



### Cross-Selling zwischen Produkten

![](images/topcross-produkte.png)

Note:

ähnliche Proukte werden zusammengekauft

hauptsächlich Sommersachen



### Zeitliche Entwicklung des Top-Cross-Sellings

![](images/topcrosssell-entwicklung.png)



### Cross-Selling zwischen Produktgruppen

![](images/topcross-gruppen.png)

Note:

häufig aus der selben Produktgruppe mehrere Produkte zusammengekauft



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



## Fragen?
![](images/extrapolating.png)
