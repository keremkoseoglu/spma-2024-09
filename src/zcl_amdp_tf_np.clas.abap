CLASS zcl_amdp_tf_np DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces if_amdp_marker_hdb.

  class-methods get_flights for table function zi_amdp_tf_np.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_amdp_tf_np IMPLEMENTATION.
  method get_flights
        BY DATABASE FUNCTION FOR HDB
        LANGUAGE SQLSCRIPT
        OPTIONS READ-ONLY
        USING sflight.

    tmp = select mandt, carrid, connid, fldate
          from sflight
          where mandt = :p_client;

    return select * from :tmp;

  endmethod.

ENDCLASS.
