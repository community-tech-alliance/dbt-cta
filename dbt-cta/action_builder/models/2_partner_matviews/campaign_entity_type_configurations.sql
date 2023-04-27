select
    id,
    created_at,
    updated_at,
    campaign_id,
    entity_type_id,
    spotlight_icon,
    spotlight_tag_ids
from {{ source('cta','campaign_entity_type_configurations_base') }}
