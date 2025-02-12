{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_vfp_stackadapt_raw_v2",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('native_ads_input_data_base') }}
{{ unnest_cte(ref('native_ads_input_data_base'), 'input_data', 'audio_creatives') }}
select
    _airbyte_input_data_hashid,
    {{ json_extract_scalar(unnested_column_value('audio_creatives'), ['width'], ['width']) }} as width,
    {{ json_extract_scalar(unnested_column_value('audio_creatives'), ['height'], ['height']) }} as height,
    {{ json_extract_scalar(unnested_column_value('audio_creatives'), ['s3_url'], ['s3_url']) }} as s3_url,
    {{ json_extract_scalar(unnested_column_value('audio_creatives'), ['bitrate'], ['bitrate']) }} as bitrate,
    {{ json_extract_scalar(unnested_column_value('audio_creatives'), ['duration'], ['duration']) }} as duration,
    {{ json_extract_scalar(unnested_column_value('audio_creatives'), ['file_type'], ['file_type']) }} as file_type,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('native_ads_input_data_base') }}
-- audio_creatives at native_ads/input_data/audio_creatives
{{ cross_join_unnest('input_data', 'audio_creatives') }}
where
    1 = 1
    and audio_creatives is not null
