{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('action_entities_ab3') }}
select
    id,
    status,
    action_id,
    entity_id,
    created_at,
    updated_at,
    completed_at,
    pending_count,
    completed_count,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_action_entities_hashid
from {{ ref('action_entities_ab3') }}
-- action_entities from {{ source('cta', '_airbyte_raw_action_entities') }}
where 1 = 1

