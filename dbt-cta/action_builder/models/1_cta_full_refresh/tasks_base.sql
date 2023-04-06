{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('tasks_ab3') }}
select
    id,
    resolved,
    created_at,
    object_ref,
    updated_at,
    resolved_at,
    resolved_by_id,
    action_field_id,
    action_entity_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_tasks_hashid
from {{ ref('tasks_ab3') }}
-- tasks from {{ source('cta', '_airbyte_raw_tasks') }}
where 1 = 1

