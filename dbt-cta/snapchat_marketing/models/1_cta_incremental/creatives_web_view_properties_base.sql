{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'creative_id'
) }}

-- depends_on: {{ ref('creatives_web_view_properties_ab3') }}
select
    creative_id,
    url,
    block_preload,
    deep_link_urls,
    use_immersive_mode,
    allow_snap_javascript_sdk,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    regexp_extract(url, r'utm_source=([^&]+)') as utm_source,
    regexp_extract(url, r'utm_medium=([^&]+)') as utm_medium,
    regexp_extract(url, r'utm_campaign=([^&]+)') as utm_campaign,
    regexp_extract(url, r'utm_term=([^&]+)') as utm_term,
    regexp_extract(regexp_extract(url, r'utm_content=([^&]+)'), r'([a-zA-Z0-9]+)') as utm_content,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('creatives_web_view_properties_ab3') }}
