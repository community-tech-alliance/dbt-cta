{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"}
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('creatives_base') }}
select
    id as creative_id,
    {{ json_extract_scalar('web_view_properties', ['url'], ['url']) }} as url,
    {{ json_extract_scalar('web_view_properties', ['block_preload'], ['block_preload']) }} as block_preload,
    {{ json_extract_array('web_view_properties', ['deep_link_urls'], ['deep_link_urls']) }} as deep_link_urls,
    {{ json_extract_scalar('web_view_properties', ['use_immersive_mode'], ['use_immersive_mode']) }} as use_immersive_mode,
    {{ json_extract_scalar('web_view_properties', ['allow_snap_javascript_sdk'], ['allow_snap_javascript_sdk']) }} as allow_snap_javascript_sdk,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('creatives_base') }}
-- web_view_properties at creatives_base/web_view_properties
where
    1 = 1
    and web_view_properties is not null
