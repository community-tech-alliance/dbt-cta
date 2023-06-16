{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('petitions_pages_scd') }}
select
    date,
    possible_fraud,
    box_number,
    notes,
    notary_date,
    notary_id,
    signatures_count,
    notary_seal,
    petition_book_id,
    canvasser_id,
    county,
    extras,
    created_at,
    notary_signature,
    signers_county,
    scan_file_data,
    created_by_user_id,
    scan_number,
    canvasser_signature,
    updated_at,
    notary_county,
    shift_id,
    id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_petitions_pages_hashid
from {{ ref('petitions_pages_scd') }}
-- petitions_pages from {{ source('sv_blocks', '_airbyte_raw_petitions_pages') }}

