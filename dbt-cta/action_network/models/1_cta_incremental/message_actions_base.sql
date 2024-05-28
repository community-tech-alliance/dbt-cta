{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('message_actions_ab4') }}
select
    id,
    referrer,
    action_id,
    created_at,
    sending_id,
    updated_at,
    action_type,
    sending_type,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_message_actions_hashid
from {{ ref('message_actions_ab4') }}