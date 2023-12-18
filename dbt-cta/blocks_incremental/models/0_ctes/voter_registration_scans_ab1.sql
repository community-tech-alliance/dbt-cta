{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_voter_registration_scans') }}
select
    {{ json_extract_scalar('_airbyte_data', ['remote_captricity_batch_file_id'], ['remote_captricity_batch_file_id']) }} as remote_captricity_batch_file_id,
    {{ json_extract_scalar('_airbyte_data', ['notes'], ['notes']) }} as notes,
    {{ json_extract_scalar('_airbyte_data', ['reviewed_by_user_id'], ['reviewed_by_user_id']) }} as reviewed_by_user_id,
    {{ json_extract_scalar('_airbyte_data', ['voter_registration_scan_batch_id'], ['voter_registration_scan_batch_id']) }} as voter_registration_scan_batch_id,
    {{ json_extract_scalar('_airbyte_data', ['delivery_id'], ['delivery_id']) }} as delivery_id,
    {{ json_extract_scalar('_airbyte_data', ['reviewed_at'], ['reviewed_at']) }} as reviewed_at,
    {{ json_extract_scalar('_airbyte_data', ['county'], ['county']) }} as county,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['jpg_data'], ['jpg_data']) }} as jpg_data,
    {{ json_extract_scalar('_airbyte_data', ['file_data'], ['file_data']) }} as file_data,
    {{ json_extract_scalar('_airbyte_data', ['scan_number'], ['scan_number']) }} as scan_number,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['turn_in_location_id'], ['turn_in_location_id']) }} as turn_in_location_id,
    {{ json_extract_scalar('_airbyte_data', ['digitization_data'], ['digitization_data']) }} as digitization_data,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_voter_registration_scans') }} as table_alias
-- voter_registration_scans
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

