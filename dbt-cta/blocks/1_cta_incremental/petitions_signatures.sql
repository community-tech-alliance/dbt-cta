{{ config(
    cluster_by = ["_airbyte_unique_key","_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_unique_key",
    schema = "sv_blocks",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('petitions_signatures_scd') }}
select
    _airbyte_unique_key,
    city,
    county,
    extras,
    last_name,
    created_at,
    address_two,
    middle_name,
    created_by_user_id,
    petition_packet_id,
    zipcode,
    voter_match_status,
    page_number,
    signature_date,
    updated_at,
    address_one,
    line_number,
    signature_exists,
    reviewer_id,
    phone_number,
    id,
    state,
    first_name,
    email,
    petition_page_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_petitions_signatures_hashid
from {{ ref('petitions_signatures_scd') }}
-- petitions_signatures from {{ source('sv_blocks', '_airbyte_raw_petitions_signatures') }}
where 1 = 1
and _airbyte_active_row = 1
{{ incremental_clause('_airbyte_emitted_at') }}

