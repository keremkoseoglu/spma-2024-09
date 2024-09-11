REPORT zp_ticket_sync_v2.

DATA remote_sys TYPE REF TO zif_remote_ticket_sys.

PARAMETERS: p_bonus RADIOBUTTON GROUP rg1,
            p_secur RADIOBUTTON GROUP rg1,
            p_polic RADIOBUTTON GROUP rg1,
            p_artif RADIOBUTTON GROUP rg1.


START-OF-SELECTION.
  CASE abap_true.
    WHEN p_bonus.
      DATA(bonus_sys) = NEW zcl_ticket_bonus_sys( ).
      remote_sys ?= bonus_sys.

    WHEN p_secur.
      DATA(security_sys) = NEW zcl_ticket_security_sys( ).
      remote_sys = CAST #( security_sys ).

    WHEN p_polic.
      DATA(police_sys) = NEW zcl_ticket_police_sys( ).
      remote_sys ?= police_sys.

    WHEN p_artif.
      DATA(artif_sys) = NEW zcl_ticket_ai_sys( ).
      remote_sys ?= artif_sys.
  ENDCASE.

  SELECT * FROM sticket INTO TABLE @DATA(tickets). " Dummy
  remote_sys->accept_new_tickets( CORRESPONDING #( tickets ) ).
