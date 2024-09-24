CLASS zcl_amdp_crud DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.

    TYPES: BEGIN OF scarr_key_dict,
             carrid TYPE scarr-carrid,
           END OF scarr_key_dict,

           scarr_key_list TYPE STANDARD TABLE OF scarr_key_dict WITH KEY table_line.

    TYPES scarr_list TYPE STANDARD TABLE OF scarr WITH KEY mandt carrid.

    CLASS-METHODS insert_carriers
      IMPORTING VALUE(carriers) TYPE scarr_list.

    CLASS-METHODS remove_url
      IMPORTING VALUE(carrid) TYPE scarr-carrid.

    CLASS-METHODS change_curr
      IMPORTING VALUE(keys)     TYPE scarr_key_list
                VALUE(new_curr) TYPE scarr-currcode.

    CLASS-METHODS delete_carriers
      IMPORTING VALUE(keys) TYPE scarr_key_list.
ENDCLASS.


CLASS zcl_amdp_crud IMPLEMENTATION.
  METHOD insert_carriers
    BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT
    USING scarr.

    insert into scarr(mandt, carrid, carrname, currcode, url)
           select * from :carriers;
  ENDMETHOD.

  METHOD remove_url
    BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT
    USING scarr.

    update scarr set   url    = ''
                 where mandt  = SESSION_CONTEXT( 'CLIENT' ) and
                       carrid = :carrid;
  ENDMETHOD.

  METHOD change_curr
    BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT
    USING scarr.

    declare cursor c1 for select * from :keys;

    for cur_row as c1 do -- loop at :keys into cur_row
      update scarr set    currcode = :new_curr
                   where  mandt    = SESSION_CONTEXT( 'CLIENT' ) and
                          carrid   = cur_row.carrid;
    end for;
  ENDMETHOD.

  METHOD delete_carriers
    BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT
    USING scarr.

    declare cursor c1 for select * from :keys;

    for cur_row as c1 do -- loop at :keys into cur_row
      delete from scarr
             where  mandt  = SESSION_CONTEXT( 'CLIENT' ) and
                    carrid = cur_row.carrid;
    end for;
  ENDMETHOD.
ENDCLASS.
