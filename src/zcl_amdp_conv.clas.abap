CLASS zcl_amdp_conv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.

    TYPES: BEGIN OF plane_dict,
             planetype  TYPE saplane-planetype,
             weight_ton TYPE saplane-weight,
           END OF plane_dict,

           plane_list TYPE STANDARD TABLE OF plane_dict WITH KEY planetype.

    TYPES: BEGIN OF flight_dict,
             carrid    TYPE sflight-carrid,
             connid    TYPE sflight-connid,
             fldate    TYPE sflight-fldate,
             eur_price TYPE sflight-price,
           END OF flight_dict,

           flight_list TYPE STANDARD TABLE OF flight_dict WITH KEY carrid connid fldate.

    CLASS-METHODS get_planes
      EXPORTING VALUE(planes) TYPE plane_list.

    CLASS-METHODS get_flights
      EXPORTING VALUE(flights) TYPE flight_list.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_amdp_conv IMPLEMENTATION.
  METHOD get_planes
    BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT
    OPTIONS READ-ONLY USING saplane.

    planes =
      select planetype,
             convert_unit( quantity       => weight,
                           source_unit    => wei_unit,
                           schema         => current_schema,
                           target_unit    => 'TON',
                           error_handling => 'set to null',
                           client         => SESSION_CONTEXT( 'CLIENT' )
                         ) as weight_ton
              from saplane
              where mandt = SESSION_CONTEXT( 'CLIENT' );
  ENDMETHOD.

  METHOD get_flights
    BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT
    OPTIONS READ-ONLY USING sflight.

    flights =
      select carrid, connid, fldate,
             convert_currency( amount         => price,
                               source_unit    => currency,
                               schema         => current_schema,
                               target_unit    => 'EUR',
                               reference_date => current_date,
                               client         => SESSION_CONTEXT( 'CLIENT' )
                             ) as eur_price
             from sflight
             where mandt = SESSION_CONTEXT( 'CLIENT' );
  ENDMETHOD.

ENDCLASS.
