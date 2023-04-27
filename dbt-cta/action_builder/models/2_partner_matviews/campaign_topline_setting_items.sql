select
    id,
    item_id,
    imported,
    position,
    item_type,
    created_at,
    updated_at,
    campaign_id,
    targetable_id,
    targetable_type
from {{ source('cta','campaign_topline_setting_items_base') }}
