{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_offices') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['type'], ['type']) }} as type,
    {{ json_extract_scalar('_airbyte_data', ['geoid'], ['geoid']) }} as geoid,
    {{ json_extract_scalar('_airbyte_data', ['hours'], ['hours']) }} as hours,
    {{ json_extract_scalar('_airbyte_data', ['notes'], ['notes']) }} as notes,
    {{ json_extract_scalar('_airbyte_data', ['region'], ['region']) }} as region,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['updated'], ['updated']) }} as updated,
    {{ json_extract_array('_airbyte_data', ['addresses'], ['addresses']) }} as addresses,
    {{ json_extract_array('_airbyte_data', ['officials'], ['officials']) }} as officials,
    {{ json_extract_scalar('_airbyte_data', ['resource_uri'], ['resource_uri']) }} as resource_uri,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_offices') }} as table_alias
-- offices
where 1 = 1

