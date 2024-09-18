@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Maximum cargo capacity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_PLANE_CARGO_MAX
  as select from scplane
{
  key planetype,
      @Semantics.quantity.unitOfMeasure: 'car_unit'
      cargomax,
      car_unit,

      @Semantics.quantity.unitOfMeasure: 'kg_unit'
      unit_conversion( quantity    => cargomax,
                       source_unit => car_unit,
                       target_unit => cast('KG' as abap.unit(3) ) )  as cargomax_kg,

      cast('KG' as abap.unit(3))                                     as kg_unit,

      @Semantics.quantity.unitOfMeasure: 'ton_unit'
      unit_conversion( quantity    => cargomax,
                       source_unit => car_unit,
                       target_unit => cast('TON' as abap.unit(3) ) ) as cargomax_ton,

      cast('TON' as abap.unit(3))                                    as ton_unit
}
