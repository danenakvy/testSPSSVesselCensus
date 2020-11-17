* Encoding: UTF-8.
**Mapping Server and Data.


** construct all datafile to SPSS formate.
** To mapping ID, require identify unique ID OwnerID data and MasterID Tables.

*************************************************************.
GET FILE = 'D:\0GDrive\Cambodia\FiADatabase\database\data\ServerVesselCensus.sav'.
** Get master List.
GET DATA
  /TYPE=XLSX
  /FILE='D:\0GDrive\Cambodia\FiADatabase\database\Export\ServerDataRetrieved.xlsx'
  /SHEET=name 'tbl_master'
  /CELLRANGE=FULL
  /READNAMES=ON.
EXECUTE.

FORMATS village_id (F8.0).
SAVE OUTFILE='D:\0GDrive\Cambodia\FiADatabase\database\Data\ServerVesselCensusMasterList.sav'.


** list missing value on nationality.
** list missing value on nationality.
** list missing value on nationality.
TEMPORARY.
SELECT IF national_id ="".
LIST  master_id  age  gender village_id  national_id.




** Get Owner List.
GET DATA
  /TYPE=XLSX
  /FILE='D:\0GDrive\Cambodia\FiADatabase\database\Export\ServerDataRetrieved.xlsx'
  /SHEET=name 'tbl_vessel_owner'
  /CELLRANGE=FULL
  /READNAMES=ON.
EXECUTE.

SAVE OUTFILE='D:\0GDrive\Cambodia\FiADatabase\database\Data\ServerVesselCensusOwnerList.sav'.









*************************************************************.
GET FILE = 'D:\0GDrive\Cambodia\FiADatabase\database\data\ServerVesselCensus.sav'.

FORMATS interview_village_id (F8.0).

** Check Village missing.
TEMPORARY.
SELECT IF SYS(interview_village_id).
LIST autoID annex_type vessel_owner_id census_no interview_village_id.




** Identify error douplicate.
SORT CASES BY Annex_type(A) interview_village_id(A)  census_no(A).
MATCH FILES
  /FILE=*
  /BY Annex_type interview_village_id census_no
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


***************** the village based.







*****************************************************************************************************.
GET FILE = 'D:\0GDrive\Cambodia\FiADatabase\database\data\ROfficial_All7552.sav'.

SORT CASES BY  Annextype(A)  Interviewprovince(A)  Interviewdistrict(A)  Interviewcommune(A)  Interviewvillage(A)  CensusNo(A).

MATCH FILES
  /FILE=*
  /BY Annextype  Interviewprovince  Interviewdistrict  Interviewcommune  Interviewvillage  CensusNo
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

SAVE TRANSLATE OUTFILE='D:\0GDrive\Cambodia\FiADatabase\database\data\zChekDuplicate_MatchVillagIDCensusID.xlsx' 
  /TYPE=XLS 
  /VERSION=12 
  /FIELDNAMES VALUE=NAMES 
  /CELLS=LABELS 
  /REPLACE.


