select
    id,
    user_id,
    group_id,
    created_at,
    updated_at,
    fundraising_id,
    _airbyte_donation_recipients_hashid
from {{ ref('donation_recipients_base') }}