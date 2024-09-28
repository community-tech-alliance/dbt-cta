select *
from {{ source('cta', 'deals_property_history_base') }}
