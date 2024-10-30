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
-- depends_on: {{ ref('native_ads_ab4') }}
select
    id,
    icon,
    name,
    state,
    channel,
    cta_text,
    brandname,
    click_url,
    regexp_extract(click_url, r'utm_source=([^&]+)') as utm_source,
    regexp_extract(click_url, r'utm_medium=([^&]+)') as utm_medium,
    regexp_extract(click_url, r'utm_campaign=([^&]+)') as utm_campaign,
    regexp_extract(click_url, r'utm_term=([^&]+)') as utm_term,
    regexp_extract(click_url, r'utm_content=([^&]+)') as utm_content,
    creatives,
    created_at,
    input_data,
    updated_at,
    audit_status,
    vast_trackers,
    api_frameworks,
    imp_tracker_urls,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_native_ads_hashid
from {{ ref('native_ads_ab4') }}
{% if is_incremental() %}
    where timestamp_trunc(_airbyte_extracted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}
