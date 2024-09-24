select *
from {{ source('cta', 'campaign_participations_base') }}
