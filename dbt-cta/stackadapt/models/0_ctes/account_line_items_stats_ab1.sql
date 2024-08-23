{% set raw_table = env_var("CTA_DATASET_ID") ~ "_raw__stream_account_line_items_stats" %}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', raw_table) }}
select
    {{ json_extract_scalar('_airbyte_data', ['ctr'], ['ctr']) }} as ctr,
    {{ json_extract_scalar('_airbyte_data', ['cvr'], ['cvr']) }} as cvr,
    {{ json_extract_scalar('_airbyte_data', ['imp'], ['imp']) }} as imp,
    {{ json_extract_scalar('_airbyte_data', ['ltr'], ['ltr']) }} as ltr,
    {{ json_extract_scalar('_airbyte_data', ['atos'], ['atos']) }} as atos,
    {{ json_extract_scalar('_airbyte_data', ['conv'], ['conv']) }} as conv,
    {{ json_extract_scalar('_airbyte_data', ['cost'], ['cost']) }} as cost,
    {{ json_extract_scalar('_airbyte_data', ['date'], ['date']) }} as date,
    {{ json_extract_scalar('_airbyte_data', ['ecpa'], ['ecpa']) }} as ecpa,
    {{ json_extract_scalar('_airbyte_data', ['ecpc'], ['ecpc']) }} as ecpc,
    {{ json_extract_scalar('_airbyte_data', ['ecpe'], ['ecpe']) }} as ecpe,
    {{ json_extract_scalar('_airbyte_data', ['ecpm'], ['ecpm']) }} as ecpm,
    {{ json_extract_scalar('_airbyte_data', ['ecpv'], ['ecpv']) }} as ecpv,
    {{ json_extract_scalar('_airbyte_data', ['rcpc'], ['rcpc']) }} as rcpc,
    {{ json_extract_scalar('_airbyte_data', ['rcpe'], ['rcpe']) }} as rcpe,
    {{ json_extract_scalar('_airbyte_data', ['rcpm'], ['rcpm']) }} as rcpm,
    {{ json_extract_scalar('_airbyte_data', ['roas'], ['roas']) }} as roas,
    {{ json_extract_scalar('_airbyte_data', ['click'], ['click']) }} as click,
    {{ json_extract_scalar('_airbyte_data', ['ecpcl'], ['ecpcl']) }} as ecpcl,
    {{ json_extract_scalar('_airbyte_data', ['rcpcl'], ['rcpcl']) }} as rcpcl,
    {{ json_extract_scalar('_airbyte_data', ['profit'], ['profit']) }} as profit,
    {{ json_extract_scalar('_airbyte_data', ['s_conv'], ['s_conv']) }} as s_conv,
    {{ json_extract_scalar('_airbyte_data', ['conv_ip'], ['conv_ip']) }} as conv_ip,
    {{ json_extract_scalar('_airbyte_data', ['revenue'], ['revenue']) }} as revenue,
    {{ json_extract_scalar('_airbyte_data', ['vcomp_0'], ['vcomp_0']) }} as vcomp_0,
    {{ json_extract_scalar('_airbyte_data', ['conv_rev'], ['conv_rev']) }} as conv_rev,
    {{ json_extract_scalar('_airbyte_data', ['vcomp_25'], ['vcomp_25']) }} as vcomp_25,
    {{ json_extract_scalar('_airbyte_data', ['vcomp_50'], ['vcomp_50']) }} as vcomp_50,
    {{ json_extract_scalar('_airbyte_data', ['vcomp_75'], ['vcomp_75']) }} as vcomp_75,
    {{ json_extract_scalar('_airbyte_data', ['vcomp_95'], ['vcomp_95']) }} as vcomp_95,
    {{ json_extract_scalar('_airbyte_data', ['line_item'], ['line_item']) }} as line_item,
    {{ json_extract_scalar('_airbyte_data', ['page_time'], ['page_time']) }} as page_time,
    {{ json_extract_scalar('_airbyte_data', ['uniq_conv'], ['uniq_conv']) }} as uniq_conv,
    {{ json_extract_scalar('_airbyte_data', ['uniq_ecpa'], ['uniq_ecpa']) }} as uniq_ecpa,
    {{ json_extract_scalar('_airbyte_data', ['atos_units'], ['atos_units']) }} as atos_units,
    {{ json_extract_scalar('_airbyte_data', ['conv_click'], ['conv_click']) }} as conv_click,
    {{ json_extract_scalar('_airbyte_data', ['page_start'], ['page_start']) }} as page_start,
    {{ json_extract_scalar('_airbyte_data', ['unique_imp'], ['unique_imp']) }} as unique_imp,
    {{ json_extract_scalar('_airbyte_data', ['vcomp_rate'], ['vcomp_rate']) }} as vcomp_rate,
    {{ json_extract_scalar('_airbyte_data', ['engage_rate'], ['engage_rate']) }} as engage_rate,
    {{ json_extract_scalar('_airbyte_data', ['tp_cpc_cost'], ['tp_cpc_cost']) }} as tp_cpc_cost,
    {{ json_extract_scalar('_airbyte_data', ['tp_cpm_cost'], ['tp_cpm_cost']) }} as tp_cpm_cost,
    {{ json_extract_scalar('_airbyte_data', ['unique_conv'], ['unique_conv']) }} as unique_conv,
    {{ json_extract_scalar('_airbyte_data', ['view_percent'], ['view_percent']) }} as view_percent,
    {{ json_extract_scalar('_airbyte_data', ['page_time_15s'], ['page_time_15s']) }} as page_time_15s,
    {{ json_extract_scalar('_airbyte_data', ['sub_advertiser'], ['sub_advertiser']) }} as sub_advertiser,
    {{ json_extract_scalar('_airbyte_data', ['page_time_units'], ['page_time_units']) }} as page_time_units,
    {{ json_extract_scalar('_airbyte_data', ['conv_imp_derived'], ['conv_imp_derived']) }} as conv_imp_derived,
    {{ json_extract_scalar('_airbyte_data', ['conv_imp_time_avg'], ['conv_imp_time_avg']) }} as conv_imp_time_avg,
    {{ json_extract_scalar('_airbyte_data', ['conv_click_time_avg'], ['conv_click_time_avg']) }} as conv_click_time_avg,
    {{ json_extract_scalar('_airbyte_data', ['unique_imp_inverse_rate'], ['unique_imp_inverse_rate']) }} as unique_imp_inverse_rate,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta_raw', raw_table) }}
-- account_line_items_stats
where 1 = 1
{{ incremental_clause('_airbyte_extracted_at') }}

