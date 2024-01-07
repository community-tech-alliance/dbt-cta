{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('voter_histories_ab3') }}
select
    pct_label,
    vtd_label,
    county,
    created_at,
    voter_reg_number,
    voter_state,
    updated_at,
    voted_party_code,
    voted_county_id,
    election_id,
    id,
    voting_method,
    person_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_voter_histories_hashid
from {{ ref('voter_histories_ab3') }}
-- voter_histories from {{ source('cta', '_airbyte_raw_voter_histories') }}
