@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Meal right join'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_MEAL_RIGHT_JOIN
  as select from    smeal
    left outer join smacourse as _main on  _main.carrid     = smeal.carrid
                                       and _main.mealnumber = smeal.mealnumber
    left outer join sdessert  as _dess on  _dess.carrid     = smeal.carrid
                                       and _dess.mealnumber = smeal.mealnumber
{
  key smeal.carrid,
  key smeal.mealnumber,
      smeal.mealtype,
      _main.mealnumber as main_meal,
      _dess.mealnumber as dess_meal
}
