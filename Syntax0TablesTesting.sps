* Encoding: UTF-8.
** base on assumption correct QID step1.


*************************************************************.
*** STEP1. work for 4 key varis.
*** STEP1. work for 4 key varis.
**Annextype(A) CensusNo(A)  Enginepower(A)  QID(A).

GET FILE='D:\0GDrive\Cambodia\FiADatabase\database\Data\ROfficial_All7552.sav'.

*Table 2. Number of fishing vessels and none fishing vessel.
** Using ProCode as province predefine.
FREQUENCIES  Pro.Code.

AUTORECODE VARIABLES=Pro.Code 
  /INTO Province
  /PRINT.
VALUE LABELS Province 1'KK' 2'KS' 3'KP' 4'K'.
FREQUENCIES Province.

STRING ProCensusNo (A20).
RECODE CensusNo (ELSE=COPY) INTO  ProCensusNo.
ALTER TYPE ProCensusNo (A2).
FREQUENCIES ProCensusNo.
RECODE ProCensusNo ('Kk' = 'KK').
FREQUENCIES ProCensusNo.

** check result both code.
CROSSTABS ProCensusNo BY Province.


*Table 2. Number of fishing vessels and none fishing vessel.
** Using ProCode as province predefine.
*Table 4. Total of marine fishing vessel in number and percentage.
FREQUENCIES  Province.


*Table 5. Marine fishing vessel classified by total length.
FREQUENCIES Totallenght /HISTOGRAM NORMAL.

* check outlier.
EXAMINE VARIABLES=Totallenght
  /PLOT BOXPLOT STEMLEAF.

** check if they are 24m+.
TEMPORARY.
SELECT IF Totallenght >= 24.
LIST LineNo Annextype QID CensusNo  Enginepower Totallenght.

RECODE Totallenght (LO THRU 11.99=1 ) (12 THRU 23.99=2) (24 THRU HI=3) INTO  rcTotallenght.

RECODE Totallenght (LO THRU 11.50=1 ) (11.51 THRU 23.50=2) (23.51 THRU HI=3) INTO  rcTotallenght_50.

VALUE LABELS rcTotallenght rcTotallenght_50 
    1 '1-<12' 
    2 '13-<24' 
    3 '>=24'.
FREQUENCIES rcTotallenght rcTotallenght_50/BARCHART /PIECHART.


*Table 6. Marine fishing vessel classify by total length classes.
RECODE Totallenght (LO THRU 5.99=1 )  (6 THRU 11.99=2) (12 THRU 17.99=3)
 (18 THRU 23.99=4) (24 THRU HI=5) INTO  rcTotallenght_T6.
VALUE LABELS rcTotallenght_T6
    1 '1-<6'
    2 '6-<12'
    3 '12-<18'
    4 '18-<24'
    5 '>=24'.
CROSSTABS rcTotallenght_T6 BY Province /BARCHART.

CROSSTABS Province BY rcTotallenght_T6 /BARCHART.



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

