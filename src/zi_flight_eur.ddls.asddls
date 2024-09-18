@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Flight amounts in EUR'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_FLIGHT_EUR
  as select from sflight
{
  key carrid,
  key connid,
  key fldate,
      @Semantics.amount.currencyCode: 'currency'
      price,
      currency,

      @Semantics.amount.currencyCode: 'eur_currency'
      currency_conversion( amount             => price,
                           source_currency    => currency,
                           target_currency    => cast('EUR' as abap.cuky( 5 )),
                           exchange_rate_date => sflight.fldate ) as eur_price,

      cast('EUR' as abap.cuky( 5 ))                             as eur_currency

}
