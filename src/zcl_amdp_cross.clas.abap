CLASS zcl_amdp_cross DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.

    TYPES: BEGIN OF combo_dict,
             airport_id    TYPE sairport-id,
             airplane_type TYPE saplane-planetype,
           END OF combo_dict,

           combo_list TYPE STANDARD TABLE OF combo_dict WITH KEY table_line.

    METHODS get_airport_airplane_combo
      EXPORTING VALUE(combos) TYPE combo_list.
ENDCLASS.


CLASS zcl_amdp_cross IMPLEMENTATION.
  METHOD get_airport_airplane_combo
  BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT
  OPTIONS READ-ONLY
  USING sairport saplane.

    combos =
      select sairport.id as airport_id,
             saplane.planetype as airplane_type
      from   sairport
             cross join saplane
      where  sairport.mandt = SESSION_CONTEXT( 'CLIENT' ) and
             saplane.mandt  = SESSION_CONTEXT( 'CLIENT' );
  ENDMETHOD.
ENDCLASS.
