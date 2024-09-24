CLASS zcl_amdp_dynamic_sql DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.

    TYPES: BEGIN OF meal_dict,
             carrid     TYPE smeal-carrid,
             mealnumber TYPE smeal-mealnumber,
           END OF meal_dict,

           meal_list TYPE STANDARD TABLE OF meal_dict WITH KEY table_line.

    METHODS get_meals
      IMPORTING VALUE(type)  TYPE char1
      EXPORTING VALUE(meals) TYPE meal_list.
ENDCLASS.


CLASS zcl_amdp_dynamic_sql IMPLEMENTATION.
  METHOD get_meals
  BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT
  OPTIONS READ-ONLY.

    declare tab_name "$ABAP.type( tabname )";
    declare dyn_sql string;

    if type = 'D' then
      tab_name = 'SDESSERT';
    else
      tab_name = 'SMACOURSE';
    end if;

    dyn_sql = 'select carrid, mealnumber from ' || :tab_name || ' where mandant = ''' || SESSION_CONTEXT( 'CLIENT' ) || '''';

    exec :dyn_sql into meals;

  ENDMETHOD.
ENDCLASS.
