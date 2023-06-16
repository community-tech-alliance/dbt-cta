{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('sv_blocks', '_airbyte_raw_imports_error_rows') }}
select
    {{ json_extract_scalar('_airbyte_data', ['errors_triggered'], ['errors_triggered']) }} as errors_triggered,
    {{ json_extract_scalar('_airbyte_data', ['import_id'], ['import_id']) }} as import_id,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['row_data'], ['row_data']) }} as row_data,
    {{ json_extract_scalar('_airbyte_data', ['duplicate_found'], ['duplicate_found']) }} as duplicate_found,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('sv_blocks', '_airbyte_raw_imports_error_rows') }} as table_alias
-- imports_error_rows
where 1 = 1

