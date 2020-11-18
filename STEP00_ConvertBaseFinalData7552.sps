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
