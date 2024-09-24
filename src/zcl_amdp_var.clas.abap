CLASS zcl_amdp_var DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.

    CLASS-METHODS var_demo EXPORTING VALUE(output) TYPE string.
ENDCLASS.


CLASS zcl_amdp_var IMPLEMENTATION.
  METHOD var_demo
      BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT
      OPTIONS READ-ONLY
      USING scustom.

    declare x int; -- data x type i.
    declare y "$ABAP.type( s_custname )";
    declare z VARCHAR( 10 );

    -- Direct assignment
    x = 2;

    -- ABAP type assignment
    select name into y
           from scustom
           LIMIT 1;

    -- Concatenate like |{ x } - { y }|
    z = x || ' - ' || y;

    -- Finally
    output = z;
  ENDMETHOD.
ENDCLASS.
