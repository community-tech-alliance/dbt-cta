{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('action_assignments_ab3') }}
select
    id,
    action_id,
    created_at,
    updated_at,
    action_entity_id,
    action_assignment_group_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_action_assignments_hashid
from {{ ref('action_assignments_ab3') }}
-- action_assignments from {{ source('cta', '_airbyte_raw_action_assignments') }}
where 1 = 1

