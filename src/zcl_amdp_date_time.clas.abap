CLASS zcl_amdp_date_time DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.

    CLASS-METHODS get_sys_date_time
      EXPORTING VALUE(date)  TYPE dats
                VALUE(year)  TYPE gjahr
                VALUE(month) TYPE monat
                VALUE(time)  TYPE tims.
ENDCLASS.


CLASS zcl_amdp_date_time IMPLEMENTATION.
  METHOD get_sys_date_time
    BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT.

    declare my_date date;
    declare my_time time;

    my_date = CURRENT_DATE;
    my_time = CURRENT_TIME;

    date = to_dats(my_date);
    year = year( my_date );
    month = month( my_date );

    time = to_nvarchar( my_time, 'HHMMSS' );
  ENDMETHOD.
ENDCLASS.
