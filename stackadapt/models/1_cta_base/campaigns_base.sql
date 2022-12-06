{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}
{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    partitions=partitions_to_replace
) }}
-- Final base SQL model
-- depends_on: {{ ref('campaigns_ab3') }}
select
    id,
    goal,
    name,
    state,
    budget,
    channel,
    use_dma,
    bid_type,
    day_part,
    SAFE_CAST(end_date as timestamp) as end_date,
    daily_cap,
    SAFE_CAST(start_date as timestamp) as start_date,
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
    uk_county_options,
    device_type_options,
    other_state_options,
    supply_type_options,
    custom_segments_list,
    third_party_segments,
    supply_source_options,
    allow_iframe_engagement,
    canada_province_options,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_campaigns_hashid
from {{ ref('campaigns_ab3') }}
-- campaigns from {{ source('cta', '_airbyte_raw_campaigns') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

