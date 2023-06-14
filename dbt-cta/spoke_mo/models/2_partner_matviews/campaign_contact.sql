select
    zip,
    custom_fields,
    timezone_offset,
    is_opted_out,
    last_name,
    created_at,
    external_id,
    cell,
    assignment_id,
    message_status,
    updated_at,
    error_code,
    id,
    first_name,
    campaign_id,
    _airbyte_campaign_contact_hashid
from {{ source('cta','campaign_contact_base') }}