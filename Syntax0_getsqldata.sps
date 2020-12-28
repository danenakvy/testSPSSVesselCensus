* Encoding: UTF-8.
SET UNICODE =ON.


**STEP 01 the syntax will work with sql from phpserver and also work with subset of data matching.
**STEP 01 get remaining list.


GET DATA
  /TYPE=XLSX
  /FILE='D:\0GDrive\Cambodia\FiADatabase\database\data\Official_All7552RECODE_forServer.xlsx'
  /SHEET=name 'voldMatchName'
  /CELLRANGE=FULL
  /READNAMES=ON
  /HIDDEN IGNORE=YES.

SORT CASES BY vold_AutoID(A).
RENAME VARIABLES  
(CensusNo = O_CensusNo) 
(NameVesselOwnerKh = O_Name) 
(vold_AutoID = AutoID). 

SAVE OUTFILE='D:\0GDrive\Cambodia\FiADatabase\database\data\xtmp_name1.sav'
 /KEEP AutoID SubmissionID O_CensusNo O_Name.



**STEP 02 Get full list of vessel old server.
** get name of owner list.
*** the syntax can run after setup ODC mysql drive connection
*** setup DSN connection to root of DB and tables.

GET DATA
  /TYPE=ODBC
  /CONNECT='DSN=Dane mysql localhost;'
  /SQL='SELECT * FROM fisheriesmis.vold_vessel_owner'.

** Identify error douplicate.
SORT CASES BY vessel_owner_id(A).
MATCH FILES
  /FILE=*
  /BY vessel_owner_id
  /FIRST=PrimaryFirst
  /LAST=PrimaryLast.
EXECUTE.

INSERT FILE ='D:\0GDrive\Cambodia\FiADatabase\database\data\testSPSSVesselCensus\Syntax0_Batch_DubplicateID.sps'.

** keep only those primary case.
** Exclude 5 cases duplicates.
COMPUTE COUTSTRING=CHAR.LENGTH(vessel_owner_id).
EXECUTE.
IF COUTSTRING = 0 IdexID = 3.
EXECUTE.

SELECT IF IdexID < 2.
SORT CASES BY vessel_owner_id(A).
EXECUTE.



SAVE OUTFILE ='D:\0GDrive\Cambodia\FiADatabase\database\data\xtmp_name1_FullList_vold.sav'
/DROP created_date inputed_by inactive_date inactive_by inactive_reason authorize_status authorize_date authorized_by 
    isActive PrimaryFirst PrimaryLast IdexID InDupGrp  COUTSTRING .



**STEP 03 Get maindata and merge full list.
*** the syntax can run after setup ODC mysql drive connection
*** setup DSN connection to root of DB and tables.

GET DATA
  /TYPE=ODBC
  /CONNECT='DSN=Dane mysql localhost;'
  /SQL='SELECT * FROM fisheriesmis.vold_annex'.

FORMATS  autoID (F4.0).
SORT CASES BY autoID (A).


MATCH FILES
 /FILE = *
 /TABLE ='D:\0GDrive\Cambodia\FiADatabase\database\data\xtmp_name1.sav'
 /BY autoID.
EXECUTE.

SAVE OUTFILE ='D:\0GDrive\Cambodia\FiADatabase\database\data\xtmp_name2_FullList_vold.sav'.
** select only those not in the first matching.
SELECT IF  SYS(SubmissionID).
SORT CASES BY  vessel_owner_id (A).
EXECUTE.


** now let merge name of Owner.
SORT CASES BY  vessel_owner_id (A).
MATCH FILES
 /FILE = *
 /TABLE ='D:\0GDrive\Cambodia\FiADatabase\database\data\xtmp_name1_FullList_vold.sav'
 /BY vessel_owner_id.
EXECUTE.

RENAME VARIABLES 
( AutoID = vold_AutoID).
SORT CASES BY vold_AutoID (A).
  
SAVE OUTFILE ='D:\0GDrive\Cambodia\FiADatabase\database\data\xtmp_name3_FullList_vold.sav'
/DROP SubmissionID O_CensusNo O_Name.

