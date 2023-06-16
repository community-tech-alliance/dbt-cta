{{ config(
    cluster_by = ["_airbyte_unique_key","_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_unique_key",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('meetings_scd') }}
select
    _airbyte_unique_key,
    start_time,
    notes,
    updated_at,
    user_id,
    guest_attended,
    end_time,
    cancelled,
    created_at,
    id,
    type,
    location_id,
    person_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_meetings_hashid
from {{ ref('meetings_scd') }}
-- meetings from {{ source('sv_blocks', '_airbyte_raw_meetings') }}
where 1 = 1
and _airbyte_active_row = 1
{{ incremental_clause('_airbyte_emitted_at') }}

