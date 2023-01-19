{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('relationships_ab3') }}
select
    id,
    deleted,
    created_at,
    deleted_at,
    updated_at,
    to_entity_id,
    created_by_id,
    deleted_by_id,
    updated_by_id,
    from_entity_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_relationships_hashid
from {{ ref('relationships_ab3') }}
-- relationships from {{ source('cta', '_airbyte_raw_relationships') }}
where 1 = 1

