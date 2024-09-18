@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Literals in CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_LITERALS
  as select from sflight
{
  key carrid,
  key connid,
  key fldate,

      // Numeric literals
      1               as One,
      3.14            as Pi,

      // String literal
      'Hello, World!' as Greeting


}
