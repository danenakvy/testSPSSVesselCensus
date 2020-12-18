* Encoding: UTF-8.
** ConvertDataSet Sever to SPSS.
** 6 Datasets will creates.


**Data1 Master or driver*************************************************************
**Data1 Master or driver*************************************************************..
GET DATA
  /TYPE=XLSX
  /FILE='D:\0GDrive\Cambodia\FiADatabase\database\Export\ServerDataRetrieved.xlsx'
  /SHEET=name 'tbl_master'
  /CELLRANGE=FULL
  /READNAMES=ON.
EXECUTE.
FORMATS village_id (F8.0).
SAVE OUTFILE='D:\0GDrive\Cambodia\FiADatabase\database\Data\ServerVesselCensusMasterList.sav'.


**Data2 The Owner of Vessel**********************************************************************.
**Data2 The Owner of Vessel**********************************************************************.
GET DATA
  /TYPE=XLSX
  /FILE='D:\0GDrive\Cambodia\FiADatabase\database\Export\ServerDataRetrieved.xlsx'
  /SHEET=name 'tbl_vessel_owner'
  /CELLRANGE=FULL
  /READNAMES=ON.
EXECUTE.
SAVE OUTFILE='D:\0GDrive\Cambodia\FiADatabase\database\Data\ServerVesselCensusOwnerList.sav'.


**Data3 PortData with Location**********************************************************************.
**Data3 PortData with Location**********************************************************************.
GET DATA
  /TYPE=XLSX
  /FILE='D:\0GDrive\Cambodia\FiADatabase\database\Export\ServerDataRetrieved.xlsx'
  /SHEET=name 'tbl_port'
  /CELLRANGE=FULL
  /READNAMES=ON.
EXECUTE.
SAVE OUTFILE='D:\0GDrive\Cambodia\FiADatabase\database\Data\ServerVesselCensusPort.sav'
    /DROP create_date
    inputed_by
    inactive_date
    inactive_by
    inactive_reason
    isActive.


**Data4 Equipment or tool use with classification********************************************************.
**Data4 Equipment or tool use with classification********************************************************.
GET DATA
  /TYPE=XLSX
  /FILE='D:\0GDrive\Cambodia\FiADatabase\database\Export\ServerDataRetrieved.xlsx'
  /SHEET=name 'tbl_equipment'
  /CELLRANGE=FULL
  /READNAMES=ON.
EXECUTE.
SAVE OUTFILE='D:\0GDrive\Cambodia\FiADatabase\database\Data\ServerVesselCensusEquipment.sav'
    /DROP create_date
    inputed_by
    inactive_date
    inactive_by
    inactive_reason
    isActive.


**Data5 Type of Equipment**********************************************************************.
**Data5 Type of Equipment**********************************************************************.
GET DATA
  /TYPE=XLSX
  /FILE='D:\0GDrive\Cambodia\FiADatabase\database\Export\ServerDataRetrieved.xlsx'
  /SHEET=name ' tbl_equipment_type'
  /CELLRANGE=FULL
  /READNAMES=ON.
EXECUTE.
SAVE OUTFILE='D:\0GDrive\Cambodia\FiADatabase\database\Data\ServerVesselCensusTypeEquipment.sav'.


**Data5 Main Dataset**********************************************************************.
**Data5 Main Dataset**********************************************************************.
** based on discussion with SamAth 10Dec2020 and MrRoitana, we cant update any
the purpose of this data for tax registration, work on key prioritize field and merge base cenus.

GET DATA
  /TYPE=XLSX
  /FILE='D:\0GDrive\Cambodia\FiADatabase\database\Export\ServerDataRetrieved.xlsx'
  /SHEET=name 'tbl_annex'
  /CELLRANGE=FULL
  /READNAMES=ON.
EXECUTE.
FORMATS interview_village_id (F8.0).
SAVE OUTFILE='D:\0GDrive\Cambodia\FiADatabase\database\Data\ServerVesselCensus.sav'.







