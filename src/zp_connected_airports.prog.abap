REPORT zp_connected_airports.

START-OF-SELECTION.
  DATA(connected_airports1) = NEW zcl_connected_airports( ).
  connected_airports1->clear_airports( ).
  DATA(airport_alv1) = connected_airports1->get_as_list( ).

  DATA(connected_airports2) = NEW zcl_connected_airports( ).
  DATA(airport_alv2) = connected_airports2->get_as_list( ).

  " cl_demo_output=>display_data( airport_alv ).
