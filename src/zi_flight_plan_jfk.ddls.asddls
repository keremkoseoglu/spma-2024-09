@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'JFK flight plans'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_FLIGHT_PLAN_JFK
  as select from ZI_FLIGHT_PLAN_DEMO as _pd
{
  key carrid,
  key connid,
      airpfrom,
      airpto,
      from_name,
      to_name
}
where
     airpfrom = 'JFK'
  or airpto   = 'JFK'
