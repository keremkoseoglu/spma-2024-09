@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'User countries'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_USER_COUNTRY
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
  and adrc.date_from <= $session.system_date
  and adrc.date_to   >= $session.system_date
