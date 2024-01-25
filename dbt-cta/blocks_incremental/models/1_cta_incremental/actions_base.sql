{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id",
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('actions_ab4') }}
select
    actionable_type,
    updated_at,
    actionable_id,
    name,
    extras,
    created_at,
    description,
    id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    _airbyte_normalized_at,
    _airbyte_actions_hashid
from {{ ref('actions_ab4') }}
