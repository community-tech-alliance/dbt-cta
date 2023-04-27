select
    id,
    created_at,
    updated_at,
    campaign_id,
    tag_group_id
from {{ source('cta','campaigns_tag_groups_base') }}
