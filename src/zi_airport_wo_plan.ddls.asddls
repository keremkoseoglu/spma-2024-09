@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Airports without flight plan'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_AIRPORT_WO_PLAN
  as select from sairport
  association [0..1] to spfli as _flight_from on _flight_from.airpfrom = $projection.id
  association [0..1] to spfli as _flight_to   on _flight_to.airpto = $projection.id
{
  key sairport.id
}
where
      _flight_from.carrid is null
  and _flight_to.carrid   is null
