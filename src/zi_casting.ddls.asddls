@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Casting data'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_CASTING as 
select from sflight
{
  key carrid,
  key connid,
  key fldate,
  
  cast(connid as abap.int4) as connid_as_integer,
  cast(price as abap.char( 20 ) ) as price_as_char,
  cast('19782712' as abap.dats) as kk_birthday
}
