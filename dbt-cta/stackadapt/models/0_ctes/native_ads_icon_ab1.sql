{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_vfp_stackadapt_raw_v2",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('native_ads_base') }}
select
    _airbyte_native_ads_hashid,
    {{ json_extract_scalar('icon', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('icon', ['url'], ['url']) }} as url,
    {{ json_extract_scalar('icon', ['width'], ['width']) }} as width,
    {{ json_extract_scalar('icon', ['height'], ['height']) }} as height,
    {{ json_extract_scalar('icon', ['file_name'], ['file_name']) }} as file_name,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('native_ads_base') }} as table_alias
-- icon at native_ads/icon
where 1 = 1
and icon is not null

