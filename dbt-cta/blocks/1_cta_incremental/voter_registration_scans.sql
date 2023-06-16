{{ config(
    cluster_by = ["_airbyte_unique_key","_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_unique_key",
    schema = "sv_blocks",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('voter_registration_scans_scd') }}
select
    _airbyte_unique_key,
    remote_captricity_batch_file_id,
    notes,
    reviewed_by_user_id,
    voter_registration_scan_batch_id,
    delivery_id,
    reviewed_at,
    county,
    created_at,
    jpg_data,
    file_data,
    scan_number,
    updated_at,
    turn_in_location_id,
    digitization_data,
    id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_voter_registration_scans_hashid
from {{ ref('voter_registration_scans_scd') }}
-- voter_registration_scans from {{ source('sv_blocks', '_airbyte_raw_voter_registration_scans') }}
where 1 = 1
and _airbyte_active_row = 1
{{ incremental_clause('_airbyte_emitted_at') }}

