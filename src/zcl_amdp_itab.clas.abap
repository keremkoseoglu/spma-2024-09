CLASS zcl_amdp_itab DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.

    TYPES: BEGIN OF invoice_sum_dict,
             customid   TYPE snvoice-customid,
             currency   TYPE snvoice-currency,
             amount_sum TYPE snvoice-amount,
           END OF invoice_sum_dict,

           invoice_sum_list TYPE STANDARD TABLE OF invoice_sum_dict WITH KEY table_line.

    METHODS get_non_discounted_inv_sum
      IMPORTING VALUE(country) TYPE scustom-country
      EXPORTING VALUE(sums)    TYPE invoice_sum_list.
ENDCLASS.


CLASS zcl_amdp_itab IMPLEMENTATION.
  METHOD get_non_discounted_inv_sum
  BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT
  OPTIONS READ-ONLY
  USING scustom snvoice.

    customers =
      select id, country, discount
      from scustom -- KNA1
      where mandt   = SESSION_CONTEXT( 'CLIENT' ) and
            country = :country;

    customers =
      select * from :customers where discount = '000';

    sums =
      select _cst.id as customid, snvoice.currency, sum( snvoice.amount ) as amount_sum
      from   :customers as _cst
             inner join snvoice on snvoice.mandt    = SESSION_CONTEXT( 'CLIENT' )
                               and snvoice.customid = _cst.id
      group by _cst.id, snvoice.currency;
  ENDMETHOD.
ENDCLASS.
