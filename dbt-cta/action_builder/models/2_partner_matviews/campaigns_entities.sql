select
    id,
    entity_id,
    created_at,
    updated_at,
    campaign_id,
    latest_assessment_id,
    latest_assessment_level
from {{ source('cta','campaigns_entities_base') }}
