CLASS zcl_json_ticket_sys DEFINITION
  PUBLIC ABSTRACT
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES zif_remote_ticket_sys.

  PROTECTED SECTION.
    METHODS create_tickets_in_remote_sys
      ABSTRACT
      IMPORTING json TYPE string.

    METHODS cancel_tickets_in_remote_sys
      ABSTRACT
      IMPORTING json TYPE string.

  PRIVATE SECTION.
    METHODS build_ticket_json
      IMPORTING tickets       TYPE zif_remote_ticket_sys=>ticket_list
      RETURNING VALUE(result) TYPE string.

ENDCLASS.


CLASS zcl_json_ticket_sys IMPLEMENTATION.
  METHOD build_ticket_json.
    result = /ui2/cl_json=>serialize( tickets ).
  ENDMETHOD.

  METHOD zif_remote_ticket_sys~accept_new_tickets.
    FINAL(ticket_json) = build_ticket_json( tickets ).
    create_tickets_in_remote_sys( ticket_json ).
  ENDMETHOD.

  METHOD zif_remote_ticket_sys~cancel_tickets.
    FINAL(ticket_json) = build_ticket_json( tickets ).
    cancel_tickets_in_remote_sys( ticket_json ).
  ENDMETHOD.
ENDCLASS.
