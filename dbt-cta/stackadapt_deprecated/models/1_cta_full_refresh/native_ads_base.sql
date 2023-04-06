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
-- depends_on: {{ ref('native_ads_ab3') }}
select
    id,
    icon,
    name,
    state,
    channel,
    cta_text,
    brandname,
    click_url,
    REGEXP_EXTRACT(click_url, r'utm_source=([^&]+)') as utm_source,
    REGEXP_EXTRACT(click_url, r'utm_medium=([^&]+)') as utm_medium,
    REGEXP_EXTRACT(click_url, r'utm_campaign=([^&]+)') as utm_campaign,
    REGEXP_EXTRACT(click_url, r'utm_term=([^&]+)') as utm_term,
    REGEXP_EXTRACT(click_url, r'utm_content=([^&]+)') as utm_content,
    creatives,
    input_data,
    audit_status,
    vast_trackers,
    api_frameworks,
    imp_tracker_urls,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_native_ads_hashid
from {{ ref('native_ads_ab3') }}
-- native_ads from {{ source('cta', '_airbyte_raw_native_ads') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

