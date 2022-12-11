{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('campaigns_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(goal as {{ dbt_utils.type_string() }}) as goal,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(state as {{ dbt_utils.type_string() }}) as state,
    cast(budget as {{ dbt_utils.type_float() }}) as budget,
    cast(channel as {{ dbt_utils.type_string() }}) as channel,
    {{ cast_to_boolean('use_dma') }} as use_dma,
    cast(bid_type as {{ dbt_utils.type_string() }}) as bid_type,
    day_part,
    cast(end_date as {{ dbt_utils.type_string() }}) as end_date,
    cast(daily_cap as {{ dbt_utils.type_float() }}) as daily_cap,
    cast(start_date as {{ dbt_utils.type_string() }}) as start_date,
    {{ cast_to_boolean('pace_evenly') }} as pace_evenly,
    cast(city_options as {{ dbt_utils.type_string() }}) as city_options,
    cast(line_item_id as {{ dbt_utils.type_bigint() }}) as line_item_id,
    cast(advertiser_id as {{ dbt_utils.type_bigint() }}) as advertiser_id,
    cast(campaign_type as {{ dbt_utils.type_string() }}) as campaign_type,
    cast(domain_action as {{ dbt_utils.type_string() }}) as domain_action,
    cast(freq_cap_time as {{ dbt_utils.type_bigint() }}) as freq_cap_time,
    cast(optimize_type as {{ dbt_utils.type_string() }}) as optimize_type,
    array(select json_extract_scalar(native_ad, '$.id') from unnest(all_native_ads) as native_ad) as all_native_ads_ids,
    domain_options,
    cast(freq_cap_limit as {{ dbt_utils.type_bigint() }}) as freq_cap_limit,
    cast(optimize_value as {{ dbt_utils.type_float() }}) as optimize_value,
    country_options,
    {{ cast_to_boolean('smart_targeting') }} as smart_targeting,
    weekday_budgets,
    {{ cast_to_boolean('weekday_enabled') }} as weekday_enabled,
    cast(bid_amount_total as {{ dbt_utils.type_float() }}) as bid_amount_total,
    category_options,
    language_options,
    us_state_options,
    weekday_percents,
    uk_county_options,
    device_type_options,
    other_state_options,
    supply_type_options,
    custom_segments_list,
    third_party_segments,
    supply_source_options,
    {{ cast_to_boolean('allow_iframe_engagement') }} as allow_iframe_engagement,
    canada_province_options,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns_ab1') }}
-- campaigns
where 1 = 1

