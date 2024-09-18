@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'User country consumer'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_USER_COUNTRY_ON_DATE_CONS
  as select from ZI_USER_COUNTRY_ON_DATE( key_date:$session.system_date ) as _uc
{
  key _uc.bname,
      _uc.name1,
      _uc.country,
      _uc.landx
}
