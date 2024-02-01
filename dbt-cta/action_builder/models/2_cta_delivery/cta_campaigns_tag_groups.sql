select
    _airbyte_emitted_at,
    id,
    created_at,
    updated_at,
    campaign_id,
    tag_group_id,
    _airbyte_campaigns_tag_groups_hashid
from {{ source('cta','campaigns_tag_groups_base') }}
