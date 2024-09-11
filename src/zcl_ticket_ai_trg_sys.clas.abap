CLASS zcl_ticket_ai_trg_sys DEFINITION
  PUBLIC
  INHERITING FROM zcl_ticket_ai_sys FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

  PROTECTED SECTION.
    METHODS create_tickets_in_remote_sys REDEFINITION.

  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_ticket_ai_trg_sys IMPLEMENTATION.
  METHOD create_tickets_in_remote_sys.
    " Full override
    " NEW-LINE.
    " WRITE 'Own code of child class'.

    " Partial override
    NEW-LINE.
    WRITE 'Extra preparation steps taken by child'.

    super->create_tickets_in_remote_sys( json ).

    NEW-LINE.
    WRITE 'Extra post-steps taken by child'.
  ENDMETHOD.
ENDCLASS.
