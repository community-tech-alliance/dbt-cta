select
    is_from_contact,
    campaign_contact_id,
    queued_at,
    created_at,
    media,
    send_before,
    contact_number,
    user_number,
    sent_at,
    assignment_id,
    user_id,
    service,
    service_id,
    send_status,
    messageservice_sid,
    error_code,
    id,
    text,
    service_response_at,
    _airbyte_extracted_at,
    _airbyte_message_hashid
from {{ source('cta','message_base') }}
