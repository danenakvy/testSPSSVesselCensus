* Encoding: UTF-8.


GET DATA
  /TYPE=XLSX
  /FILE='D:\0GDrive\Cambodia\FiADatabase\database\data\DOB_Format.xlsx'
  /SHEET=name 'DOB'
  /CELLRANGE=FULL
  /READNAMES=ON
  /DATATYPEMIN PERCENTAGE=95.0
  /HIDDEN IGNORE=YES.

STRING ConvertDOB (A10).
COMPUTE ConvertDOB = DOB.
EXECUTE.



* Define Variable Properties.
*ConvertDOB.
ALTER TYPE  ConvertDOB(ADATE10).
FORMATS  ConvertDOB(ADATE10).
FORMATS  ConvertDOB(SDATE10).
EXECUTE.


SAVE TRANSLATE OUTFILE='D:\0GDrive\Cambodia\FiADatabase\database\data\xDateConverter.xlsx'
    /TYPE=XLS
    /VERSION=12
    /FIELDNAMES VALUE=NAMES
    /CELLS=LABELS
    /REPLACE.

