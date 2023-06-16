{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('sv_blocks', '_airbyte_raw_import_files') }}
select
    {{ json_extract_scalar('_airbyte_data', ['tenant_id'], ['tenant_id']) }} as tenant_id,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['user_id'], ['user_id']) }} as user_id,
    {{ json_extract_scalar('_airbyte_data', ['file_name_data'], ['file_name_data']) }} as file_name_data,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['encoding'], ['encoding']) }} as encoding,
    {{ json_extract_scalar('_airbyte_data', ['file_size'], ['file_size']) }} as file_size,
    {{ json_extract_scalar('_airbyte_data', ['row_count'], ['row_count']) }} as row_count,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('sv_blocks', '_airbyte_raw_import_files') }} as table_alias
-- import_files
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

