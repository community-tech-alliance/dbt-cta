{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_vfp_stackadapt_raw_v2",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('native_ads_input_data_base') }}
{{ unnest_cte(ref('native_ads_input_data_base'), 'input_data', 'display_js_creative') }}
select
    _airbyte_input_data_hashid,
    {{ json_extract_scalar(unnested_column_value('display_js_creative'), ['width'], ['width']) }} as width,
    {{ json_extract_scalar(unnested_column_value('display_js_creative'), ['height'], ['height']) }} as height,
    {{ json_extract_scalar(unnested_column_value('display_js_creative'), ['img_url'], ['img_url']) }} as img_url,
    {{ json_extract_scalar(unnested_column_value('display_js_creative'), ['js_code'], ['js_code']) }} as js_code,
    {{ json_extract_scalar(unnested_column_value('display_js_creative'), ['is_expandable'], ['is_expandable']) }} as is_expandable,
    {{ json_extract_scalar(unnested_column_value('display_js_creative'), ['js_code_macro'], ['js_code_macro']) }} as js_code_macro,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('native_ads_input_data_base') }} as table_alias
-- display_js_creative at native_ads/input_data/display_js_creative
{{ cross_join_unnest('input_data', 'display_js_creative') }}
where 1 = 1
and display_js_creative is not null

