REPORT zp_flight_association_cons.

TABLES sflight.

SELECT-OPTIONS:
  s_carrid FOR sflight-carrid,
  s_connid FOR sflight-connid.

SELECT FROM zi_flight_association
       FIELDS carrid,
              connid,
              fldate,
              \_carrier-carrname,
              \_carrier-currcode AS carrier_currency,
              \_booking-bookid,
              \_booking-customid AS booking_customer
       WHERE carrid IN @s_carrid
         AND connid IN @s_connid
       INTO TABLE @DATA(flights).

cl_salv_table=>factory( IMPORTING r_salv_table = DATA(alv)
                        CHANGING  t_table      = flights ).

alv->display( ).
