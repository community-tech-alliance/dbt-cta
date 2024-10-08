{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('schedules_ab3') }}
select
    date,
    count,
    rule,
    created_at,
    schedulable_type,
    schedulable_id,
    updated_at,
    until,
    {{ adapter.quote('interval') }},
    id,
    time,
    day,
    day_of_week,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_schedules_hashid
from {{ ref('schedules_ab3') }}
-- schedules from {{ source('cta', '_airbyte_raw_schedules') }}
