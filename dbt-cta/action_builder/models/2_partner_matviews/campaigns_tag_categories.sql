select
    _airbyte_emitted_at,
    id,
    created_at,
    created_by,
    updated_at,
    campaign_id,
    tag_category_id,
    _airbyte_campaigns_tag_categories_hashid
from {{ source('cta','campaigns_tag_categories_base') }}