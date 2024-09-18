REPORT zp_flight_plan_demo.

SELECT FROM spfli
            INNER JOIN sairport AS _from
              ON _from~id = spfli~airpfrom
            INNER JOIN sairport AS _to
              ON _to~id = spfli~airpto
       FIELDS spfli~carrid,
              spfli~connid,
              spfli~airpfrom,
              spfli~airpto,
              _from~name     AS from_name,
              _to~name       AS to_name
       INTO TABLE @DATA(flight_plans).

cl_salv_table=>factory( IMPORTING r_salv_table = DATA(alv)
                        CHANGING  t_table      = flight_plans ).

alv->display( ).
