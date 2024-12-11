select
    id,
    text,
    title,
    created_at,
    field_type,
    updated_at,
    mobile_message_id,
    _airbyte_mobile_message_fields_hashid
from {{ source('cta','mobile_message_fields_base') }}
