{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}

-- depends_on: {{ ref('creatives_web_view_properties_ab3') }}
select
    _airbyte_creatives_hashid,
    url,
    REGEXP_EXTRACT(url,r'utm_source=([^&]+)') as utm_source,
    REGEXP_EXTRACT(url,r'utm_medium=([^&]+)') as utm_medium,
    REGEXP_EXTRACT(url,r'utm_campaign=([^&]+)') as utm_campaign,
    REGEXP_EXTRACT(url,r'utm_term=([^&]+)') as utm_term,
    REGEXP_EXTRACT(REGEXP_EXTRACT(url,r'utm_content=([^&]+)'),r'([a-zA-Z0-9]+)') as utm_content,
    block_preload,
    deep_link_urls,
    use_immersive_mode,
    allow_snap_javascript_sdk,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_web_view_properties_hashid
from {{ ref('creatives_web_view_properties_ab3') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

