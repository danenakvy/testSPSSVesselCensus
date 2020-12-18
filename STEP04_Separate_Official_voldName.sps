* Encoding: UTF-8.
** working with Name list of vold server and official data.

***working with Result2 of Metabase Output xlsx.
GET DATA
  /TYPE=XLSX
  /FILE='D:\0GDrive\Cambodia\FiADatabase\database\Export\Metabase_Result2_CensusNo_Official_Vs_OldServerOwnerID.xlsx'
  /SHEET=name 'Result2'
  /CELLRANGE=FULL
  /READNAMES=ON.
EXECUTE.
SAVE OUTFILE='D:\0GDrive\Cambodia\FiADatabase\database\Data\xMetabase_R2_CensusID.sav'.


** Identify error douplicate.
SORT CASES BY  vold_AutoID(A) vold_CensusNo(A).
MATCH FILES
  /FILE=*
  /BY  vold_AutoID vold_CensusNo
  /FIRST=PrimaryFirst
  /LAST=PrimaryLast.
EXECUTE.

INSERT FILE = 'D:\0GDrive\Cambodia\FiADatabase\database\Data\testSPSSVesselCensus\Syntax0_Batch_DubplicateID.sps'.


*********************************************************.
*********************************************************.
*** Create only those not duplicate CensusID.
*********************************************************.
*********************************************************.
SELECT IF  InDupGrp = 0.
EXECUTE.
SAVE OUTFILE ='D:\0GDrive\Cambodia\FiADatabase\database\data\xMetabase_R2_CensusID_NotDuplciate.sav'. 

SAVE TRANSLATE OUTFILE='D:\0GDrive\Cambodia\FiADatabase\database\data\xMetabase_R2_CensusID_NotDuplciate.xlsx' 
  /TYPE=XLS 
  /VERSION=12 
  /FIELDNAMES VALUE=NAMES 
  /CELLS=LABELS 
  /REPLACE.
*====================================================================.
*====================================================================.
*====================================================================.





*********************************************************.
*********************************************************.
*** Create those duplicate CensusID.
*********************************************************.
*********************************************************.
GET FILE='D:\0GDrive\Cambodia\FiADatabase\database\Data\xMetabase_R2_CensusID.sav'.

** Identify error douplicate.
SORT CASES BY  vold_AutoID(A) vold_CensusNo(A).
MATCH FILES
  /FILE=*
  /BY  vold_AutoID vold_CensusNo
  /FIRST=PrimaryFirst
  /LAST=PrimaryLast.
EXECUTE.

INSERT FILE = 'D:\0GDrive\Cambodia\FiADatabase\database\Data\testSPSSVesselCensus\Syntax0_Batch_DubplicateID.sps'.

SELECT IF  InDupGrp = 1.
SORT CASES BY  SubmissionID.
SAVE TRANSLATE OUTFILE='D:\0GDrive\Cambodia\FiADatabase\database\data\xMetabase_R2_CensusID_Duplciate.xlsx' 
  /TYPE=XLS 
  /VERSION=12 
  /FIELDNAMES VALUE=NAMES 
  /CELLS=LABELS 
  /REPLACE.
*====================================================================.
*====================================================================.
*====================================================================.





***working with Result1 of Metabase Output xlsx.
*** Start with vold main data on tbl_annex and name list.

***working with Result2 of Metabase Output xlsx.
GET DATA
  /TYPE=XLSX
  /FILE='D:\0GDrive\Cambodia\FiADatabase\database\Export\Metabase_Result1_all_OldServerOwnerIDName7239.xlsx'
  /SHEET=name 'vold_result1_7246vsName7239'
  /CELLRANGE=FULL
  /READNAMES=ON.
EXECUTE.

FORMATS  vold_AutoID (F5.0).

MATCH FILES
    /FILE = *
    /TABLE ='D:\0GDrive\Cambodia\FiADatabase\database\data\xMetabase_R2_CensusID_NotDuplciate.sav'
    /BY  vold_AutoID.
EXECUTE.


SAVE OUTFILE ='D:\0GDrive\Cambodia\FiADatabase\database\data\xMetabase_Official_Name_NotDuplciate.sav'
 /KEEP SubmissionID CensusNo  V_Code  NameVesselOwnerKh VesselOwnerID Provincial
  R2_OwnerID vold_AutoID TO  R1_CreatedDate  R2_OwnerID TO  InDupGrp.
SAVE TRANSLATE OUTFILE='D:\0GDrive\Cambodia\FiADatabase\database\data\xMetabase_Official_Name_NotDuplciate.xlsx'
    /KEEP SubmissionID CensusNo  V_Code  NameVesselOwnerKh VesselOwnerID Provincial
    R2_OwnerID vold_AutoID TO  R1_CreatedDate  R2_OwnerID TO  InDupGrp
    /TYPE=XLS
    /VERSION=12
    /FIELDNAMES VALUE=NAMES
    /CELLS=LABELS
    /REPLACE.
*====================================================================.
*====================================================================.
*====================================================================.


   



