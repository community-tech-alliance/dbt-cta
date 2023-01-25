{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('phone_change_logs_ab3') }}
select
    id,
    user_id,
    owner_id,
    new_phone,
    old_phone,
    created_at,
    owner_type,
    updated_at,
    source_action_id,
    source_action_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_phone_change_logs_hashid
from {{ ref('phone_change_logs_ab3') }}
-- phone_change_logs from {{ source('cta', '_airbyte_raw_phone_change_logs') }}
where 1 = 1

