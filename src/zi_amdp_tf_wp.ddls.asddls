@EndUserText.label: 'cds amdp with parameters'

define table function ZI_AMDP_TF_WP
  with parameters
    @Environment.systemField: #CLIENT
    p_client : abap.clnt,

    p_carrid : s_carr_id

returns

{
  mandt  : abap.clnt;
  carrid : s_carr_id;
  connid : s_conn_id;
  fldate : s_date;
}

implemented by method zcl_amdp_tf_wp=>get_flights;
