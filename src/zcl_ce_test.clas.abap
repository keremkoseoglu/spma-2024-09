CLASS zcl_ce_test DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_rap_query_provider.
ENDCLASS.


CLASS zcl_ce_test IMPLEMENTATION.
  METHOD if_rap_query_provider~select.
    DATA output TYPE STANDARD TABLE OF zi_ce_test WITH KEY bname.

    SELECT FROM usr02
           FIELDS bname,
                  'Hello' AS greeting
           INTO CORRESPONDING FIELDS OF TABLE @output.

    io_response->set_data( output ).
  ENDMETHOD.
ENDCLASS.
