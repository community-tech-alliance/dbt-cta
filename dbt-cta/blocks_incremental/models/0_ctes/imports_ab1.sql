{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_imports') }}
select
    {{ json_extract_scalar('_airbyte_data', ['mapping'], ['mapping']) }} as mapping,
    {{ json_extract_scalar('_airbyte_data', ['list_id'], ['list_id']) }} as list_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['for_phone_bank'], ['for_phone_bank']) }} as for_phone_bank,
    {{ json_extract_scalar('_airbyte_data', ['stored_spreadsheet_data'], ['stored_spreadsheet_data']) }} as stored_spreadsheet_data,
    {{ json_extract_scalar('_airbyte_data', ['original_spreadsheet_data'], ['original_spreadsheet_data']) }} as original_spreadsheet_data,
    {{ json_extract_scalar('_airbyte_data', ['record_type'], ['record_type']) }} as record_type,
    {{ json_extract_scalar('_airbyte_data', ['imported_rows_count'], ['imported_rows_count']) }} as imported_rows_count,
    {{ json_extract_scalar('_airbyte_data', ['mappings'], ['mappings']) }} as mappings,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['user_id'], ['user_id']) }} as user_id,
    {{ json_extract_scalar('_airbyte_data', ['worker_jid'], ['worker_jid']) }} as worker_jid,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_imports') }}
-- imports
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

