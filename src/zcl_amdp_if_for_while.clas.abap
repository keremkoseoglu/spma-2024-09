CLASS zcl_amdp_if_for_while DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.

    CLASS-METHODS get_chars_for
      IMPORTING VALUE(limit) TYPE i
      EXPORTING VALUE(chars) TYPE string.

    CLASS-METHODS get_chars_while
      IMPORTING VALUE(limit) TYPE i
      EXPORTING VALUE(chars) TYPE string.

    CLASS-METHODS get_carrier_flight_count
      IMPORTING VALUE(carrid) TYPE scarr-carrid
      EXPORTING VALUE(result) TYPE i.


ENDCLASS.


CLASS zcl_amdp_if_for_while IMPLEMENTATION.
  METHOD get_chars_for
  BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT.

    declare pos int;

    if :limit > 5 then
      chars = 'NO!';
      return;
    end if;

    chars = 'F';

    for pos in 1..:limit do
      chars = chars || cast(pos as varchar(2));
    end for;
  ENDMETHOD.

  METHOD get_chars_while
    BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT.

    declare pos int;

    if :limit > 5 then
      chars = 'NO!';
      return;
    end if;

    chars = 'W';
    pos = 1;

    while pos <= :limit do
      chars = chars || pos;
      pos = pos + 1;
    end while;
  ENDMETHOD.

  METHOD get_carrier_flight_count
    BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT
    OPTIONS READ-ONLY USING scarr sflight.

    -- 10000 -> 19999
    declare empty_carrid condition for SQL_ERROR_CODE 10000;
    declare invalid_carrid condition for SQL_ERROR_CODE 10001;
    declare tmp_carrid "$ABAP.type( s_carr_id )";

    if :carrid = null or :carrid = '' then
      signal empty_carrid set message_text = 'Empty carrier ID';
    end if;

    select carrid into tmp_carrid
           from scarr
           where mandt  = SESSION_CONTEXT( 'CLIENT' ) and
                 carrid = :carrid
           limit 1;

    if :tmp_carrid = null or :tmp_carrid = '' then
      signal invalid_carrid set message_text = 'Invalid carrier ID';
    end if;

    select count( * ) into result
           from sflight
           where mandt  = SESSION_CONTEXT( 'CLIENT' ) and
                 carrid = :carrid;
  ENDMETHOD.

ENDCLASS.
