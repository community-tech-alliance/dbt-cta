{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_vfp_stackadapt_raw",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('native_ads_base') }}
select
    _airbyte_native_ads_hashid,
    {{ json_extract_scalar('input_data', ['width'], ['width']) }} as width,
    {{ json_extract_scalar('input_data', ['height'], ['height']) }} as height,
    {{ json_extract_scalar('input_data', ['heading'], ['heading']) }} as heading,
    {{ json_extract_scalar('input_data', ['img_url'], ['img_url']) }} as img_url,
    {{ json_extract_scalar('input_data', ['js_code'], ['js_code']) }} as js_code,
    {{ json_extract_scalar('input_data', ['tagline'], ['tagline']) }} as tagline,
    {{ json_extract_scalar('input_data', ['is_expandable'], ['is_expandable']) }} as is_expandable,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('native_ads_base') }} as table_alias
-- input_data at native_ads/input_data
where 1 = 1
and input_data is not null

