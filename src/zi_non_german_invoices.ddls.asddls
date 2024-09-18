@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Non German invoices'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_NON_GERMAN_INVOICES
  as select from    snvoice
    left outer join scustom as german_customer on  german_customer.id      = snvoice.customid
                                               and german_customer.country = 'DE'
{
  key snvoice.carrid,
  key snvoice.connid,
  key snvoice.fldate,
  key snvoice.bookid,
  key snvoice.customid,
  key snvoice.instno,
  key snvoice.paymeth
}
where
  german_customer.id is null
