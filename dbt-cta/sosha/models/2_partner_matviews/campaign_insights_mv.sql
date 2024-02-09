select *
from {{ source('cta', 'campaign_insights_base') }}
