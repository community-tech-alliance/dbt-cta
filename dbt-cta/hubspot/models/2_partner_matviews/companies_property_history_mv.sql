select *
from {{ source('cta', 'companies_property_history_base') }}
