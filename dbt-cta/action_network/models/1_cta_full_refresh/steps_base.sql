{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('steps_ab3') }}
select
    id,
    uuid,
    rules,
    ladder_id,
    step_type,
    created_at,
    updated_at,
    next_step_id,
    alternate_next_step_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_steps_hashid
from {{ ref('steps_ab3') }}
-- steps from {{ source('cta', '_airbyte_raw_steps') }}
where 1 = 1

