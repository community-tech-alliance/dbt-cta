select *
from {{ source('cta', 'campaign_subscribers_base') }}
