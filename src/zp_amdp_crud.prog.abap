REPORT zp_amdp_crud.

START-OF-SELECTION.
  " Insert
  zcl_amdp_crud=>insert_carriers( VALUE #( mandt = sy-mandt
                                           ( carrid   = 'Z1'
                                             carrname = 'New 1'
                                             url      = 'z1.com' )
                                           ( carrid   = 'Z2'
                                             carrname = 'New 2'
                                             url      = 'z2.com' ) ) ).
  PERFORM show_carriers.

  " Update
  zcl_amdp_crud=>change_curr( keys     = VALUE #( ( carrid = 'Z1' )
                                                  ( carrid = 'Z2' ) )
                              new_curr = 'USD' ).
  PERFORM show_carriers.

  zcl_amdp_crud=>remove_url( carrid = 'Z1' ).
  PERFORM show_carriers.

  " Delete
  zcl_amdp_crud=>delete_carriers( keys = VALUE #( ( carrid = 'Z1' )
                                                  ( carrid = 'Z2' ) ) ).
  PERFORM show_carriers.

FORM show_carriers.
  SELECT * FROM scarr INTO TABLE @DATA(carriers).

  NEW-LINE.
  WRITE 'Current carrier list:'.

  LOOP AT carriers REFERENCE INTO DATA(carrier).
    NEW-LINE.
    WRITE: carrier->carrid, carrier->carrname, carrier->currcode.
  ENDLOOP.
ENDFORM.
