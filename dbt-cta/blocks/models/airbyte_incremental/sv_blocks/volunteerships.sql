{{ config(
    cluster_by = ["_airbyte_unique_key","_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_unique_key",
    schema = "sv_blocks",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('volunteerships_scd') }}
select
    _airbyte_unique_key,
    event_shift_id,
    updated_at,
    user_id,
    responsibility,
    created_at,
    id,
    responsibility_id,
    person_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_volunteerships_hashid
from {{ ref('volunteerships_scd') }}
-- volunteerships from {{ source('sv_blocks', '_airbyte_raw_volunteerships') }}
where 1 = 1
and _airbyte_active_row = 1
{{ incremental_clause('_airbyte_emitted_at') }}

