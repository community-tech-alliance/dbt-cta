{{ config(
    cluster_by = ["_airbyte_unique_key","_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_unique_key",
    schema = "sv_blocks",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('petitions_canvasser_pages_scd') }}
select
    _airbyte_unique_key,
    signed_in,
    canvasser_id,
    sign_out_date,
    extras,
    created_at,
    book_id,
    sign_in_date,
    scan_file_data,
    program_type,
    updated_at,
    signed_out,
    shift_id,
    organization_id,
    id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_petitions_canvasser_pages_hashid
from {{ ref('petitions_canvasser_pages_scd') }}
-- petitions_canvasser_pages from {{ source('sv_blocks', '_airbyte_raw_petitions_canvasser_pages') }}
where 1 = 1
and _airbyte_active_row = 1
{{ incremental_clause('_airbyte_emitted_at') }}

