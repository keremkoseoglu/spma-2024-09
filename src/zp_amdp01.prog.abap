REPORT zp_amdp01.

zcl_amdp01=>get_flights( EXPORTING mandt   = sy-mandt
                         IMPORTING flights = DATA(flights) ).

cl_salv_table=>factory( IMPORTING r_salv_table = DATA(alv)
                        CHANGING  t_table      = flights ).

alv->display( ).
