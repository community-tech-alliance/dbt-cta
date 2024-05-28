{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('steps_ab4') }}
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
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_steps_hashid
from {{ ref('steps_ab4') }}