{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('shifts_ab3') }}
select
    id,
    timezone,
    target_id,
    created_at,
    updated_at,
    target_type,
    created_by_id,
    deleted_by_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_shifts_hashid
from {{ ref('shifts_ab3') }}
-- shifts from {{ source('cta', '_airbyte_raw_shifts') }}
where 1 = 1

