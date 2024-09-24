CLASS zcl_amdp01_auto_mandt DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.

    TYPES: BEGIN OF flight_dict,
             carrid   TYPE sflight-carrid,
             price    TYPE sflight-price,
             currency TYPE sflight-currency,
           END OF flight_dict,

           flight_list TYPE STANDARD TABLE OF flight_dict WITH KEY carrid price.

    CLASS-METHODS get_flights
      EXPORTING VALUE(flights) TYPE flight_list.
ENDCLASS.


CLASS zcl_amdp01_auto_mandt IMPLEMENTATION.
  METHOD get_flights
    BY DATABASE PROCEDURE FOR HDB
    LANGUAGE SQLSCRIPT
    OPTIONS READ-ONLY
    USING sflight.

    flights = select carrid, sum( price ) as price, currency
              from sflight
              where mandt = SESSION_CONTEXT( 'CLIENT' )
              group by carrid, currency;
  ENDMETHOD.
ENDCLASS.
