select
    _airbyte_emitted_at,
    id,
    text,
    title,
    created_at,
    field_type,
    updated_at,
    mobile_message_id
from {{ source('cta','mobile_message_fields_base') }}