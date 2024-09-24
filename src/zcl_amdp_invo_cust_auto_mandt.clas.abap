CLASS zcl_amdp_invo_cust_auto_mandt DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.

    TYPES: BEGIN OF customer_dict,
             id   TYPE scustom-id,
             name TYPE scustom-name,
           END OF customer_dict,

           customer_list TYPE STANDARD TABLE OF customer_dict WITH KEY id.

    METHODS get_invo_cust_from_country
      AMDP OPTIONS CDS SESSION CLIENT CURRENT
      IMPORTING VALUE(country)   TYPE scustom-country
      EXPORTING VALUE(customers) TYPE customer_list.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_amdp_invo_cust_auto_mandt IMPLEMENTATION.
  METHOD get_invo_cust_from_country
  BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT
  OPTIONS READ-ONLY
  USING zi_amdp_invoiced_customers.

    customers =
      select id, name from zi_amdp_invoiced_customers
      where country = :country;
  ENDMETHOD.

ENDCLASS.
