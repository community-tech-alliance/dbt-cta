{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_quality_control_flags_voter_registration_scans') }}
select
    {{ json_extract_scalar('_airbyte_data', ['voter_registration_scan_id'], ['voter_registration_scan_id']) }} as voter_registration_scan_id,
    {{ json_extract_scalar('_airbyte_data', ['quality_control_flag_id'], ['quality_control_flag_id']) }} as quality_control_flag_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_quality_control_flags_voter_registration_scans') }}
-- quality_control_flags_voter_registration_scans
where 1 = 1
