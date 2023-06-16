{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('sv_blocks', '_airbyte_raw_voter_registration_scan_batches') }}
select
    {{ json_extract_scalar('_airbyte_data', ['scans_count'], ['scans_count']) }} as scans_count,
    {{ json_extract_scalar('_airbyte_data', ['needs_separation'], ['needs_separation']) }} as needs_separation,
    {{ json_extract_scalar('_airbyte_data', ['qc_deadline'], ['qc_deadline']) }} as qc_deadline,
    {{ json_extract_scalar('_airbyte_data', ['scans_with_phones_count'], ['scans_with_phones_count']) }} as scans_with_phones_count,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['created_by_user_id'], ['created_by_user_id']) }} as created_by_user_id,
    {{ json_extract_scalar('_airbyte_data', ['file_data'], ['file_data']) }} as file_data,
    {{ json_extract_scalar('_airbyte_data', ['separating_at'], ['separating_at']) }} as separating_at,
    {{ json_extract_scalar('_airbyte_data', ['scans_need_delivery'], ['scans_need_delivery']) }} as scans_need_delivery,
    {{ json_extract_scalar('_airbyte_data', ['separating'], ['separating']) }} as separating,
    {{ json_extract_scalar('_airbyte_data', ['original_filename'], ['original_filename']) }} as original_filename,
    {{ json_extract_scalar('_airbyte_data', ['file_hash'], ['file_hash']) }} as file_hash,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['shift_id'], ['shift_id']) }} as shift_id,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['assignee_id'], ['assignee_id']) }} as assignee_id,
    {{ json_extract_scalar('_airbyte_data', ['file_locator'], ['file_locator']) }} as file_locator,
    {{ json_extract_scalar('_airbyte_data', ['van_batch_id'], ['van_batch_id']) }} as van_batch_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('sv_blocks', '_airbyte_raw_voter_registration_scan_batches') }} as table_alias
-- voter_registration_scan_batches
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

