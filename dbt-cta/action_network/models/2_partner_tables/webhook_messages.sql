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
    error_message
from {{ source('cta','webhook_messages_base') }}