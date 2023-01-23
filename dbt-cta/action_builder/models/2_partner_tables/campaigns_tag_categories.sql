select
    id,
    created_at,
    created_by,
    updated_at,
    campaign_id,
    tag_category_id
from {{ source('cta','campaigns_tag_categories_base') }}
