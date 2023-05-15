select
    _airbyte_emitted_at,
    id,
    tag_id,
    created_at,
    updated_at,
    campaign_id,
    _airbyte_campaigns_tags_hashid
from {{ source('cta','campaigns_tags_base') }}