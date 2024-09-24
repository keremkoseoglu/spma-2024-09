CLASS zcl_amdp_selscr DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.

    TYPES sflight_list TYPE STANDARD TABLE OF sflight.

    CLASS-METHODS get_flights_by_sel_scr
      IMPORTING VALUE(flight_filter) TYPE string
      EXPORTING VALUE(flights)       TYPE sflight_list.
ENDCLASS.


CLASS zcl_amdp_selscr IMPLEMENTATION.
  METHOD get_flights_by_sel_scr
    BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT
    USING sflight.

    tmp_flights = select * from sflight where mandt = SESSION_CONTEXT( 'CLIENT' );
    flights = apply_filter( :tmp_flights, :flight_filter );
    -- flights = apply_filter( sflight, :flight_filter );
    -- CDS is also possible
  ENDMETHOD.
ENDCLASS.
