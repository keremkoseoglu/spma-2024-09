CLASS zcl_amdp_limit DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.

    TYPES: BEGIN OF customer_dict,
             id   TYPE scustom-id,
             name TYPE scustom-name,
           END OF customer_dict,

           customer_list TYPE STANDARD TABLE OF customer_dict WITH KEY id.

    CLASS-METHODS get_some_custs_with_books
      IMPORTING VALUE(imax)    TYPE i
                VALUE(ioffset) TYPE i
      EXPORTING VALUE(custs)   TYPE customer_list.
ENDCLASS.


CLASS zcl_amdp_limit IMPLEMENTATION.
  METHOD get_some_custs_with_books
    BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT
    OPTIONS READ-ONLY
    USING scustom sbook.

    custs =
      select scustom.id, scustom.name
             from scustom
             where mandt = SESSION_CONTEXT( 'CLIENT' ) and
                   exists ( select mandt from sbook
                            where mandt    = scustom.mandt and
                                  customid = scustom.id )
              LIMIT :imax offset :ioffset;
  ENDMETHOD.
ENDCLASS.
