{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('state_party_codes_ab3') }}
select
    code,
    updated_at,
    party_id,
    created_at,
    id,
    state,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_state_party_codes_hashid
from {{ ref('state_party_codes_ab3') }}
-- state_party_codes from {{ source('cta', '_airbyte_raw_state_party_codes') }}
