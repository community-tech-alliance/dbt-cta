{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('elections_ab3') }}
select
    date,
    updated_at,
    created_at,
    description,
    id,
    state,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_elections_hashid
from {{ ref('elections_ab3') }}
-- elections from {{ source('cta', '_airbyte_raw_elections') }}

