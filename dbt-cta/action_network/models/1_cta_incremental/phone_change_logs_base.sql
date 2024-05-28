{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('phone_change_logs_ab4') }}
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
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_phone_change_logs_hashid
from {{ ref('phone_change_logs_ab4') }}