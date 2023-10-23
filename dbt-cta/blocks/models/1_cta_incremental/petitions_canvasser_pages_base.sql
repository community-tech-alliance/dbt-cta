{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('petitions_canvasser_pages_ab3') }}
select
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
from {{ ref('petitions_canvasser_pages_ab3') }}
-- petitions_canvasser_pages from {{ source('cta', '_airbyte_raw_petitions_canvasser_pages') }}

