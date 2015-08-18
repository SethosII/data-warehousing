## Agenda

1. Fragestellungen für die Datenanaylse
2. Architektur des Data Warehouse
3. Auswertung der Cubes
4. Bewertung der Analyseergebnisse



## Fragestellungen für die Datenanaylse



### Kunden

- Wer sind die kaufkräftigsten Kundengruppen?
- Wer sind die aktivsten Kundengruppen?
- Wie viel Umsatz generieren die einzelnen Altersgruppen?

### Produkte

- Was sind die meistverkauftesten Produkte? 
- Wie ist die Umsatzentwicklung bzw. –verteilung?
- Welche Produkte werden besonders häufig reklamiert und warum?

### Warenkorbanalyse

- Welche Produkte bzw. Produktgruppen werden besonders häufig zusammengekauft?
- Wie ist die zeitliche Entwicklung bestimmter Produktkombinationen?



## Architektur des Data Warehouse



### Cube Bestellungen

![](images/cube-bestellungen.png)



### Cube Retouren

![](images/cube-retouren.png)



### Cube Cross-Sells

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

## Auswertung des Cubes Cross-Sells



### Cross-Sellinge zwischen Produkten

![](images/topcross-produkte.png)



### Zeitliche Entwicklung des Top-Cross-Sells

![](images/topcrosssell-entwicklung.png)



### Cross-Sellinge zwischen Produktgruppen

![](images/topcross-gruppen.png)



<!-- .slide: data-background="images/xkcd.png" -->

## Auswertung der Analyseergebnisse



### Auswertung der Analyseergebnisse

- Daten für Umsatzentwicklung nicht ausreichen für Empfehlungen
- Kunden kaufen vermehrt Sommerkleidung
	- Spezielle Saisonangebote
- Frauen zwischen 40 und 60 sind die umsatzstärkste Kundengruppe
	- Spezielle Angebote/Ausrichtung
- Retourem entsprechend der Verkaufszahlen
	- Keine Ausreißer, die aus dem Sortiment genommen werden sollten
	- Männer geben weniger zurück als Frauen
- Retourengründe DONTLIKE, TOBIG, TOSHORT
	- Bessere Beschreibung von Produkt und Größe
- Empfehlungen für Produkte
	- Anzeige von Cross-Sellvorschlägen
	- Artikel aus der gleichen Produktgruppe vorschlagen
- Angebote zu Produktgruppen
- Generell fehlen Langzeitdaten für weitere Aussagen
