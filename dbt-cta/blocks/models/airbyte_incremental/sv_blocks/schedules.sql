{{ config(
    cluster_by = ["_airbyte_unique_key","_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_unique_key",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('schedules_scd') }}
select
    _airbyte_unique_key,
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
from {{ ref('schedules_scd') }}
-- schedules from {{ source('sv_blocks', '_airbyte_raw_schedules') }}
where 1 = 1
and _airbyte_active_row = 1
{{ incremental_clause('_airbyte_emitted_at') }}