** select only some info for matching with official.
GET FILE ='D:\0GDrive\Cambodia\FiADatabase\database\data\xtmp_name3_FullList_vold.sav'
     /KEEP  vold_AutoID recorder_id census_no  power_vessel  vessel_owner_kh vessel_owner_en DOB IDNo gender phone Email province_id district_id commune_id 
    village_id address.

** count only those with info.
COMPUTE COUTSTRING=CHAR.LENGTH(vessel_owner_kh).
FREQUENCIES COUTSTRING.
SELECT IF COUTSTRING > 0.
EXECUTE.

** now let check duplicate key varaible censusNo, Name and power.

** check duplicate ID.
** Identify error douplicate (in this case exclude power due to only owner power_vessel  (A).
SORT CASES BY  census_no (A) vessel_owner_kh (A) .
MATCH FILES
  /FILE=*
  /BY census_no  vessel_owner_kh
  /FIRST=PrimaryFirst
  /LAST=PrimaryLast.
EXECUTE.

INSERT FILE ='D:\0GDrive\Cambodia\FiADatabase\database\data\testSPSSVesselCensus\Syntax0_Batch_DubplicateID.sps'.

** keep only primary cases.
SELECT IF  IdexID < 2.
EXECUTE.

RENAME VARIABLES
(census_no = CensusNo)
(vessel_owner_kh = NameOwer)
(power_vessel = Power_HP).
ALTER TYPE CensusNo (A50).
ALTER TYPE NameOwer (A50).
ALTER TYPE Power_HP (A50).

SORT CASES BY CensusNo (A) NameOwer (A) Power_HP(A) .

SAVE OUTFILE ='D:\0GDrive\Cambodia\FiADatabase\database\data\xtmp_name4_FullList_vold.sav'
 /DROP  COUTSTRING PrimaryFirst PrimaryLast IdexID InDupGrp.

 



** STEP 04 Get oritinal 7552 from server.
** filter those not have full name.

GET DATA
  /TYPE=ODBC
  /CONNECT='DSN=Dane mysql localhost;'
  /SQL='SELECT * FROM fisheriesmis.ft_vesselform_3'.

FREQUENCIES q1_1Sex.
SELECT IF q1_1Sex = "".
EXECUTE.

** select only those important var to match with old server.
SAVE OUTFILE ='D:\0GDrive\Cambodia\FiADatabase\database\data\xtmp_official2_.sav'
/KEEP submission_id  NameRecorderEN  Interviewprovince Interviewdistrict Interviewcommune Interviewvillage CensusNo NameVesselOwnerKH q2_1.


GET FILE ='D:\0GDrive\Cambodia\FiADatabase\database\data\xtmp_official2_.sav'.


** it is important to check duplciate but let leave as it is. 
** more important to find those key this variable from old server.

RENAME VARIABLES
(  NameVesselOwnerKH = NameOwer)
( q2_1 = Power_HP).
ALTER TYPE CensusNo (A50).
ALTER TYPE NameOwer (A50).
ALTER TYPE Power_HP (A50).

SORT CASES BY CensusNo (A) NameOwer (A) Power_HP(A) .
MATCH FILES
    /FILE = *
    /TABLE ='D:\0GDrive\Cambodia\FiADatabase\database\data\xtmp_name4_FullList_vold.sav'
    /BY  CensusNo NameOwer.
EXECUTE.

** list person can find.
SORT CASES BY  NameRecorderEN (A).
SORT CASES BY vold_AutoID (D).

*====================================================================.
SAVE TRANSLATE OUTFILE='D:\0GDrive\Cambodia\FiADatabase\database\data\xtmp_Official_missing.xlsx' 
  /TYPE=XLS 
  /VERSION=12 
  /FIELDNAMES VALUE=NAMES 
  /CELLS=LABELS 
  /REPLACE.

SORT CASES BY  vold_AutoID (A).
SAVE OUTFILE='D:\0GDrive\Cambodia\FiADatabase\database\data\xtmp_Official_missing.sav'.


** construct variables and identify duplicate case found in official.
** construct variables and identify duplicate case found in official.
** construct variables and identify duplicate case found in official.

GET FILE='D:\0GDrive\Cambodia\FiADatabase\database\data\xtmp_Official_missing.sav'
/KEEP vold_AutoID submission_id.
SORT CASES BY vold_AutoID (A).
SELECT IF vold_AutoID > 0.
EXECUTE.

** now let check duplicate key varaible censusNo, Name and power.
** check duplicate ID.
** Identify error douplicate (in this case exclude power due to only owner power_vessel  (A).
SORT CASES BY vold_AutoID(A) .
MATCH FILES
  /FILE=*
  /BY vold_AutoID
  /FIRST=PrimaryFirst
  /LAST=PrimaryLast.
EXECUTE.

INSERT FILE ='D:\0GDrive\Cambodia\FiADatabase\database\data\testSPSSVesselCensus\Syntax0_Batch_DubplicateID.sps'.

VALUE LABELS  InDupGrp 1'Duplicate'.
SELECT IF IdexID < 2.
SORT CASES BY vold_AutoID(A) .
EXECUTE.
SAVE OUTFILE ='D:\0GDrive\Cambodia\FiADatabase\database\data\xtmp_Official_missing_seeID.sav'
 /DROP PrimaryFirst PrimaryLast IdexID .



** STEP 5 get file those not in the missing.
GET FILE='D:\0GDrive\Cambodia\FiADatabase\database\data\xtmp_name4_FullList_vold.sav'.
SORT CASES BY vold_AutoID (A).
MATCH FILES 
 /FILE = *
 /TABLE ='D:\0GDrive\Cambodia\FiADatabase\database\data\xtmp_Official_missing_seeID.sav'
 /BY vold_AutoID.
EXECUTE.

SORT CASES BY  InDupGrp (D).

RENAME VARIABLES
(village_id = VillageCode).
ALTER TYPE VillageCode (A8).
EXECUTE.

SORT CASES BY VillageCode (A).
** get village label.
MATCH FILES
 /FILE = * 
 /TABLE ='D:\0GDrive\Cambodia\FiADatabase\database\data\location_village.sav'
 /BY VillageCode.
EXECUTE.

VALUE LABELS  recorder_id
    0 'N/A'
    1 'Chea Tharith'
    2 'Chin Pich'
    3 'Samreth Sambo'
    4 'Kong Kimyan'
    5 'Hay Sarun'
    6 'Tan Thearith                                           '
    7 'Chhuon Kimchhea     '
    8 'Leng Sam Ath            '
    9 'Ky Vannarith'
    10 'Hem Rady'
    11 'Liang Saroeun'
    12 'Tun Ketputhearith'
    13 'Gnin Kamsan'
    14 'Mok Sotheara'
    15 'Pen Sereyvuthy'
    16 'Chin Leakhena           '
    17 'Our Chanthea'
    18 'Ku Huoyliang           '
    19 'Un Veng'
    20 'Buoy Kheng'
    21 'Kha Ith'
    22 'Sok Sambo'
    23 'Yin Tangsy'
    24 'Seun Say'
    25 'Neng Chivan'
    26 'Hean Kung'
    1.1 'Hom Radong'
    7.1 'Sum Kong'
    9.1 'Khem Heng'
    16.1 'Aing Sokevpheaktra '
    18.1 'Ming Khign'
    21.1 'Lang Sarath'
    22.1 'Oum Sakada'.

FREQUENCIES  recorder_id.


SORT CASES BY recorder_id (A).
SORT CASES BY submission_id (A).

SAVE OUTFILE='D:\0GDrive\Cambodia\FiADatabase\database\data\xtmp_name4_FullList_vold.sav'
    /KEEP  vold_AutoID recorder_id  ProvinceNameKh DistrictNameKh CommuneNameKh VillageNameKh
    CensusNo Power_HP NameOwer vessel_owner_en DOB IDNo gender phone Email province_id district_id commune_id
    VillageCode address submission_id.
*====================================================================.
SAVE TRANSLATE OUTFILE='D:\0GDrive\Cambodia\FiADatabase\database\data\xtmp_name4_FullList_vold.xlsx'
    /KEEP  vold_AutoID recorder_id  ProvinceNameKh DistrictNameKh CommuneNameKh VillageNameKh
   CensusNo Power_HP NameOwer vessel_owner_en DOB IDNo gender phone Email province_id district_id commune_id
    VillageCode address submission_id
    /TYPE=XLS
    /VERSION=12
    /FIELDNAMES VALUE=NAMES
    /CELLS=LABELS
    /REPLACE.


