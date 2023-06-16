{{ config(
    cluster_by = ["_airbyte_unique_key","_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_unique_key",
    schema = "sv_blocks",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('event_shifts_scd') }}
select
    _airbyte_unique_key,
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
from {{ ref('event_shifts_scd') }}
-- event_shifts from {{ source('sv_blocks', '_airbyte_raw_event_shifts') }}
where 1 = 1
and _airbyte_active_row = 1
{{ incremental_clause('_airbyte_emitted_at') }}

