select *
from {{ source('cta', 'campaign_entity_type_configurations_base') }}
