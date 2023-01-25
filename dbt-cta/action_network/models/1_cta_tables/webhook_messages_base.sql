{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('webhook_messages_ab3') }}
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
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_webhook_messages_hashid
from {{ ref('webhook_messages_ab3') }}
-- webhook_messages from {{ source('cta', '_airbyte_raw_webhook_messages') }}
where 1 = 1

