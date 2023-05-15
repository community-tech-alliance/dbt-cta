select
    _airbyte_emitted_at,
    id,
    created_at,
    updated_at,
    campaign_id,
    entity_type_id,
    _airbyte_campaign_entity_types_hashid
from {{ source('cta','campaign_entity_types_base') }}