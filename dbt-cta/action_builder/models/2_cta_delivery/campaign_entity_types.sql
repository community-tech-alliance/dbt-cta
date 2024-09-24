select *
from {{ source('cta', 'campaign_entity_types_base') }}
