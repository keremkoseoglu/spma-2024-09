@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'User countries'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_USER_COUNTRY_ON_DATE
  with parameters key_date : datum
  as select from    usr21
    inner join      adrc  on adrc.addrnumber = usr21.addrnumber
    left outer join t005t on  t005t.spras = $session.system_language
                          and t005t.land1 = adrc.country
{
  key usr21.bname,
      adrc.name1,
      adrc.country,
      t005t.landx
}
where
      usr21.bname    <> $session.user
  and adrc.date_from <= $parameters.key_date
  and adrc.date_to   >= $parameters.key_date
