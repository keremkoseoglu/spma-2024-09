@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Calculations'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_CALCULATION
  as select from sflight
    inner join   spfli on  spfli.carrid = sflight.carrid
                       and spfli.connid = sflight.connid
{
  key sflight.carrid,
  key sflight.connid,
  key sflight.fldate,
      @Semantics.amount.currencyCode: 'currency'
      sflight.price,
      sflight.currency,
      spfli.distid,
      spfli.fltime,

      // Basic arithmetic
      spfli.fltime / 2                                        as half_fltime,

      // Rounding
      ceil(spfli.fltime / 2)                                  as ceiling_half_fltime,
      floor(spfli.fltime / 2)                                 as floor_half_fltime,
      round(cast(sflight.price as abap.dec(10,2)), 0)         as rounded_price,

      // Absolute
      abs(spfli.fltime - 1000)                                as abs_diff_from_1k,

      // Date calculations
      dats_add_days(sflight.fldate, 30, 'INITIAL')            as after_30_days,
      dats_add_months(sflight.fldate, 2, 'INITIAL')           as after_2_months,
      dats_days_between(sflight.fldate, $session.system_date) as days_passed
}
