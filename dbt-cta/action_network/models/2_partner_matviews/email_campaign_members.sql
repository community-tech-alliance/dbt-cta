select
    id,
    email_id,
    created_at,
    updated_at,
    email_campaign_id,
    _airbyte_email_campaign_members_hashid
from {{ ref('cta','email_campaign_members_base') }}