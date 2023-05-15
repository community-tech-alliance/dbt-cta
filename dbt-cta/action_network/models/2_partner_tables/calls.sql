select
    _airbyte_emitted_at,
    id,
    city,
    uuid,
    email,
    phone,
    state,
    status,
    street,
    country,
    user_id,
    tag_list,
    zip_code,
    last_name,
    created_at,
    first_name,
    updated_at,
    display_name,
    custom_fields,
    twilio_call_sid,
    call_campaign_id,
    originating_system
from {{ source('cta','calls_base') }}