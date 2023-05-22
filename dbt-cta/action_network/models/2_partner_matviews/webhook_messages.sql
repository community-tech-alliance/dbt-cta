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
    _airbyte_webhook_messages_hashid
from {{ source('cta','webhook_messages_base') }}