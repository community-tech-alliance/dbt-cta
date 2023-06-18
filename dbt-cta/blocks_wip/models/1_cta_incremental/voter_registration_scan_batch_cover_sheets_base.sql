{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id",
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('voter_registration_scan_batch_cover_sheets_ab3') }}
select
    updated_at,
    voter_registration_scan_batch_id,
    created_at,
    id,
    file_data,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_voter_registration_scan_batch_cover_sheets_hashid
from {{ ref('voter_registration_scan_batch_cover_sheets_ab3') }}
-- voter_registration_scan_batch_cover_sheets from {{ source('cta', '_airbyte_raw_voter_registration_scan_batch_cover_sheets') }}

