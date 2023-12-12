{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('relationship_types_ab3') }}
select
    updated_at,
    name,
    created_at,
    id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_relationship_types_hashid
from {{ ref('relationship_types_ab3') }}
-- relationship_types from {{ source('cta', '_airbyte_raw_relationship_types') }}

