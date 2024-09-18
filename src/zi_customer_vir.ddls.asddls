@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer with virtual elements'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_CUSTOMER_VIR as 
select from scustom
{
  key id,
  name,
  city,
  country,
      @ObjectModel.readOnly: true
      @ObjectModel.virtualElement: true 
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_CUSTOMER_VIR'
  cast( '' as abap.char(255)) as virtual_greeting
}
