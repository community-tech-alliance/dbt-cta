select
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
    twilio_message_id,
    _airbyte_sms_messages_hashid
from {{ source('cta','sms_messages_base') }}