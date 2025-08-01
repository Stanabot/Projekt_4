# Projekt: Analýza dostupnosti základních potravin v ČR (2006–2018)

**Projekt č. 4 – SQL - DA Engeto**

**Autor: Stanislava Jahodová**

---

## Cíl projektu:  
I. Odpovědět na analytické otázky dostupnosti základních potravin v ČR
   ve srovnatelném období (2006–2018) na základě vývoje mezd, cen a HDP.
   
II. Připravit doplňkový přehled základních makroekonomických ukazatelů 
    ve evropských zemích za stejné období.

---

## Datové zdroje:
 - PostgreSQL

## Datové tabulky:

**1.	't_stanislava_jahodova_project_SQL_primary_final'**

Tabulka byla vytvořena pomocí tří CTE a obsahuje data pro ČR v letech 2006–2018:

- průměrná mzda za rok a odvětví,
- průměrná cena potraviny za rok (celorepublikový průměr),
- HDP ČR za daný rok.

Slouží jako podklad pro odpovědi na otázky 1–5.

**2.	't_stanislava_jahodova_project_SQL_secondary_final'**

Obsahuje základní makroekonomická data za evropské země (2006–2018):

- HDP (v USD),
- GINI index,
- Počet obyvatel.

Slouží jako doplňkový podklad pro případné srovnání v rámci Evropy.

---

## I. Výzkumné otázky a odpovědi

### Otázka č. 1
**Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?**

Mzdy ve většině odvětví v daném období rostly,
ale některá odvětví zaznamenala také pokles.

 - Největší pokles mezd - rok 2013:
    - u 11 z 19 odvětví došlo k poklesu mezd (záporný meziroční nárůst)
    - průměrný růst mezd napříč všemi odvětvími byl –0,78 %
	  - pravděpodobně dozvuky globální finanční krize 2009–2012.

 - Roky nejvyššího růstu -  2007, 2008 a 2017, 2018
    - období ekonomického růstu

**Změna pořadí odvětví podle výše mzdy (2006 → 2018):** 
 - největší propad: "Činnosti v oblasti nemovitostí" - z 9. na 15. místo 
 - největší posun:  "Zpracovatelský průmysl" - z 12. na 8. místo

---

### Otázka č. 2
**Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední**<br> 
**srovnatelné období v dostupných datech cen a mezd?**

| Produkt                      | Jedn. v r. 2006  | Jedn. v r. 2018 | Rozdíl |
|------------------------------|------------------|-----------------|--------|
| Chléb konzumní kmínový       | 1312.98          | 1365.16         | 52.18  |
| Mléko polotučné pasterované  | 1465.73          | 1669.60         | 203.87 |



**Navíc - analýza kupní síly v nejlépe a nejhůře placených odvětvích:**

- Chléb:
	- Nejlépe placení: pokles kupní síly o −142,81 kg
	- Nejhůře placení: nárůst kupní síly o +70,74 kg
		
| Rok  | Odvětví                              | Jednotek | Rozdíl   |
|------|--------------------------------------|----------|----------|
| 2006 | Peněžnictví a pojišťovnictví         | 2483.06  |          |
| 2006 | Ubytování, stravování a pohostinství | 724.21   |          |
| 2018 | Informační a komunikační činnosti    | 2340.25  | −142.81  |
| 2018 | Ubytování, stravování a pohostinství | 794.95   | +70.74   |


- Mléko:
  - nárůst kupní síly v obou skupinách

| Rok  | Odvětví                              | Jednotek | Rozdíl   |
|------|--------------------------------------|----------|----------|
| 2006 | Peněžnictví a pojišťovnictví         | 1466.08  |          |
| 2006 | Ubytování, stravování a pohostinství | 427.58   |          |
| 2018 | Informační a komunikační činnosti    | 1669.60  | +203.52  |
| 2018 | Ubytování, stravování a pohostinství | 567.47   | +139.89  |
---

### Otázka č. 3
**Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální**<br>
**meziroční nárůst)?**

Top 5 nejpomaleji zdražujících potravin (průměrný meziroční růst v %):

| Produkt                                 | Průměrný růst (%) |
|-----------------------------------------|-------------------|
| Cukr krystalový                         | -0.09             |
| Rajská jablka červená kulatá            | -0.04             |
| Banány žluté                            |  0.04             |
| Přírodní minerální voda uhličitá        |  0.05             |
| Vepřová pečeně s kostí                  |  0.05             |

---

### Otázka č. 4
**Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší**<br>
**než růst mezd (větší než 10 %)?**

Sledován rozdíl (růst cen – růst mezd) v procentních bodech (p. b.) 
v letech 2007–2018.

- Žádný rok nepřekročil rozdíl +10 % ve prospěch cen.

- Nejvyšší rozdíl ve prospěch cen nastal v roce 2013:
  - růst mezd: –1,56 %
  - růst cen: +5,10 %
  - rozdíl: +6,66 p. b.

- Naopak nejvyšší rozdíl ve prospěch mezd byl v roce 2009::
  - růst mezd: +3,07 %
  - růst cen: –6,41 %
  - rozdíl: –9,48 p. b. (ve prospěch mezd)

---

### Otázka č. 5
**Má výška HDP vliv na změny ve mzdách a cenách potravin?**
**Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách**<br>
**potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?**

- Vztah **HDP → mzdy** je výraznější než vztah **HDP → ceny potravin**.

	- Růst HDP často doprovází růst mezd. 
	  MZDY někdy rostou spolu s HDP (např. 2007, 2017), ale není to pravidlem.

	- CENY potravin se často vyvíjejí nezávisle na HDP, rostly i v letech, 
	  kdy byl růst HDP nízký nebo klesal => vliv dalších faktorů 
	  (např. dovozní ceny, inflace, sezónní výkyvy).

- "Dozvuk HDP" v následujícím roce se objevuje jen občas (např. 2016 → 2017),
   bez opakovatelného vzorce.

---

## II. Doplňkový přehled 

**Srovnání GINI koeficientu (2006–2018):**

- Česká republika vykazovala jednu z nejnižších hodnot GINI v Evropě 
   - průměr 26,0 (rozmezí min a max: 24,9–26,7).
  Dále to pak bylo Slovinsko (24,9), Ukrajina (25,7) a Slovensko (26,2). 

- Nejvyšší příjmové nerovnosti dosahovaly:
   - Rusko – průměr 39,6 (maximum 42,3), Černá Hora, Srbsko,
     Bulharsko a Severní Makedonie – průměry nad 36.


