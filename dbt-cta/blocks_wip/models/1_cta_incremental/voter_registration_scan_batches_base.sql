{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id",
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('voter_registration_scan_batches_ab3') }}
select
    scans_count,
    needs_separation,
    qc_deadline,
    scans_with_phones_count,
    created_at,
    created_by_user_id,
    file_data,
    separating_at,
    scans_need_delivery,
    separating,
    original_filename,
    file_hash,
    updated_at,
    shift_id,
    id,
    assignee_id,
    file_locator,
    van_batch_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_voter_registration_scan_batches_hashid
from {{ ref('voter_registration_scan_batches_ab3') }}
-- voter_registration_scan_batches from {{ source('cta', '_airbyte_raw_voter_registration_scan_batches') }}

