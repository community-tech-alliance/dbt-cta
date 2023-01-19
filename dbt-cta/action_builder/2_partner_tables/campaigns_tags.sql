select
    id,
    tag_id,
    created_at,
    updated_at,
    campaign_id
from {{ source('cta','campaigns_tags_base') }}
