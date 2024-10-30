{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_vfp_stackadapt_raw_v2",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('native_ads_input_data_base') }}
{select
    _airbyte_input_data_hashid,
    JSON_EXTRACT_SCALAR(display_js_creative, '$.width') as width,
    JSON_EXTRACT_SCALAR(display_js_creative, '$.height') as height,
    JSON_EXTRACT_SCALAR(display_js_creative, '$.img_url') as img_url,
    JSON_EXTRACT_SCALAR(display_js_creative, '$.js_code') as js_code,
    JSON_EXTRACT_SCALAR(display_js_creative, '$.is_expandable') as is_expandable,
    JSON_EXTRACT_SCALAR(display_js_creative, '$.js_code_macro') as js_code_macro,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('native_ads_input_data_base') }}
where display_js_creative is not null
