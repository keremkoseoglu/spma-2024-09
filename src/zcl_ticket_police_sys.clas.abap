CLASS zcl_ticket_police_sys DEFINITION
  PUBLIC
  INHERITING FROM zcl_json_ticket_sys FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

  PROTECTED SECTION.
    METHODS: create_tickets_in_remote_sys REDEFINITION,
             cancel_tickets_in_remote_sys REDEFINITION.

  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_ticket_police_sys IMPLEMENTATION.
  METHOD cancel_tickets_in_remote_sys.
    NEW-LINE.
    WRITE 'Tickets cancelled in police system'.
  ENDMETHOD.

  METHOD create_tickets_in_remote_sys.
    NEW-LINE.
    WRITE 'Tickets created in police system'.
  ENDMETHOD.
ENDCLASS.
