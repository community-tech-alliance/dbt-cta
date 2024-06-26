{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('webhook_messages_ab4') }}
select
    id,
    error,
    user_id,
    attempts,
    group_id,
    created_at,
    extra_data,
    trigger_id,
    updated_at,
    webhook_id,
    error_message,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_webhook_messages_hashid
from {{ ref('webhook_messages_ab4') }}
