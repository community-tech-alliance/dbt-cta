{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('tasks_ab3') }}
select
    taskable_type,
    taskable_id,
    assignee_type,
    updated_at,
    name,
    created_at,
    id,
    assignee_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_tasks_hashid
from {{ ref('tasks_ab3') }}
-- tasks from {{ source('cta', '_airbyte_raw_tasks') }}
