CLASS zcl_air_json_factory DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS build_conn_airport_json RETURNING VALUE(result) TYPE string.
ENDCLASS.


CLASS zcl_air_json_factory IMPLEMENTATION.
  METHOD build_conn_airport_json.
    FINAL(conn_airports) = NEW zcl_connected_airports( ).
    FINAL(airport_list) = conn_airports->get_as_list( ).
    result = /ui2/cl_json=>serialize( airport_list ).
  ENDMETHOD.
ENDCLASS.
