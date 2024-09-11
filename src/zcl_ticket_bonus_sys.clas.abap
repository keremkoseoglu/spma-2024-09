CLASS zcl_ticket_bonus_sys DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES zif_remote_ticket_sys.
ENDCLASS.


CLASS zcl_ticket_bonus_sys IMPLEMENTATION.
  METHOD zif_remote_ticket_sys~accept_new_tickets.
    NEW-LINE.
    WRITE 'Tickets sent to bonus system'.
  ENDMETHOD.

  METHOD zif_remote_ticket_sys~cancel_tickets.
    NEW-LINE.
    WRITE 'Tickets cancelled from bonus system'.
  ENDMETHOD.
ENDCLASS.
