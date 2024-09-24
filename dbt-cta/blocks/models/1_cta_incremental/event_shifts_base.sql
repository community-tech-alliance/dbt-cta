{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('event_shifts_ab3') }}
select
    start_time,
    event_id,
    updated_at,
    end_time,
    created_at,
    id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_event_shifts_hashid
from {{ ref('event_shifts_ab3') }}
-- event_shifts from {{ source('cta', '_airbyte_raw_event_shifts') }}
