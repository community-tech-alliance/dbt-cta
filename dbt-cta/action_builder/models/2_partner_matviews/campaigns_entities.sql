select
    _airbyte_emitted_at,
    id,
    entity_id,
    created_at,
    updated_at,
    campaign_id,
    latest_assessment_id,
    latest_assessment_level,
    _airbyte_campaigns_entities_hashid
from {{ source('cta','campaigns_entities_base') }}
