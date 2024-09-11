CLASS zcl_sap_user DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    CLASS-METHODS enable_access_for_all_users.
    CLASS-METHODS disable_access_for_all_users.

    METHODS constructor IMPORTING bname TYPE syuname.

    METHODS say_your_name.

  PRIVATE SECTION.
    CLASS-DATA access_disabled TYPE abap_bool.

    DATA bname TYPE syuname.
ENDCLASS.


CLASS zcl_sap_user IMPLEMENTATION.
  METHOD enable_access_for_all_users.
    zcl_sap_user=>access_disabled = abap_false.
  ENDMETHOD.

  METHOD disable_access_for_all_users.
    zcl_sap_user=>access_disabled = abap_true.
  ENDMETHOD.

  METHOD constructor.
    me->bname = bname.
  ENDMETHOD.

  METHOD say_your_name.
    NEW-LINE.

    IF zcl_sap_user=>access_disabled = abap_true.
      WRITE 'Cant say my name'.
      RETURN.
    ENDIF.

    NEW-LINE.
    WRITE me->bname.
  ENDMETHOD.
ENDCLASS.
