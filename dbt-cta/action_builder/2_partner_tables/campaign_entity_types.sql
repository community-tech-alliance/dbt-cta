select
    id,
    created_at,
    updated_at,
    campaign_id,
    entity_type_id
from {{ source('cta','campaign_entity_types_base') }}
