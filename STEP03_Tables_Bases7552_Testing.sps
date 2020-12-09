* Encoding: UTF-8.
** base on assumption correct QID step1.


*************************************************************.
*** STEP1. work for 4 key varis.
*** STEP1. work for 4 key varis.
**Annextype(A) CensusNo(A)  Enginepower(A)  QID(A).

GET FILE='D:\0GDrive\Cambodia\FiADatabase\database\Data\ROfficial_All7552.sav'.


**chek Enginepower.
**chek Enginepower.
**chek Enginepower.
FREQUENCIES Enginepower q4_4.
TEMPORARY.
SELECT IF RTRIM(Enginepower) NE RTRIM(q4_4).
LIST ID Annextype QID CensusNo  Enginepower q4_4 q3_3.




*Table 2. Number of fishing vessels and none fishing vessel.
*Table 2. Number of fishing vessels and none fishing vessel.
*Table 2. Number of fishing vessels and none fishing vessel.
** Using ProCode as province predefine.
FREQUENCIES Provincial.

STRING ProCensusNo (A20).
RECODE CensusNo (ELSE=COPY) INTO  ProCensusNo.
ALTER TYPE ProCensusNo (A2).
FREQUENCIES ProCensusNo.
RECODE ProCensusNo ('Kk' = 'KK').
FREQUENCIES ProCensusNo.

** check result both code.
CROSSTABS ProCensusNo BY Provincial.


*Table 2. Number of fishing vessels and none fishing vessel.
** Using ProCode as province predefine.
*Table 4. Total of marine fishing vessel in number and percentage.
FREQUENCIES  Provincial.


*Table 5. Marine fishing vessel classified by total length.
*Table 5. Marine fishing vessel classified by total length.
*Table 5. Marine fishing vessel classified by total length.
FREQUENCIES q3_3 /HISTOGRAM NORMAL.

* check outlier.
EXAMINE VARIABLES=q3_3
  /PLOT BOXPLOT STEMLEAF.

** check if they are 24m+
*** Totallenght.

SORT CASES BY q3_3 (D).
TEMPORARY.
SELECT IF q3_3 >= 24.
LIST ID Annextype QID CensusNo  Enginepower q3_3 Provincial.

RECODE q3_3 (LO THRU 11.99=1 ) (12 THRU 23.99=2) (24 THRU HI=3) INTO  Totallenght.

RECODE q3_3 (LO THRU 11.50=1 ) (11.51 THRU 23.50=2) (23.51 THRU HI=3) INTO  Totallenght_50.

VALUE LABELS Totallenght Totallenght_50 
    1 '1-<12' 
    2 '12-<24' 
    3 '>=24'.

FREQUENCIES Totallenght Totallenght_50/BARCHART /PIECHART.


** check buffer 0.09m.
TEMPORARY.
SELECT IF q3_3 >=11.90 AND q3_3 <=11.99.
LIST ID Annextype QID CensusNo  Enginepower q3_3  provincial.


CROSSTABS Totallenght BY Provincial.


** Editing for approval by adjusting only group but keep original value only..
IF ID = 201 Totallenght = 2.




*Table 6. Marine fishing vessel classify by total length classes.
*Table 6. Marine fishing vessel classify by total length classes.
*Table 6. Marine fishing vessel classify by total length classes.
RECODE q3_3 (LO THRU 5.99=1 )  (6 THRU 11.99=2) (12 THRU 17.99=3)
 (18 THRU 23.99=4) (24 THRU HI=5) INTO  Totallenght_T6.
VALUE LABELS Totallenght_T6
    1 '1-<6'
    2 '6-<12'
    3 '12-<18'
    4 '18-<24'
    5 '>=24'.
CROSSTABS Totallenght_T6 BY Provincial /BARCHART.

CROSSTABS Provincial BY Totallenght_T6 /BARCHART.

* condition q3_3 (LO THRU 5.99=1 )  (6 THRU 11.99=2) (12 THRU 17.99=3)
** check buffer 0.49m.
TEMPORARY.
SELECT IF q3_3 >=5.50 AND q3_3 <=5.99.
LIST ID Annextype QID CensusNo  Enginepower q3_3  provincial.


* condition q3_3 (LO THRU 5.99=1 )  (6 THRU 11.99=2) (12 THRU 17.99=3)
** check buffer 0.09m.
TEMPORARY.
SELECT IF q3_3 >=11.90 AND q3_3 <=11.99.
LIST ID Annextype QID CensusNo  Enginepower q3_3  provincial.


* condition q3_3 (LO THRU 5.99=1 )  (6 THRU 11.99=2) (12 THRU 17.99=3)
** check buffer 0.19m.
TEMPORARY.
SELECT IF q3_3 >=17.80 AND q3_3 <=17.99.
LIST ID Annextype QID CensusNo  Enginepower q3_3  provincial.




