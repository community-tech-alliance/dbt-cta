select *
from {{ source('cta', 'campaign_topline_setting_items_base') }}
