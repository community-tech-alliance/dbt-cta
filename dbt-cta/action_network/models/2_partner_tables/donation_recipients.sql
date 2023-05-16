select
    _airbyte_emitted_at,
    id,
    user_id,
    group_id,
    created_at,
    updated_at,
    fundraising_id
from {{ source('cta','donation_recipients_base') }}