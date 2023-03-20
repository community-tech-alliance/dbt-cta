select
    id,
    position,
    created_at,
    updated_at,
    campaign_id,
    tag_category_id,
    campaign_configuration_target_id,
    campaign_configuration_target_type
from {{ source('cta','campaign_configuration_tag_categories_base') }}
