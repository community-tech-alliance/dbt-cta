{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_vfp_stackadapt_raw_v2",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('native_ads_input_data_base') }}
{{ unnest_cte(ref('native_ads_input_data_base'), 'input_data', 'video_creatives') }}
select
    _airbyte_input_data_hashid,
    {{ json_extract_scalar(unnested_column_value('video_creatives'), ['width'], ['width']) }} as width,
    {{ json_extract_scalar(unnested_column_value('video_creatives'), ['height'], ['height']) }} as height,
    {{ json_extract_scalar(unnested_column_value('video_creatives'), ['s3_url'], ['s3_url']) }} as s3_url,
    {{ json_extract_scalar(unnested_column_value('video_creatives'), ['bitrate'], ['bitrate']) }} as bitrate,
    {{ json_extract_scalar(unnested_column_value('video_creatives'), ['duration'], ['duration']) }} as duration,
    {{ json_extract_scalar(unnested_column_value('video_creatives'), ['file_type'], ['file_type']) }} as file_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('native_ads_input_data_base') }}
-- video_creatives at native_ads/input_data/video_creatives
{{ cross_join_unnest('input_data', 'video_creatives') }}
where
    1 = 1
    and video_creatives is not null
