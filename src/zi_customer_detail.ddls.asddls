@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer details'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_CUSTOMER_DETAIL
  as select from scustom
{
      /* Key fields
         These fields are keys */
  key id,

      /* Regular values
         Those fields are reflected directly */

      country,
      name,
      form,
      city,
      telephone, // Hello?

      /* Calculated fields
         Those are complex fields */

      // Full name
      case when form = ''
           then name
           else concat_with_space( form, name, 1 )
           end                                          as full_name,

      // Telephone format
      case when instr( telephone, '/' ) > 0
           then 'slashed'
           else 'non-slashed'
           end                                          as phone_format,

      // Clean telephone
      replace( replace( telephone, '-', '' ), '/', '' ) as clean_phone,

      // Short city name
      left( city, 3 )                                   as short_city,

      // Postcode prefix
      case when postcode = '' then ''
           when country = 'DE' then substring( postcode, 1, 2 )
           when country = 'GB' then substring( postcode, 1, 3 )
           else substring( postcode, 1, 1 )
           end                                          as postcode_prefix
}
