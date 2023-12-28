{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_captricity_batches') }}
select
    {{ json_extract_scalar('_airbyte_data', ['rejected_at'], ['rejected_at']) }} as rejected_at,
    {{ json_extract_scalar('_airbyte_data', ['submitted_at'], ['submitted_at']) }} as submitted_at,
    {{ json_extract_scalar('_airbyte_data', ['voter_registration_scan_batch_id'], ['voter_registration_scan_batch_id']) }} as voter_registration_scan_batch_id,
    {{ json_extract_scalar('_airbyte_data', ['remote_id'], ['remote_id']) }} as remote_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['reject_reason'], ['reject_reason']) }} as reject_reason,
    {{ json_extract_scalar('_airbyte_data', ['petition_packet_id'], ['petition_packet_id']) }} as petition_packet_id,
    {{ json_extract_scalar('_airbyte_data', ['api_log'], ['api_log']) }} as api_log,
    {{ json_extract_scalar('_airbyte_data', ['imported_at'], ['imported_at']) }} as imported_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['petitions_book_id'], ['petitions_book_id']) }} as petitions_book_id,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_captricity_batches') }}
-- captricity_batches
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

