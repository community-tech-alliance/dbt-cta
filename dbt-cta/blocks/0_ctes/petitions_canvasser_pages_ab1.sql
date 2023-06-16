{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('sv_blocks', '_airbyte_raw_petitions_canvasser_pages') }}
select
    {{ json_extract_scalar('_airbyte_data', ['signed_in'], ['signed_in']) }} as signed_in,
    {{ json_extract_scalar('_airbyte_data', ['canvasser_id'], ['canvasser_id']) }} as canvasser_id,
    {{ json_extract_scalar('_airbyte_data', ['sign_out_date'], ['sign_out_date']) }} as sign_out_date,
    {{ json_extract_scalar('_airbyte_data', ['extras'], ['extras']) }} as extras,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['book_id'], ['book_id']) }} as book_id,
    {{ json_extract_scalar('_airbyte_data', ['sign_in_date'], ['sign_in_date']) }} as sign_in_date,
    {{ json_extract_scalar('_airbyte_data', ['scan_file_data'], ['scan_file_data']) }} as scan_file_data,
    {{ json_extract_scalar('_airbyte_data', ['program_type'], ['program_type']) }} as program_type,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['signed_out'], ['signed_out']) }} as signed_out,
    {{ json_extract_scalar('_airbyte_data', ['shift_id'], ['shift_id']) }} as shift_id,
    {{ json_extract_scalar('_airbyte_data', ['organization_id'], ['organization_id']) }} as organization_id,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('sv_blocks', '_airbyte_raw_petitions_canvasser_pages') }} as table_alias
-- petitions_canvasser_pages
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

