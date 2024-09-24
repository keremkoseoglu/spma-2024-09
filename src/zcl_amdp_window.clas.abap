CLASS zcl_amdp_window DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.

    TYPES: BEGIN OF sflight1_dict,
             carrid   TYPE sflight-carrid,
             connid   TYPE sflight-connid,
             fldate   TYPE sflight-fldate,
             price    TYPE sflight-price,
             currency TYPE sflight-currency,
           END OF sflight1_dict,

           sflight1_list TYPE STANDARD TABLE OF sflight1_dict WITH EMPTY KEY.

    TYPES  BEGIN OF sflight2_dict.
             INCLUDE TYPE sflight1_dict.
    TYPES:   date_seat_sum TYPE i,
           END OF sflight2_dict,

           sflight2_list TYPE STANDARD TABLE OF sflight2_dict WITH EMPTY KEY.


    METHODS get_daily_flight_stats
      EXPORTING VALUE(most_crowded) TYPE sflight1_list
      VALUE(least_crowded)    TYPE sflight1_list
      VALUE(flights_with_dss) TYPE sflight2_list.
ENDCLASS.


CLASS zcl_amdp_window IMPLEMENTATION.
  METHOD get_daily_flight_stats
  BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT
  OPTIONS READ-ONLY
  USING sflight.

    -- Most crowded
    most_crowded_tmp =
      select carrid, connid, fldate, price, currency,
             row_number( ) over ( partition by fldate order by seatsocc desc ) as row_no
      from   sflight
      where  mandt = SESSION_CONTEXT( 'CLIENT' );

    most_crowded =
      select carrid, connid, fldate, price, currency
      from :most_crowded_tmp where
      row_no = 1;

    -- Least crowded
    least_crowded_tmp =
      select carrid, connid, fldate, price, currency,
             row_number( ) over ( partition by fldate order by seatsocc asc ) as row_no
      from   sflight
      where  mandt = SESSION_CONTEXT( 'CLIENT' );

    least_crowded =
      select carrid, connid, fldate, price, currency
      from :least_crowded_tmp where
      row_no = 1;

    -- Flights with daily seat sum
    flights_with_dss =
      select carrid, connid, fldate, price, currency,
             sum( seatsocc ) over ( partition by fldate ) as date_seat_sum
             from sflight
             where mandt = SESSION_CONTEXT( 'CLIENT' );


  ENDMETHOD.
ENDCLASS.
