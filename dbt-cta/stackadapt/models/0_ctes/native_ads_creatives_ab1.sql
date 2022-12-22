{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_vfp_stackadapt_raw_v2",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('native_ads') }}
{{ unnest_cte(ref('native_ads'), 'native_ads', 'creatives') }}
select
    _airbyte_native_ads_hashid,
    {{ json_extract_scalar(unnested_column_value('creatives'), ['id'], ['id']) }} as id,
    {{ json_extract_scalar(unnested_column_value('creatives'), ['url'], ['url']) }} as url,
    {{ json_extract_scalar(unnested_column_value('creatives'), ['width'], ['width']) }} as width,
    {{ json_extract_scalar(unnested_column_value('creatives'), ['height'], ['height']) }} as height,
    {{ json_extract_scalar(unnested_column_value('creatives'), ['file_name'], ['file_name']) }} as file_name,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('native_ads') }} as table_alias
-- creatives at native_ads/creatives
{{ cross_join_unnest('native_ads', 'creatives') }}
where 1 = 1
and creatives is not null

