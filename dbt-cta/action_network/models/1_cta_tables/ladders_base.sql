{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('ladders_ab3') }}
select
    id,
    notes,
    stats,
    title,
    hidden,
    status,
    group_id,
    structure,
    created_at,
    creator_id,
    updated_at,
    auto_end_date,
    schedule_action,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_ladders_hashid
from {{ ref('ladders_ab3') }}
-- ladders from {{ source('cta', '_airbyte_raw_ladders') }}
where 1 = 1
