* Encoding: UTF-8.
** based on final dataset Based on 7552.

** work with interviewVillage and provide code.
** work with interviewVillage and provide code.
** work with interviewVillage and provide code.


** the code province code, district code, commune code and village code.
** the code province code, district code, commune code and village code.


GET FILE='D:\0GDrive\Cambodia\FiADatabase\database\Data\ROfficial_All7552.sav'
 /KEEP LineNo  Annextype CensusNo QID  Interviewprovince Interviewdistrict Interviewcommune Interviewvillage .

** Rename of interview location to match with administrative.
** Rename of interview location to match with administrative.

RENAME VARIABLES (Interviewprovince=province_name_kh).
RENAME VARIABLES (Interviewdistrict= district_name_kh).
RENAME VARIABLES (Interviewcommune=commune_name_kh).
RENAME VARIABLES (Interviewvillage=village_name_kh ).


ALTER TYPE province_name_kh (A50).
ALTER TYPE district_name_kh (A50).
ALTER TYPE commune_name_kh (A50).
ALTER TYPE village_name_kh (A100).


SORT CASES BY 
province_name_kh (A)
district_name_kh (A)
commune_name_kh (A)
village_name_kh (A).

MATCH FILES 
 /FILE= *
 /TABLE ='D:\0GDrive\Cambodia\FiADatabase\database\Data\zServerVillages.sav'
 /BY  province_name_kh district_name_kh commune_name_kh village_name_kh.
EXECUTE.

SORT CASES BY  LineNo (A).
EXECUTE.

FREQUENCIES  province_name_en.

SAVE TRANSLATE OUTFILE='D:\0GDrive\Cambodia\FiADatabase\database\data\zChek_Base7552_VillageCode.xlsx' 
  /TYPE=XLS 
  /VERSION=12 
  /FIELDNAMES VALUE=NAMES 
  /CELLS=LABELS 
  /REPLACE.


