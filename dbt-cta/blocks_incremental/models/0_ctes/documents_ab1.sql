{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_documents') }}
select
    {{ json_extract_scalar('_airbyte_data', ['tenant_id'], ['tenant_id']) }} as tenant_id,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['user_id'], ['user_id']) }} as user_id,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['folder_id'], ['folder_id']) }} as folder_id,
    {{ json_extract_scalar('_airbyte_data', ['file_data'], ['file_data']) }} as file_data,
    {{ json_extract_scalar('_airbyte_data', ['file_locator'], ['file_locator']) }} as file_locator,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_documents') }} as table_alias
-- documents
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

