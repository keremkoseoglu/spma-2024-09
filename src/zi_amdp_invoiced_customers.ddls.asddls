@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'invoiced customers'

@Metadata.ignorePropagatedAnnotations: true

@ObjectModel.usageType: { serviceQuality: #X, sizeCategory: #S, dataClass: #MIXED }

define view entity ZI_AMDP_INVOICED_CUSTOMERS
  as select distinct from snvoice

    inner join            scustom on scustom.id = snvoice.customid

{
  scustom.id,
  scustom.name,
  scustom.city,
  scustom.country
}
