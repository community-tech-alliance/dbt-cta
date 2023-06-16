{{ config(
    cluster_by = ["_airbyte_unique_key","_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_unique_key",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('captricity_batches_scd') }}
select
    _airbyte_unique_key,
    rejected_at,
    submitted_at,
    voter_registration_scan_batch_id,
    remote_id,
    created_at,
    reject_reason,
    petition_packet_id,
    api_log,
    imported_at,
    updated_at,
    petitions_book_id,
    id,
    status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_captricity_batches_hashid
from {{ ref('captricity_batches_scd') }}
-- captricity_batches from {{ source('sv_blocks', '_airbyte_raw_captricity_batches') }}
where 1 = 1
and _airbyte_active_row = 1
{{ incremental_clause('_airbyte_emitted_at') }}

