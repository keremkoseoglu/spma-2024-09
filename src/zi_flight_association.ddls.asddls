@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Flight with association'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_FLIGHT_ASSOCIATION
  as select from sflight
  association [1..1] to scarr as _carrier on  _carrier.carrid = $projection.carrid
  association [0..*] to sbook as _booking on  _booking.carrid    = $projection.carrid
                                          and _booking.connid    = $projection.connid
                                          and _booking.fldate    = $projection.fldate
                                          and _booking.cancelled = ''
{
  key sflight.carrid,
  key sflight.connid,
  key sflight.fldate,
      @Semantics.amount.currencyCode: 'currency'
      sflight.price,
      sflight.currency,

      _carrier,
      _booking
}
