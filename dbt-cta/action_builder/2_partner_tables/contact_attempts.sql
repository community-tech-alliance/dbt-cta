select
    id,
    action_id,
    entity_id,
    created_at,
    updated_at,
    campaign_id,
    disposition,
    created_by_id,
    contact_info_id,
    action_entity_id,
    contact_info_type
from {{ source('cta','contact_attempts_base') }}
