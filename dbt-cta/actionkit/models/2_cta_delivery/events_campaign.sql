select *
from {{ source('cta', 'events_campaign_base') }}
