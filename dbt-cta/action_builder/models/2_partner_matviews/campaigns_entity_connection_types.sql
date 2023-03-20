select
    id,
    created_at,
    updated_at,
    campaign_id,
    entity_connection_type_id
from {{ source('cta','campaigns_entity_connection_types_base') }}
