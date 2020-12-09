* Encoding: UTF-8.
** ConvertDataSet Sever to SPSS.

GET DATA
  /TYPE=XLSX
  /FILE='D:\0GDrive\Cambodia\FiADatabase\database\Export\ServerDataRetrieved.xlsx'
  /SHEET=name 'tbl_province'
  /CELLRANGE=FULL
  /READNAMES=ON.
EXECUTE.
SORT CASES BY province_code (A).
SAVE OUTFILE='D:\0GDrive\Cambodia\FiADatabase\database\Data\zServerProvince.sav'/DROP od.


GET DATA
  /TYPE=XLSX
  /FILE='D:\0GDrive\Cambodia\FiADatabase\database\Export\ServerDataRetrieved.xlsx'
  /SHEET=name 'tbl_district'
  /CELLRANGE=FULL
  /READNAMES=ON.
EXECUTE.
SORT CASES BY district_code (A).
SAVE OUTFILE='D:\0GDrive\Cambodia\FiADatabase\database\Data\zServerDistrict.sav'/DROP od.


GET DATA
  /TYPE=XLSX
  /FILE='D:\0GDrive\Cambodia\FiADatabase\database\Export\ServerDataRetrieved.xlsx'
  /SHEET=name 'tbl_commune'
  /CELLRANGE=FULL
  /READNAMES=ON.
EXECUTE.
SORT CASES BY commune_code (A).
SAVE OUTFILE='D:\0GDrive\Cambodia\FiADatabase\database\Data\zServerCommune.sav'/DROP od.



GET DATA
  /TYPE=XLSX
  /FILE='D:\0GDrive\Cambodia\FiADatabase\database\Export\ServerDataRetrieved.xlsx'
  /SHEET=name 'tbl_village'
  /CELLRANGE=FULL
  /READNAMES=ON.
EXECUTE.
ALTER TYPE village_code (F8.0).
ALTER TYPE commune_code (F6.0).
SORT CASES BY commune_code (A) village_code(A).

MATCH FILES
 /FILE = *
 /TABLE ='D:\0GDrive\Cambodia\FiADatabase\database\Data\zServerCommune.sav' 
 /BY commune_code.
SORT CASES BY district_code (A).
EXECUTE.


MATCH FILES
 /FILE = *
 /TABLE ='D:\0GDrive\Cambodia\FiADatabase\database\Data\zServerDistrict.sav' 
 /BY district_code.
SORT CASES BY province_code (A).
EXECUTE.


MATCH FILES
 /FILE = *
 /TABLE ='D:\0GDrive\Cambodia\FiADatabase\database\Data\zServerProvince.sav' 
 /BY province_code.
EXECUTE.

SELECT IF province_code = 9 OR province_code = 18 OR province_code = 7 OR province_code = 23. 
SELECT IF village_code > 1000000.

EXECUTE.

ALTER TYPE province_name_kh (A50).
ALTER TYPE district_name_kh (A50).
ALTER TYPE commune_name_kh (A50).
ALTER TYPE village_name_kh (A100).
EXECUTE.

SORT CASES BY province_name_kh(A) district_name_kh(A) commune_name_kh(A) village_name_kh(A).

SAVE OUTFILE='D:\0GDrive\Cambodia\FiADatabase\database\Data\zServerVillages.sav'
    /KEEP province_code district_code commune_code village_code
    province_name_en district_name_en commune_name_en village_name_en
    province_name_kh district_name_kh commune_name_kh village_name_kh.


