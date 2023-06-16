{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('sv_blocks', '_airbyte_raw_versions') }}
select
    {{ json_extract_scalar('_airbyte_data', ['item_id'], ['item_id']) }} as item_id,
    {{ json_extract_scalar('_airbyte_data', ['item_type'], ['item_type']) }} as item_type,
    {{ json_extract_scalar('_airbyte_data', ['object_yaml'], ['object_yaml']) }} as object_yaml,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['event'], ['event']) }} as event,
    {{ json_extract_scalar('_airbyte_data', ['whodunnit'], ['whodunnit']) }} as whodunnit,
    {{ json_extract_scalar('_airbyte_data', ['object'], ['object']) }} as object,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('sv_blocks', '_airbyte_raw_versions') }} as table_alias
-- versions
where 1 = 1

