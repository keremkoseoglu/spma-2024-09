CLASS zcl_amdp02 DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.

    TYPES: BEGIN OF booking_sum_dict,
             carrid    TYPE sbook-carrid,
             connid    TYPE sbook-connid,
             fldate    TYPE sbook-fldate,
             forcurkey TYPE sbook-forcurkey,
             forcuram  TYPE sbook-forcuram,
           END OF booking_sum_dict,

           booking_sum_list TYPE STANDARD TABLE OF booking_sum_dict
                            WITH KEY carrid connid fldate forcurkey.

    TYPES: BEGIN OF carrid_sum_dict,
             carrid    TYPE sbook-carrid,
             forcurkey TYPE sbook-forcurkey,
             forcuram  TYPE sbook-forcuram,
           END OF carrid_sum_dict,

           carrid_sum_list TYPE STANDARD TABLE OF carrid_sum_dict
                           WITH KEY carrid forcurkey.

    CLASS-METHODS get_booking_sum
      IMPORTING VALUE(mandt)  TYPE symandt
      EXPORTING VALUE(result) TYPE booking_sum_list.

    CLASS-METHODS get_carrid_sum
      IMPORTING VALUE(mandt)  TYPE symandt
      EXPORTING VALUE(result) TYPE carrid_sum_list.
ENDCLASS.


CLASS zcl_amdp02 IMPLEMENTATION.
  METHOD get_booking_sum
  BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT
  OPTIONS READ-ONLY
  USING sbook.

    result = select carrid, connid, fldate, forcurkey,
                    sum( forcuram ) as forcuram
             from sbook
             where mandt = :mandt
             group by carrid, connid, fldate, forcurkey;
  ENDMETHOD.

  METHOD get_carrid_sum
  BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT
  OPTIONS READ-ONLY
  USING zcl_amdp02=>get_booking_sum.

    call "ZCL_AMDP02=>GET_BOOKING_SUM"(
      mandt   => :mandt,
      result  => :bookings );

    result = select carrid, forcurkey, sum( forcuram ) as forcuram
             from :bookings
             group by carrid, forcurkey
             order by carrid, forcurkey;
  ENDMETHOD.
ENDCLASS.
