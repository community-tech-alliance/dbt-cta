{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('account_native_ads_stats_ab1') }}
select
    cast(ctr as {{ dbt_utils.type_float() }}) as ctr,
    cast(cvr as {{ dbt_utils.type_float() }}) as cvr,
    cast(imp as {{ dbt_utils.type_bigint() }}) as imp,
    cast(ltr as {{ dbt_utils.type_float() }}) as ltr,
    cast(atos as {{ dbt_utils.type_float() }}) as atos,
    cast(conv as {{ dbt_utils.type_bigint() }}) as conv,
    cast(cost as {{ dbt_utils.type_float() }}) as cost,
    cast(date as {{ dbt_utils.type_string() }}) as date,
    cast(ecpa as {{ dbt_utils.type_float() }}) as ecpa,
    cast(ecpc as {{ dbt_utils.type_float() }}) as ecpc,
    cast(ecpe as {{ dbt_utils.type_float() }}) as ecpe,
    cast(ecpm as {{ dbt_utils.type_float() }}) as ecpm,
    cast(ecpv as {{ dbt_utils.type_float() }}) as ecpv,
    cast(rcpc as {{ dbt_utils.type_float() }}) as rcpc,
    cast(rcpe as {{ dbt_utils.type_float() }}) as rcpe,
    cast(rcpm as {{ dbt_utils.type_float() }}) as rcpm,
    cast(roas as {{ dbt_utils.type_float() }}) as roas,
    cast(click as {{ dbt_utils.type_bigint() }}) as click,
    cast(ecpcl as {{ dbt_utils.type_float() }}) as ecpcl,
    cast(rcpcl as {{ dbt_utils.type_float() }}) as rcpcl,
    cast(domain as {{ dbt_utils.type_string() }}) as domain,
    cast(ios_id as {{ dbt_utils.type_bigint() }}) as ios_id,
    safe_cast(is_ios as boolean) as is_ios,
    cast(profit as {{ dbt_utils.type_float() }}) as profit,
    cast(s_conv as {{ dbt_utils.type_bigint() }}) as s_conv,
    cast(channel as {{ dbt_utils.type_string() }}) as channel,
    cast(conv_ip as {{ dbt_utils.type_bigint() }}) as conv_ip,
    cast(heading as {{ dbt_utils.type_string() }}) as heading,
    cast(revenue as {{ dbt_utils.type_float() }}) as revenue,
    cast(tagline as {{ dbt_utils.type_string() }}) as tagline,
    cast(vcomp_0 as {{ dbt_utils.type_float() }}) as vcomp_0,
    cast(campaign as {{ dbt_utils.type_string() }}) as campaign,
    cast(end_date as {{ dbt_utils.type_string() }}) as end_date,
    cast(nativead as {{ dbt_utils.type_string() }}) as nativead,
    cast(vcomp_25 as {{ dbt_utils.type_float() }}) as vcomp_25,
    cast(vcomp_50 as {{ dbt_utils.type_float() }}) as vcomp_50,
    cast(vcomp_75 as {{ dbt_utils.type_float() }}) as vcomp_75,
    cast(vcomp_95 as {{ dbt_utils.type_float() }}) as vcomp_95,
    cast(click_url as {{ dbt_utils.type_string() }}) as click_url,
    creatives,
    cast(line_item as {{ dbt_utils.type_string() }}) as line_item,
    cast(page_time as {{ dbt_utils.type_bigint() }}) as page_time,
    cast(uniq_conv as {{ dbt_utils.type_bigint() }}) as uniq_conv,
    cast(atos_units as {{ dbt_utils.type_float() }}) as atos_units,
    cast(conv_click as {{ dbt_utils.type_bigint() }}) as conv_click,
    safe_cast(is_android as boolean) as is_android,
    cast(page_start as {{ dbt_utils.type_bigint() }}) as page_start,
    cast(start_date as {{ dbt_utils.type_string() }}) as start_date,
    cast(unique_imp as {{ dbt_utils.type_bigint() }}) as unique_imp,
    cast(vcomp_rate as {{ dbt_utils.type_float() }}) as vcomp_rate,
    cast(campaign_id as {{ dbt_utils.type_bigint() }}) as campaign_id,
    cast(engage_rate as {{ dbt_utils.type_float() }}) as engage_rate,
    cast(full_domain as {{ dbt_utils.type_string() }}) as full_domain,
    cast(tp_cpc_cost as {{ dbt_utils.type_float() }}) as tp_cpc_cost,
    cast(tp_cpm_cost as {{ dbt_utils.type_float() }}) as tp_cpm_cost,
    cast(unique_conv as {{ dbt_utils.type_bigint() }}) as unique_conv,
    cast(line_item_id as {{ dbt_utils.type_bigint() }}) as line_item_id,
    cast(native_ad_id as {{ dbt_utils.type_bigint() }}) as native_ad_id,
    cast(view_percent as {{ dbt_utils.type_float() }}) as view_percent,
    cast(campaign_type as {{ dbt_utils.type_string() }}) as campaign_type,
    cast(page_time_15s as {{ dbt_utils.type_bigint() }}) as page_time_15s,
    cast(native_ad_type as {{ dbt_utils.type_string() }}) as native_ad_type,
    cast(sub_advertiser as {{ dbt_utils.type_string() }}) as sub_advertiser,
    cast(page_time_units as {{ dbt_utils.type_bigint() }}) as page_time_units,
    cast(conv_imp_derived as {{ dbt_utils.type_bigint() }}) as conv_imp_derived,
    cast(conv_imp_time_avg as {{ dbt_utils.type_float() }}) as conv_imp_time_avg,
    cast(sub_advertiser_id as {{ dbt_utils.type_bigint() }}) as sub_advertiser_id,
    cast(conv_click_time_avg as {{ dbt_utils.type_float() }}) as conv_click_time_avg,
    cast(unique_imp_inverse_rate as {{ dbt_utils.type_float() }}) as unique_imp_inverse_rate,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('account_native_ads_stats_ab1') }}
-- account_native_ads_stats
where 1 = 1
{{ incremental_clause('_airbyte_extracted_at') }}

