{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id",
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('imports_ab3') }}
select
    mapping,
    list_id,
    created_at,
    for_phone_bank,
    stored_spreadsheet_data,
    original_spreadsheet_data,
    record_type,
    imported_rows_count,
    mappings,
    updated_at,
    user_id,
    worker_jid,
    id,
    status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_imports_hashid
from {{ ref('imports_ab3') }}
-- imports from {{ source('sv_blocks', '_airbyte_raw_imports') }}

