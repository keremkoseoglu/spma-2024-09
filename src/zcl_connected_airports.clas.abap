CLASS zcl_connected_airports DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES airport_list TYPE STANDARD TABLE OF sairport WITH KEY id.

    METHODS constructor.

    METHODS get_as_list RETURNING VALUE(result) TYPE airport_list.

    METHODS clear_airports.

  PRIVATE SECTION.
    TYPES airport_id_list TYPE STANDARD TABLE OF sairport-id WITH KEY table_line.

    DATA: connected_airport_ids TYPE airport_id_list,
          connected_airports    TYPE airport_list.

    METHODS read_connections.
    METHODS read_airport_details.
ENDCLASS.


CLASS zcl_connected_airports IMPLEMENTATION.
  METHOD constructor.
    read_connections( ).
    read_airport_details( ).
  ENDMETHOD.

  METHOD get_as_list.
    result = me->connected_airports.
  ENDMETHOD.

  METHOD clear_airports.
    CLEAR me->connected_airports.
  ENDMETHOD.

  METHOD read_connections.
    SELECT FROM sflconn
           FIELDS DISTINCT airpfrom
    UNION DISTINCT
    SELECT FROM sflconn
           FIELDS DISTINCT airpto
    INTO TABLE @me->connected_airport_ids.
  ENDMETHOD.

  METHOD read_airport_details.
    CHECK me->connected_airport_ids IS NOT INITIAL.

    SELECT FROM sairport
           FIELDS *
           FOR ALL ENTRIES IN @me->connected_airport_ids
           WHERE sairport~id = @me->connected_airport_ids-table_line
           INTO CORRESPONDING FIELDS OF TABLE @me->connected_airports.
  ENDMETHOD.
ENDCLASS.
