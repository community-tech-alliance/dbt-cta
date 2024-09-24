select *
from {{ source('cta', 'campaign_configuration_tag_categories_base') }}
