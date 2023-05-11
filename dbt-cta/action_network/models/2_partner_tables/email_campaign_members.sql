select
    _airbyte_emitted_at,
    id,
    email_id,
    created_at,
    updated_at,
    email_campaign_id
from {{ source('cta','email_campaign_members_base') }}