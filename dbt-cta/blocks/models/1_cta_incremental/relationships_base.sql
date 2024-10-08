{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('relationships_ab3') }}
select
    first_person_id,
    updated_at,
    relationship_type_id,
    second_person_id,
    created_at,
    id,
    type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_relationships_hashid
from {{ ref('relationships_ab3') }}
-- relationships from {{ source('cta', '_airbyte_raw_relationships') }}
