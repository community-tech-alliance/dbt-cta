{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_vfp_stackadapt_raw_v2",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('native_ads_base') }}
select
    _airbyte_native_ads_hashid,
    JSON_EXTRACT_SCALAR(input_data, '$.heading') as heading,
    JSON_EXTRACT_SCALAR(input_data, '$.tagline') as tagline,
    JSON_EXTRACT_SCALAR(input_data, '$.vast_xml') as vast_xml,
    JSON_EXTRACT_SCALAR(input_data, '$.landing_url') as landing_url,
    JSON_EXTRACT_ARRAY(input_data, '$.audio_creatives') as audio_creatives,
    JSON_EXTRACT_ARRAY(input_data, '$.video_creatives') as video_creatives,
    JSON_EXTRACT_ARRAY(input_data, '$.display_js_creative') as display_js_creative,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('native_ads_base') }}
where input_data is not null
