{{ config(
    cluster_by = ["_airbyte_unique_key","_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_unique_key",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('voter_histories_scd') }}
select
    _airbyte_unique_key,
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
from {{ ref('voter_histories_scd') }}
-- voter_histories from {{ source('sv_blocks', '_airbyte_raw_voter_histories') }}
where 1 = 1
and _airbyte_active_row = 1
{{ incremental_clause('_airbyte_emitted_at') }}

