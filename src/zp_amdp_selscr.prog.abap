REPORT zp_amdp_selscr.

TABLES sflight.

SELECT-OPTIONS: s_carrid FOR sflight-carrid,
                s_connid FOR sflight-connid,
                s_fldate FOR sflight-fldate.

START-OF-SELECTION.
  DATA(filter) = cl_shdb_seltab=>combine_seltabs( it_named_seltabs = VALUE #(
                                                      ( name = 'CARRID' dref = REF #( s_carrid[] ) )
                                                      ( name = 'CONNID' dref = REF #( s_connid[] ) )
                                                      ( name = 'FLDATE' dref = REF #( s_fldate[] ) ) ) ).

  zcl_amdp_selscr=>get_flights_by_sel_scr( EXPORTING flight_filter = filter
                                           IMPORTING flights       = DATA(flights) ).

  cl_salv_table=>factory( IMPORTING r_salv_table = DATA(alv)
                          CHANGING  t_table      = flights ).

  alv->display( ).
