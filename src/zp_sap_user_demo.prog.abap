REPORT zp_sap_user_demo.

DATA(user1) = NEW zcl_sap_user( 'DEVELOPER' ).
DATA(user2) = NEW zcl_sap_user( 'SAP*' ).

user1->say_your_name( ).
user2->say_your_name( ).

zcl_sap_user=>disable_access_for_all_users( ).

user1->say_your_name( ).
user2->say_your_name( ).

zcl_sap_user=>enable_access_for_all_users( ).

user1->say_your_name( ).
user2->say_your_name( ).
