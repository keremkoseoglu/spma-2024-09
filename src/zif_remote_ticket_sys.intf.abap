INTERFACE zif_remote_ticket_sys
  PUBLIC.

  TYPES ticket_list TYPE STANDARD TABLE OF sticket WITH DEFAULT KEY.

  METHODS accept_new_tickets IMPORTING tickets TYPE ticket_list.

  METHODS cancel_tickets     IMPORTING tickets TYPE ticket_list.

ENDINTERFACE.
