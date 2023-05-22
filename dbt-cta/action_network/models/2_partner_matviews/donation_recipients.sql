select
    id,
    user_id,
    group_id,
    created_at,
    updated_at,
    fundraising_id,
    _airbyte_donation_recipients_hashid
from {{ source('cta','donation_recipients_base') }}