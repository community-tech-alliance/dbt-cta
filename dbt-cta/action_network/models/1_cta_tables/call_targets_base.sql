{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('call_targets_ab3') }}
select
    id,
    uuid,
    bioid,
    status,
    call_id,
    created_at,
    updated_at,
    target_name,
    target_type,
    target_party,
    target_phone,
    target_state,
    call_duration,
    target_country,
    target_district,
    target_position,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_call_targets_hashid
from {{ ref('call_targets_ab3') }}
-- call_targets from {{ source('cta', '_airbyte_raw_call_targets') }}
where 1 = 1

