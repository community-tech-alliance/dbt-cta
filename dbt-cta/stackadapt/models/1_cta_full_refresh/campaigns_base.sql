{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 2 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 3 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 4 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 5 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 6 day), day)'
] %}
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    partitions=partitions_to_replace
) }}
-- Final base SQL model
-- depends_on: {{ ref('campaigns_ab4') }}
select
    id,
    name,
    state,
    budget,
    channel,
    use_dma,
    bid_type,
    day_part,
    safe_cast(end_date as date) as end_date,
    timezone,
    daily_cap,
    safe_cast(start_date as date) as start_date,
    safe_cast(created_at as timestamp) as created_at,
    ip_options,
    safe_cast(updated_at as timestamp) as updated_at,
    pace_evenly,
    city_options,
    line_item_id,
    advertiser_id,
    campaign_type,
    domain_action,
    freq_cap_time,
    optimize_type,
    all_native_ads_ids,
    domain_options,
    freq_cap_limit,
    optimize_value,
    country_options,
    smart_targeting,
    weekday_budgets,
    weekday_enabled,
    bid_amount_total,
    category_options,
    language_options,
    us_state_options,
    weekday_percents,
    device_os_options,
    uk_county_options,
    conversion_tracker_ids,
    device_type_options,
    other_state_options,
    supply_type_options,
    custom_segments_list,
    third_party_segments,
    supply_source_options,
    allow_iframe_engagement,
    canada_province_options,
    connection_type_options,
    device_os_family_options,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_campaigns_hashid
from {{ ref('campaigns_ab4') }}
{% if is_incremental() %}
    where timestamp_trunc(_airbyte_extracted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}
