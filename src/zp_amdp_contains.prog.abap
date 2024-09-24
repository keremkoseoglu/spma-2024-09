REPORT zp_amdp_contains.

ycl_amdp_contains=>find_airports_exact( EXPORTING name_txt = 'Hongkong'
                                        IMPORTING airports = DATA(airports1) ).

cl_demo_output=>display_data( value = airports1
                              name  = 'Hongkong exact' ).

ycl_amdp_contains=>find_airports_exact( EXPORTING name_txt = 'Hongkang'
                                        IMPORTING airports = DATA(airports2) ).

cl_demo_output=>display_data( value = airports2
                              name  = 'Hongkang exact' ).

ycl_amdp_contains=>find_airports_exact( EXPORTING name_txt = 'London'
                                        IMPORTING airports = DATA(airports3) ).

cl_demo_output=>display_data( value = airports3
                              name  = 'London exact' ).

ycl_amdp_contains=>find_airports_fuzzy( EXPORTING name_txt = 'Hongkong'
                                        IMPORTING airports = DATA(airports4) ).

cl_demo_output=>display_data( value = airports4
                              name  = 'Hongkong fuzzy' ).

ycl_amdp_contains=>find_airports_fuzzy( EXPORTING name_txt = 'Hongkang'
                                        IMPORTING airports = DATA(airports5) ).

cl_demo_output=>display_data( value = airports5
                              name  = 'Hongkang fuzzy' ).

ycl_amdp_contains=>find_airports_fuzzy( EXPORTING name_txt = 'London'
                                        IMPORTING airports = DATA(airports6) ).

cl_demo_output=>display_data( value = airports6
                              name  = 'London fuzzy' ).
