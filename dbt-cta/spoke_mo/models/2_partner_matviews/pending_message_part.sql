select
    service,
    parent_id,
    service_id,
    service_message,
    created_at,
    id,
    contact_number,
    user_number,
    _airbyte_extracted_at,
    _airbyte_pending_message_part_hashid
from {{ source('cta','pending_message_part_base') }}
