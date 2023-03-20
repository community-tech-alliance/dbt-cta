{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('shift_times_ab3') }}
select
    id,
    end_time,
    shift_id,
    created_at,
    start_time,
    updated_at,
    day_of_week,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_shift_times_hashid
from {{ ref('shift_times_ab3') }}
-- shift_times from {{ source('cta', '_airbyte_raw_shift_times') }}
where 1 = 1

