select
    _airbyte_emitted_at,
    id,
    {{ adapter.quote('to') }},
    {{ adapter.quote('from') }},
    read,
    flagged,
    message,
    user_id,
    group_id,
    created_at,
    updated_at,
    message_type,
    twilio_message_id
from {{ source('cta','sms_messages_base') }}