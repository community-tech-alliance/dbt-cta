{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_vfp_stackadapt_raw_v2",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('native_ads') }}
select
    _airbyte_native_ads_hashid,
    {{ json_extract_scalar('input_data', ['heading'], ['heading']) }} as heading,
    {{ json_extract_scalar('input_data', ['tagline'], ['tagline']) }} as tagline,
    {{ json_extract_scalar('input_data', ['vast_xml'], ['vast_xml']) }} as vast_xml,
    {{ json_extract_scalar('input_data', ['landing_url'], ['landing_url']) }} as landing_url,
    {{ json_extract_array('input_data', ['audio_creatives'], ['audio_creatives']) }} as audio_creatives,
    {{ json_extract_array('input_data', ['video_creatives'], ['video_creatives']) }} as video_creatives,
    {{ json_extract_array('input_data', ['display_js_creative'], ['display_js_creative']) }} as display_js_creative,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('native_ads') }} as table_alias
-- input_data at native_ads/input_data
where 1 = 1
and input_data is not null

