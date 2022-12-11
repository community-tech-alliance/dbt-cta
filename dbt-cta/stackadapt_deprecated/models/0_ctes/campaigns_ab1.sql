{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_campaigns') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['goal'], ['goal']) }} as goal,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['state'], ['state']) }} as state,
    {{ json_extract_scalar('_airbyte_data', ['budget'], ['budget']) }} as budget,
    {{ json_extract_scalar('_airbyte_data', ['channel'], ['channel']) }} as channel,
    {{ json_extract_scalar('_airbyte_data', ['use_dma'], ['use_dma']) }} as use_dma,
    {{ json_extract_scalar('_airbyte_data', ['bid_type'], ['bid_type']) }} as bid_type,
    {{ json_extract('table_alias', '_airbyte_data', ['day_part'], ['day_part']) }} as day_part,
    {{ json_extract_scalar('_airbyte_data', ['end_date'], ['end_date']) }} as end_date,
    {{ json_extract_scalar('_airbyte_data', ['daily_cap'], ['daily_cap']) }} as daily_cap,
    {{ json_extract_scalar('_airbyte_data', ['start_date'], ['start_date']) }} as start_date,
    {{ json_extract_scalar('_airbyte_data', ['pace_evenly'], ['pace_evenly']) }} as pace_evenly,
    {{ json_extract_scalar('_airbyte_data', ['city_options'], ['city_options']) }} as city_options,
    {{ json_extract_scalar('_airbyte_data', ['line_item_id'], ['line_item_id']) }} as line_item_id,
    {{ json_extract_scalar('_airbyte_data', ['advertiser_id'], ['advertiser_id']) }} as advertiser_id,
    {{ json_extract_scalar('_airbyte_data', ['campaign_type'], ['campaign_type']) }} as campaign_type,
    {{ json_extract_scalar('_airbyte_data', ['domain_action'], ['domain_action']) }} as domain_action,
    {{ json_extract_scalar('_airbyte_data', ['freq_cap_time'], ['freq_cap_time']) }} as freq_cap_time,
    {{ json_extract_scalar('_airbyte_data', ['optimize_type'], ['optimize_type']) }} as optimize_type,
    {{ json_extract_array('_airbyte_data', ['all_native_ads'], ['all_native_ads']) }} as all_native_ads,
    {{ json_extract_array('_airbyte_data', ['domain_options'], ['domain_options']) }} as domain_options,
    {{ json_extract_scalar('_airbyte_data', ['freq_cap_limit'], ['freq_cap_limit']) }} as freq_cap_limit,
    {{ json_extract_scalar('_airbyte_data', ['optimize_value'], ['optimize_value']) }} as optimize_value,
    {{ json_extract_array('_airbyte_data', ['country_options'], ['country_options']) }} as country_options,
    {{ json_extract_scalar('_airbyte_data', ['smart_targeting'], ['smart_targeting']) }} as smart_targeting,
    {{ json_extract_array('_airbyte_data', ['weekday_budgets'], ['weekday_budgets']) }} as weekday_budgets,
    {{ json_extract_scalar('_airbyte_data', ['weekday_enabled'], ['weekday_enabled']) }} as weekday_enabled,
    {{ json_extract_scalar('_airbyte_data', ['bid_amount_total'], ['bid_amount_total']) }} as bid_amount_total,
    {{ json_extract_array('_airbyte_data', ['category_options'], ['category_options']) }} as category_options,
    {{ json_extract_array('_airbyte_data', ['language_options'], ['language_options']) }} as language_options,
    {{ json_extract_array('_airbyte_data', ['us_state_options'], ['us_state_options']) }} as us_state_options,
    {{ json_extract_array('_airbyte_data', ['weekday_percents'], ['weekday_percents']) }} as weekday_percents,
    {{ json_extract_array('_airbyte_data', ['uk_county_options'], ['uk_county_options']) }} as uk_county_options,
    {{ json_extract_array('_airbyte_data', ['device_type_options'], ['device_type_options']) }} as device_type_options,
    {{ json_extract_array('_airbyte_data', ['other_state_options'], ['other_state_options']) }} as other_state_options,
    {{ json_extract_array('_airbyte_data', ['supply_type_options'], ['supply_type_options']) }} as supply_type_options,
    {{ json_extract_array('_airbyte_data', ['custom_segments_list'], ['custom_segments_list']) }} as custom_segments_list,
    {{ json_extract_array('_airbyte_data', ['third_party_segments'], ['third_party_segments']) }} as third_party_segments,
    {{ json_extract_array('_airbyte_data', ['supply_source_options'], ['supply_source_options']) }} as supply_source_options,
    {{ json_extract_scalar('_airbyte_data', ['allow_iframe_engagement'], ['allow_iframe_engagement']) }} as allow_iframe_engagement,
    {{ json_extract_array('_airbyte_data', ['canada_province_options'], ['canada_province_options']) }} as canada_province_options,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_campaigns') }} as table_alias
-- campaigns
where 1 = 1

