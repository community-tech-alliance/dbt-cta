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
    partitions = partitions_to_replace,
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'creative_id'
) }}

-- depends_on: {{ ref('creatives_web_view_properties_ab2') }}
select
    creative_id,
    url,
    block_preload,
    deep_link_urls,
    use_immersive_mode,
    allow_snap_javascript_sdk,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    regexp_extract(url, r'utm_source=([^&]+)') as utm_source,
    regexp_extract(url, r'utm_medium=([^&]+)') as utm_medium,
    regexp_extract(url, r'utm_campaign=([^&]+)') as utm_campaign,
    regexp_extract(url, r'utm_term=([^&]+)') as utm_term,
    regexp_extract(regexp_extract(url, r'utm_content=([^&]+)'), r'([a-zA-Z0-9]+)') as utm_content,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('creatives_web_view_properties_ab2') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}
