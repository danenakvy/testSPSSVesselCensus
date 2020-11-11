* Encoding: UTF-8.
** based on final dataset Based on 7552.


GET DATA
  /TYPE=XLSX
  /FILE='D:\0GDrive\Cambodia\FiADatabase\database\Export\1_AllV_15ct2019_Final_2020.xlsx'
  /SHEET=name 'AllDatasets'
  /CELLRANGE=FULL
  /READNAMES=ON.
EXECUTE.
ALTER TYPE vessel_owner_id (F18.0).
SAVE OUTFILE='D:\0GDrive\Cambodia\FiADatabase\database\Data\ROfficial_All7552.sav'.

FREQUENCIES Annextype  CensusNo Enginepower NameVesselOwnerKH.



*************************************************************.
** TO IDENTIFY UNIQUE ID Consider 3 Step.
** TO IDENTIFY UNIQUE ID Consider 3 Step.


*** STEP1. work for 4 key varis.
*** STEP1. work for 4 key varis.
**Annextype(A) CensusNo(A)  Enginepower(A)  QID(A).

******** if i run with qid as basis.
******** if i run with qid as basis.
******** if i run with qid as basis.

GET FILE='D:\0GDrive\Cambodia\FiADatabase\database\Data\ROfficial_All7552.sav'.

** Identify error douplicate.
SORT CASES BY Annextype(A) CensusNo(A)  Enginepower(A)  QID(A).
MATCH FILES
  /FILE=*
  /BY Annextype CensusNo Enginepower QID
  /FIRST=PrimaryFirst
  /LAST=PrimaryLast.
EXECUTE.

DO IF (PrimaryFirst).
 COMPUTE  IdexID=1-PrimaryLast.
 ELSE.
 COMPUTE  IdexID=IdexID+1.
END IF.
LEAVE  IdexID.
EXECUTE.

FORMATS  IdexID (f7).
COMPUTE  InDupGrp=IdexID>0.
SORT CASES InDupGrp(D).
EXECUTE.

VARIABLE LABELS  PrimaryLast 'Indicator of each last matching case as Primary'.
VALUE LABELS  PrimaryLast 0 'Duplicate Case' 1 'Primary Case'.
VARIABLE LEVEL  PrimaryLast (ORDINAL).
FREQUENCIES PrimaryLast.
EXECUTE.

** all dataset with paire and duplicate.
SELECT IF InDupGrp =1.
EXECUTE.






*************************************************************.
*** STEP2. work for 4 key varis replace QID with name.
*** STEP2. work for 4 key varis replace QID with name.
**Annextype(A) CensusNo(A)  Enginepower(A)  NameVesselOwnerKH(A)..


GET FILE='D:\0GDrive\Cambodia\FiADatabase\database\Data\ROfficial_All7552.sav'.

SORT CASES BY Annextype(A) CensusNo(A)  Enginepower(A)  NameVesselOwnerKH(A).
MATCH FILES
  /FILE=*
  /BY Annextype CensusNo Enginepower NameVesselOwnerKH
  /FIRST=PrimaryFirst
  /LAST=PrimaryLast.
EXECUTE.

DO IF (PrimaryFirst).
 COMPUTE  IdexID=1-PrimaryLast.
 ELSE.
 COMPUTE  IdexID=IdexID+1.
END IF.
LEAVE  IdexID.
EXECUTE.

FORMATS  IdexID (f7).
COMPUTE  InDupGrp=IdexID>0.
SORT CASES InDupGrp(D).
EXECUTE.

VARIABLE LABELS  PrimaryLast 'Indicator of each last matching case as Primary'.
VALUE LABELS  PrimaryLast 0 'Duplicate Case' 1 'Primary Case'.
VARIABLE LEVEL  PrimaryLast (ORDINAL).
FREQUENCIES PrimaryLast.
EXECUTE.

** all dataset with paire and duplicate.
SELECT IF InDupGrp =1.
EXECUTE.
 * SAVE TRANSLATE OUTFILE='D:\0GDrive\Cambodia\FiADatabase\database\data\zChekDuplicate_AllDataset.xlsx' 
  /TYPE=XLS 
  /VERSION=12 
  /FIELDNAMES VALUE=NAMES 
  /CELLS=LABELS 
  /REPLACE.



*************************************************************.
*** STEP3. work for 4 key varis replace QID with name.
*** STEP3. work for 4 key varis replace QID with name.
**Annextype(A) CensusNo(A)  Enginepower(A) ..

GET FILE='D:\0GDrive\Cambodia\FiADatabase\database\Data\ROfficial_All7552.sav'.
** Identify error douplicate.
SORT CASES BY Annextype(A) CensusNo(A)  Enginepower(A).
MATCH FILES
  /FILE=*
  /BY Annextype CensusNo Enginepower 
  /FIRST=PrimaryFirst
  /LAST=PrimaryLast.
EXECUTE.

DO IF (PrimaryFirst).
 COMPUTE  IdexID=1-PrimaryLast.
 ELSE.
 COMPUTE  IdexID=IdexID+1.
END IF.
LEAVE  IdexID.
EXECUTE.

FORMATS  IdexID (f7).
COMPUTE  InDupGrp=IdexID>0.
SORT CASES InDupGrp(D).
EXECUTE.

VARIABLE LABELS  PrimaryLast 'Indicator of each last matching case as Primary'.
VALUE LABELS  PrimaryLast 0 'Duplicate Case' 1 'Primary Case'.
VARIABLE LEVEL  PrimaryLast (ORDINAL).
FREQUENCIES PrimaryLast.
EXECUTE.

** all dataset with paire and duplicate.
SELECT IF InDupGrp =1.
EXECUTE.
 * SAVE TRANSLATE OUTFILE='D:\0GDrive\Cambodia\FiADatabase\database\data\zChekDuplicate_AllDataset.xlsx' 
  /TYPE=XLS 
  /VERSION=12 
  /FIELDNAMES VALUE=NAMES 
  /CELLS=LABELS 
  /REPLACE.



*** the conclusion for now, using first one option.
**Reason possible they can have same name, same colore, same machine but diff.