*===== If check with type of form, how big and small cross with form data entry.
*===== Issue of form collection which is big and small with classification.
*===== Issue of form collection which is big and small with classification.

CROSSTABS Totallenght_T6 BY  Annextype.


CROSSTABS Totallenght_T6 BY  Annextype BY Provincial.

CROSSTABS  Provincial BY Annextype/CELLS=ROW.




** Marine fishing vessels classify by small scale, medium and large scale. The active gears (Trawl and
Blood cockle dragged) take out from below 12meter of total length of fishing vessels, added to
medium scale vessels.

**Table 7. Active fishing gear of fishing vessel of total length from 6 m - <12m, which be included in Middle scale.
**Table 7. Active fishing gear of fishing vessel of total length from 6 m - <12m, which be included in Middle scale.
**Table 7. Active fishing gear of fishing vessel of total length from 6 m - <12m, which be included in Middle scale.

** the table 7 will provide basic information to adjust classification of vessel.

FREQUENCIES
    q8
    q8_1type q8_6type q8_9type.


*** create Fishing gear where they have 3types.
*** using primary.
STRING Fishgrear (A50).
COMPUTE Fishgrear = q8.
FREQUENCIES Fishgrear.
RECODE Fishgrear
    (''='N/A')
    ('Crab gill net'='Crab gillnet')
    ('Crab grillnet'='Crab gillnet')
    ('Fish gill net'='Fish gillnet')
    ('fish gillnet'='Fish gillnet')
    ('Fish Trap'='Fish trap')
    ('NA'='N/A')
    ('No'='N/A')
    ('Octopus trap  longline'='Octopus trap longline')
    ('Octopus trap longling'='Octopus trap longline')
    ('Other'='Others')
    ('Purse seine net'='Push net')
    ('Shrimp gill net'='Shrimp gillnet')
    ('Shrimp gill net (one layer)'='Shrimp gillnet').
FREQUENCIES Fishgrear.

** Regroup classification with fish gear.
** Regroup classification with fish gear.
** Regroup classification with fish gear.
RECODE Totallenght (ELSE = COPY) INTO Fishgear_Totallenght.
FORMATS Fishgear_Totallenght (F8.0).
VALUE LABELS Fishgear_Totallenght
   1 '1-<12' 
    2 '12-<24' 
    3 '>=24'.

*** transform two type of fishgear to middle.
** let check if they are in the list.
TEMPORARY.
SELECT IF Fishgrear ='Trawl' AND Totallenght = 1.
LIST ID Annextype QID CensusNo  Enginepower q3_3  Fishgrear Totallenght.

TEMPORARY.
SELECT IF Fishgrear ='Blood Cockle dragged basket' AND Totallenght = 1.
LIST ID Annextype QID CensusNo  Enginepower q3_3  Fishgrear Totallenght.

** now regroup this two fishing gear.
** now regroup this two fishing gear.
** now regroup this two fishing gear.
FREQUENCIES Fishgear_Totallenght.

IF (Fishgrear ='Trawl' AND Totallenght = 1 ) Fishgear_Totallenght = 2.
IF (Fishgrear ='Blood Cockle dragged basket' AND Totallenght = 1) Fishgear_Totallenght = 2 .

FREQUENCIES Fishgear_Totallenght.


CROSSTABS Fishgear_Totallenght BY Provincial.

CROSSTABS Provincial BY Fishgear_Totallenght /BARCHART.


***Create QRID to search database.
***Create QRID to search database.
***Create QRID to search database.
** mainly villageID=8digit, 



*====================================================================.
*====================================================================.
*====================================================================.
SAVE TRANSLATE OUTFILE='D:\0GDrive\Cambodia\FiADatabase\database\data\Official_All7552RECODE.xlsx' 
  /TYPE=XLS 
  /VERSION=12 
  /FIELDNAMES VALUE=NAMES 
  /CELLS=LABELS 
  /REPLACE.
*====================================================================.
*====================================================================.
*====================================================================.







*====================================================================.
** Generate new tables.
** Generate new tables.
FREQUENCIES  Age /HISTOGRAM NORMAL.
EXAMINE VARIABLES=Age
  /PLOT BOXPLOT STEMLEAF.

** check if they are age lower 18 yrs or more than 80 yrs.
TEMPORARY.
SELECT IF Age < 18 OR Age >80 OR SYS (Age).
LIST LineNo Annextype QID CensusNo  Enginepower Age Gender.


** Check gender.
FREQUENCIES Gender.


AUTORECODE VARIABLES=Gender 
  /INTO Sex
  /PRINT.
FREQUENCIES Sex.

TEMPORARY.
SELECT IF Sex < 12.
LIST LineNo Annextype QID CensusNo  Enginepower Age Gender.


***************************************.
** continue to check other variables.
***************************************.

FREQUENCIES  Color.

