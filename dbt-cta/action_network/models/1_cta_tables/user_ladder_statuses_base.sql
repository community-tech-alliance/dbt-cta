{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('user_ladder_statuses_ab3') }}
select
    id,
    rung_id,
    step_id,
    user_id,
    ladder_id,
    wait_time,
    created_at,
    extra_data,
    updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_user_ladder_statuses_hashid
from {{ ref('user_ladder_statuses_ab3') }}
-- user_ladder_statuses from {{ source('cta', '_airbyte_raw_user_ladder_statuses') }}
where 1 = 1

