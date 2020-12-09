* Encoding: UTF-8.
** work with OfficialData and SeverData.
** work with OfficialData and SeverData.

**+++++++++++++++ need more work on this.


*************************************************************.
GET FILE='D:\0GDrive\Cambodia\FiADatabase\database\Data\ROfficial_All7552.sav'
    /KEEP LineNo Annextype Enginepower QID
    MasternameEN
    Age
    Gender
    Provincemaster
    Districtmaster
    Communemaster
    Villagemaster
    vessel_owner_id
    Interviewprovince
    Interviewdistrict
    Interviewcommune
    Interviewvillage
    CensusNo
    Mastername
    NameVesselOwnerKH.
** Identify error douplicate.
SORT CASES BY Interviewprovince(A) Interviewdistrict(A) Interviewcommune(A)  Interviewvillage(A) CensusNo(A) Mastername(A).
MATCH FILES
  /FILE=*
  /BY Interviewprovince Interviewdistrict Interviewcommune  Interviewvillage CensusNo Mastername
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

*** create profile to match with sever using interview village and master and census.
SAVE TRANSLATE OUTFILE='D:\0GDrive\Cambodia\FiADatabase\database\data\zChek31Profiles7552.xlsx' 
  /TYPE=XLS 
  /VERSION=12 
  /FIELDNAMES VALUE=NAMES 
  /CELLS=LABELS 
  /REPLACE.



*Server*************************************************************.
*Server*************************************************************.
*Server*************************************************************.
**Server with MasterList.
GET FILE='D:\0GDrive\Cambodia\FiADatabase\database\Data\ServerVesselCensus.sav'
    /KEEP autoID recorder_id questionaire_id   
      vessel_owner_id vessel_id  master_id 
     date_census annex_type  interview_village_id census_no.

COMPUTE village_code = interview_village_id.
FORMATS interview_village_id village_code (F8.0).


** Identify error douplicate.
SORT CASES BY annex_type(A) interview_village_id(A) census_no(A).
MATCH FILES
  /FILE=*
  /BY annex_type  interview_village_id census_no
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





** interview Villageas
* Count number of village will be work on*************************************************************.
* Test Villages based Data*************************************************************.
GET FILE='D:\0GDrive\Cambodia\FiADatabase\database\Data\ServerVesselCensus.sav'
    /KEEP autoID questionaire_id annex_type interview_village_id census_no.

FORMATS interview_village_id (F8.0).


SORT CASES BY interview_village_id(A) census_no (A).

** Identify error douplicate.
 * SORT CASES BY interview_village_id(A) .
MATCH FILES
  /FILE=*
  /BY interview_village_id
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


