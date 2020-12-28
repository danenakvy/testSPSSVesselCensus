* Encoding: UTF-8.
** work with old location village database.

GET DATA
  /TYPE=XLSX
  /FILE='D:\0GDrive\Cambodia\FiADatabase\database\Export\code_Villagecode.xlsx'
  /SHEET=name 'VillageCODE'
  /CELLRANGE=FULL
  /READNAMES=ON
  /HIDDEN IGNORE=YES.


** check duplicate ID.
SORT CASES BY  VillageCode(A) .
MATCH FILES
  /FILE=*
  /BY VillageCode
  /FIRST=PrimaryFirst
  /LAST=PrimaryLast.
EXECUTE.

INSERT FILE ='D:\0GDrive\Cambodia\FiADatabase\database\data\testSPSSVesselCensus\Syntax0_Batch_DubplicateID.sps'.

SAVE OUTFILE ='D:\0GDrive\Cambodia\FiADatabase\database\data\location_village.sav'
 /KEEP  VillageCode  ProvinceNameKh ProvinceNameEn  DistrictNameKh DistrictNameEn
  CommuneNameKh CommuneNameEn  VillageNameKh VillageNameEn.


*====================================================================.
SAVE TRANSLATE OUTFILE=='D:\0GDrive\Cambodia\FiADatabase\database\data\location_village.xlsx'
    /KEEP  VillageCode ProvinceNameKh ProvinceNameEn  DistrictNameKh DistrictNameEn
    CommuneNameKh CommuneNameEn  VillageNameKh VillageNameEn
    /TYPE=XLS
    /VERSION=12
    /FIELDNAMES VALUE=NAMES
    /CELLS=LABELS
    /REPLACE.


