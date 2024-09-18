@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Business customers who smoked'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_BUSINESS_SMOKERS
  as select distinct from sbook
    left outer join       scustom on scustom.id = sbook.customid
{
  key sbook.customid,
      scustom.name,
      scustom.telephone
}
where
      sbook.class  = 'C'
  and sbook.smoker = 'X'
