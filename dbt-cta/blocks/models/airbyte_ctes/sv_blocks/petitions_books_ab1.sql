{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('sv_blocks', '_airbyte_raw_petitions_books') }}
select
    {{ json_extract_scalar('_airbyte_data', ['petition_book_number'], ['petition_book_number']) }} as petition_book_number,
    {{ json_extract_scalar('_airbyte_data', ['program_type'], ['program_type']) }} as program_type,
    {{ json_extract_scalar('_airbyte_data', ['canvasser_page_id'], ['canvasser_page_id']) }} as canvasser_page_id,
    {{ json_extract_scalar('_airbyte_data', ['notary_id'], ['notary_id']) }} as notary_id,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['user_id'], ['user_id']) }} as user_id,
    {{ json_extract_scalar('_airbyte_data', ['shift_id'], ['shift_id']) }} as shift_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['scan_file_filename'], ['scan_file_filename']) }} as scan_file_filename,
    {{ json_extract_scalar('_airbyte_data', ['scan_file_data'], ['scan_file_data']) }} as scan_file_data,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('sv_blocks', '_airbyte_raw_petitions_books') }} as table_alias
-- petitions_books
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

