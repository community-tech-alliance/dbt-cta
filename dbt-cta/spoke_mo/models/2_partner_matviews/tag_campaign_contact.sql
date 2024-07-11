select
    campaign_contact_id,
    updated_at,
    tag_id,
    created_at,
    id,
    value,
    _airbyte_emitted_at,
    _airbyte_tag_campaign_contact_hashid
from {{ source('cta','tag_campaign_contact_base') }}